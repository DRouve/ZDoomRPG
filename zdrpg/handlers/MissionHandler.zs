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
                    mission.Item = staticHandler.monsters[random(0, staticHandler.monsters.Size()-1)];
                    mission.Amount = 10;
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
            if(missionController.mission) {
                if(missionController.mission.Item == e.Thing.GetClassName()) {
                    missionController.mission.CurrentAmount++;
                    console.printf(missionController.mission.Item .. ": %d", missionController.mission.CurrentAmount);   
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
    
        if(command [0] ~== "addMission" && command.Size() > 1)
        {
            let missionController = ZDRPGMissionController(players[e.Player].mo.FindInventory("ZDRPGMissionController"));
            if(missionController.mission)
            {
                console.printf("mission already exist");
            }
            else
            {
                let encodedMission = command[1];
                array <string> missionParameters;
                encodedMission.split(missionParameters, "&");

                let newMission = new("ZDRPGMission");

                newMission.Difficulty   = GetParameter(missionParameters[0]).ToInt();
                newMission.Type         = GetParameter(missionParameters[1]);
                newMission.Item         = GetParameter(missionParameters[2]);
                newMission.Amount       = GetParameter(missionParameters[3]).ToInt();
                
                newMission.RewardXP      = GetParameter(missionParameters[4]).ToInt();
                newMission.RewardRank    = GetParameter(missionParameters[5]).ToInt();
                newMission.RewardCredits = GetParameter(missionParameters[6]).ToInt();
                newMission.RewardModules = GetParameter(missionParameters[7]).ToInt();

                missionController.mission = ZDRPGMission.Start(newMission);
            }            
        }
    }

    string GetParameter(string parameterString)
    {
        array <string> parameterArray;
        parameterString.split(parameterArray, "=");
        return parameterArray[1];
    }

    /*override void CheckReplacement (ReplaceEvent e)
    {
        /*if (e.Replacee is "Health")
        {
            e.Replacement = "ZDRPGSurgeryKit";
        }
    }*/
}