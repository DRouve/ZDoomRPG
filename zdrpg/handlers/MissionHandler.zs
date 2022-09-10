class ZDRPGMissionHandler : EventHandler 
{
    array <ZDRPGMission> missions;

    override void WorldLoaded (WorldEvent e) 
    {
        let staticHandler = ZDRPGStaticHandler(StaticEventHandler.Find("ZDRPGStaticHandler"));
        if(Level.MapName == 'Outpost' && staticHandler.monsters.Size() > 0)
        {
            for(int i = 0; i < staticHandler.missionDifficulties.Size(); i++)
            {
                for(int j = 0; j < staticHandler.MAX_MISSIONS; j++)
                {
                    let mission = new("ZDRPGMission");
                    mission.Difficulty = i;
                    mission.Type = staticHandler.missionTypes[random(0, staticHandler.missionTypes.Size()-1)];
                    Name type = mission.Type;
                    switch(type)
                    {
                        case 'Collection':
                            mission.Item = staticHandler.questItems[random(0, staticHandler.questItems.Size()-1)];
                            mission.Amount = 20 + (mission.Difficulty * 20);
                            mission.Icon = 'BBS_M1.png';
                            break;
                        case 'Kill':
                            mission.Item = GetMonsterClass(mission);
                            mission.Amount = 10;
                            mission.Icon = 'BBS_M2.png';
                            break;
                        case 'Kill Auras':
                            mission.Item = GetMonsterClass(mission);
                            mission.Amount = 10;
                            mission.Icon = 'BBS_M3.png';
                            break;
                        case 'Kill Reinforcements':
                            mission.Item = GetMonsterClass(mission);
                            mission.Amount = 10;
                            mission.Icon = 'BBS_M4.png';
                            break;
                        case 'Assassination':
                            mission.Item = GetMonsterClass(mission);
                            mission.Amount = 1;
                            mission.Icon = 'BBS_M5.png';
                            break;
                        case 'Find Secrets':
                            mission.Item = "Secrets";
                            mission.Amount = 3 + (mission.Difficulty * 3);
                            mission.Icon = 'BBS_M6.png';
                            break;
                        case 'Find Items':
                            mission.Item = "Items";
                            mission.Amount = 30 + (mission.Difficulty * 30);
                            mission.Icon = 'BBS_M7.png';
                            break;
                        case 'Achieve Combo':
                            mission.Item = "Combo";
                            mission.Amount = 30 + (mission.Difficulty * 3);
                            mission.Icon = 'BBS_M8.png';
                            break;
                        default:
                            mission.Item = mission.Type;
                            mission.Amount = 10;
                            mission.Icon = 'BBS_M2.png';
                            break;
                    }
                    
                    mission.RewardXP = 1000;
                    mission.RewardRank = 555;
                    mission.RewardCredits = 1000;
                    mission.RewardModules = 111;

                    missions.Push(mission);
                }
            }
        }
    }

    override void WorldThingDied(WorldEvent e)
    {
        if (e.Thing && e.Thing.bIsMonster && e.Thing.target && !e.Thing.target.bIsMonster)
        {  
            let missionController = ZDRPGMissionController(e.Thing.target.FindInventory("ZDRPGMissionController"));
            if(missionController.mission && missionController.mission.isActive) {
                if(missionController.mission.Type=="Kill" && missionController.mission.Item == e.Thing.GetClassName())
                {
                    missionController.mission.CurrentAmount++; 
                } 
            }
        }
    }

    override void NetworkProcess(ConsoleEvent e)
    {
        if (e.Player < 0 || !PlayerInGame[e.Player] || !(players[e.Player].mo))
            return;

        Array<string> command;
        e.Name.Split (command, ":");

        if(e.Name ~== "abortMission")
        {
            let missionController = ZDRPGMissionController(players[e.Player].mo.FindInventory("ZDRPGMissionController"));
            missionController.mission.destroy();
            console.printf("Mission aborted!");
        }
    
        if(command [0] ~== "addMission" && command.Size() > 1)
        {
            let eHandler = ZDRPGMissionHandler(EventHandler.Find("ZDRPGMissionHandler"));
            let missionController = ZDRPGMissionController(players[e.Player].mo.FindInventory("ZDRPGMissionController"));

            let encodedMission = command[1];
            array <string> missionParameters;
            encodedMission.split(missionParameters, "&");

            let newMission = new("ZDRPGMission");

            newMission.Difficulty    = GetParameter(missionParameters[1]).ToInt();
            newMission.Type          = GetParameter(missionParameters[2]);
            newMission.Item          = GetParameter(missionParameters[3]);
            newMission.Amount        = GetParameter(missionParameters[4]).ToInt();
            newMission.CurrentAmount = 0;
            
            newMission.RewardXP      = GetParameter(missionParameters[5]).ToInt();
            newMission.RewardRank    = GetParameter(missionParameters[6]).ToInt();
            newMission.RewardCredits = GetParameter(missionParameters[7]).ToInt();
            newMission.RewardModules = GetParameter(missionParameters[8]).ToInt();
        
            if(newMission.Type == 'Collection')
            {
                let item = Inventory(players[e.Player].mo.FindInventory(newMission.Item));
                if(item)
                    newMission.CurrentAmount = item.Amount;
            }

            missionController.mission = ZDRPGMission.Start(newMission);   
            eHandler.missions.Delete(GetParameter(missionParameters[0]).ToInt()); 
        }

        if(command [0] ~== "removeMissionFromList" && command.Size() > 1)
        {
            let eHandler = ZDRPGMissionHandler(EventHandler.Find("ZDRPGMissionHandler"));
            eHandler.missions.delete(command[1].ToInt());      
        }
    }

    static clearscope string GetParameter(string parameterString)
    {
        array <string> parameterArray;
        parameterString.split(parameterArray, "=");
        return parameterArray[1];
    }

    string GetMonsterClass(ZDRPGMission mission)
    {
        let defaults = RandomizeMonster();
        switch(mission.Difficulty)
        {
            case 0:
                while(GetDifficultyScore(defaults) > 10)
                    defaults = RandomizeMonster();
                break;
            case 1:
                while(GetDifficultyScore(defaults) > 15)
                    defaults = RandomizeMonster();
                break;
            case 2:
            case 3:
                while(GetDifficultyScore(defaults) < 5 && GetDifficultyScore(defaults) > 30)
                    defaults = RandomizeMonster();
                break; 
            case 4:
                while(GetDifficultyScore(defaults) < 10 && GetDifficultyScore(defaults) > 40)
                    defaults = RandomizeMonster();
                break;
            case 5:
                while(GetDifficultyScore(defaults) < 10 && GetDifficultyScore(defaults) > 60)
                    defaults = RandomizeMonster();
                break;
            case 6:
                while(GetDifficultyScore(defaults) < 100 && GetDifficultyScore(defaults) > 150)
                    defaults = RandomizeMonster();
                break;
            case 7:
                while(GetDifficultyScore(defaults) < 140)
                    defaults = RandomizeMonster();
                break;
            case 8:
                while(GetDifficultyScore(defaults) < 300)
                    defaults = RandomizeMonster();
                break;
        }
        return defaults.GetClassName();
    }

    readonly<Actor> RandomizeMonster()
    {
        let staticHandler = ZDRPGStaticHandler(StaticEventHandler.Find("ZDRPGStaticHandler"));
        let monsterClass = staticHandler.monsters[random(0, staticHandler.monsters.Size()-1)];
        return GetDefaultByType((class<Actor>)(monsterClass));
    }

    int GetDifficultyScore(readonly<Actor> actorStats)
    {
        int difficultyScore = 0;
        difficultyScore += actorStats.SpawnHealth() / 10;
        if(actorStats.FindState("Melee") && !actorStats.FindState("Missile"))
            difficultyScore -= 10;

        if(actorStats.Speed > 10)
            difficultyScore += 75;

        DropItem di;
        di = actorStats.GetDropItems(); 
        if (di != null)
		{
            while (di != null)
			{
                if(di.Name == 'Chaingun')
                    difficultyScore += 5;
                
                di = di.Next;
            }
        }
        
        console.printf(actorStats.GetTag() .. ": %d", difficultyScore);
        return difficultyScore;
    }
}