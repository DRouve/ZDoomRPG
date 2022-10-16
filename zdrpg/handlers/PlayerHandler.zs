class ZDRPGPlayerHandler : EventHandler 
{
    override void WorldLoaded(WorldEvent e)
    {
        for(int i = 0; i<Players.Size(); i++)
		{
            let playerMo = Players[i].mo;
			if(playerMo)
			{
                if(!playerMo.CountInv("ZDRPGStats"))
                    playerMo.GiveInventory("ZDRPGStats", 1);
                if(!playerMo.CountInv("ZDRPGPlayerInventory"))
                    playerMo.GiveInventory("ZDRPGPlayerInventory", 1);
                if(!playerMo.CountInv("ZDRPGMedkitActivator"))  
                    playerMo.GiveInventory("ZDRPGMedkitActivator", 1);  
                //if(!playerMo.CountInv("ZDRPGShieldActivator")) 
                //    playerMo.GiveInventory("ZDRPGShieldActivator", 1);   
                if(!playerMo.CountInv("ZDRPGWeaponSpeedScaling")) 
                    playerMo.GiveInventory("ZDRPGWeaponSpeedScaling", 1);
                if(!playerMo.CountInv("ZDRPGMissionController")) 
                    playerMo.GiveInventory("ZDRPGMissionController", 1);
                if(!playerMo.CountInv("ZDRPGShield")) 
                    playerMo.GiveInventory("ZDRPGShield", 1);

                // adding skills and augs
                for (int j=0; j<allactorclasses.size(); j++) {
                    if (
                        (allactorclasses[j] is 'ZDRPGSkill' && allactorclasses[j].getClassName() != 'ZDRPGSkill') 
                    ||  (allactorclasses[j] is 'ZDRPGAug'   && allactorclasses[j].getClassName() != 'ZDRPGAug')
                    && !playerMo.CountInv(allactorclasses[j].GetClassName())
                    )
                        playerMo.GiveInventory(allactorclasses[j].GetClassName(), 1);
                }
            }            
        }
    }

    /*override void WorldUnloaded(WorldEvent e)
    {
        for(int i = 0; i<Players.Size(); i++)
        {
            let playerMo = Players[i].mo;
            if(playerMo)
            {
                let MissionController = ZDRPGMissionController(playerMo.FindInventory("ZDRPGMissionController"));
                if(MissionController)
                {
                    MissionController.OldSecretCount = 0;
                }
            }
        }
    }*/

    /*override void PlayerSpawned(PlayerEvent e)
    {
        PlayerInfo player = players[e.PlayerNumber];
        
        let Stats = ZDRPGStats.GetStats(player.mo);
        if(Stats)
        {
            console.printf('Str: %d', Stats.Strength);
        }

        if(!player.mo.CountInv("ZDRPGStats"))        
            player.mo.GiveInventory("ZDRPGStats", 1);
        if(!player.mo.CountInv("ZDRPGPlayerInventory"))
            player.mo.GiveInventory("ZDRPGPlayerInventory", 1);   
        if(!player.mo.CountInv("ZDRPGMedkitActivator"))
            player.mo.GiveInventory("ZDRPGMedkitActivator", 1);   
        if(!player.mo.CountInv("ZDRPGShieldActivator"))
            player.mo.GiveInventory("ZDRPGShieldActivator", 1);   

        // adding skills and augs
        for (int i=0; i<allactorclasses.size(); i++) {
            if ((allactorclasses[i] is 'ZDRPGSkill' && allactorclasses[i].getClassName() != 'ZDRPGSkill') 
            ||  (allactorclasses[i] is 'ZDRPGAug'   && allactorclasses[i].getClassName() != 'ZDRPGAug'))
                player.mo.GiveInventory(allactorclasses[i].GetClassName(), 1);
        }
        
        //if(Level.MapName != 'Outpost')
        //{
            /*let Stats = ZDRPGStats.GetStats(player.mo);
            Stats.LastMap = Level.MapName;
            console.printf(player.mo.getClassName());
            console.printf(Stats.LastMap);*/
        //}
        

        /*int lump;
        lump = Wads.FindLump("verylonglumpname");
        if(lump)
        {
            string jsonSkills = Wads.ReadLump(lump);
            console.printf("lump: %s", jsonSkills);
        }
        
        int levelsCount = LevelInfo.GetLevelInfoCount();
        for(int i=0; i<levelsCount; i++)
        {
            let level = LevelInfo.GetLevelInfo(i);
            if(level.MapExists(level.MapName))
            {
                string mapName = level.MapName;
                mapName.DeleteLastCharacter();
                mapName.DeleteLastCharacter();
                string mapPackName = Stringtable.Localize("$C_"..mapName);

                console.printf(level.LookupLevelName());
                console.printf(mapPackName);
                console.printf("");
                //console.printf(level.LevelName);
                
                
            }
        }*/
        //whatever.Replace("\r","");
    //}

    override void NetworkProcess(ConsoleEvent e)
    {
        if (e.Player < 0 || !PlayerInGame[e.Player] || !(players[e.Player].mo))
            return;

        /*Array<string> command;
        e.Name.Split (command, ":");
    
        */
        
        
        string eString = e.Name;
        if(eString.IndexOf("useSkill") >= 0) 
        {
            Array <String> skillname;
            e.Name.split(skillname, ":");
            if (skillname.Size() != 0) {
                let Skill = players[e.Player].mo.FindInventory(skillname[1]);
                if (Skill)
                    Skill.Use(true);
            } 

            //let eHandler = ZDRPGMissionHandler(EventHandler.Find("ZDRPGMissionHandler"));
            //if(eHandler.Missions.Size() > 0)
            //{
            //    players[e.Player].mo.GiveInventory(eHandler.Missions[0].GetClassName(), 1);
            //}
            
        }

        if(eString.IndexOf("statUp") >= 0) 
        {
            Array <String> stat;
            e.Name.split(stat, ":");
            if (stat.Size() != 0) {
                let Stats = ZDRPGStats.GetStats(players[e.Player].mo);
                if (Stats)
                    Stats.IncreaseStat(stat[1].ToInt());
            } 
        }

        if(eString.IndexOf("activateAug") >= 0) 
        {
            Array <String> augname;
            e.Name.split(augname, ":");
            if (augname.Size() != 0) {
                let Aug = players[e.Player].mo.FindInventory(augname[1]);
                if (Aug)
                    Aug.Use(true);
            } 
        }

        if(eString.IndexOf("equipShield") >= 0) 
        {
            Array <String> shieldName;
            e.Name.split(shieldName, ":");
            if (shieldName.Size() != 0) {
                let Shield = ZDRPGShield(players[e.Player].mo.FindInventory("ZDRPGShield"));
                let ShieldPart = ZDRPGShieldPart(players[e.Player].mo.FindInventory(shieldName[1]));
                string msg;
                if (Shield && ShieldPart)
                {
                    if(ShieldPart is "ZDRPGShieldBody")
                    {
                        Shield.Body = Shield.Body == ShieldPart ? Null : ShieldPart;
                        msg = "Shield Body";
                    }
                    if(ShieldPart is "ZDRPGShieldBattery")
                    {
                        Shield.Battery = Shield.Battery == ShieldPart ? Null : ShieldPart;
                        msg = "Shield Battery";
                    }
                    if(ShieldPart is "ZDRPGShieldCapacitor")
                    {
                        Shield.Capacitor = Shield.Capacitor == ShieldPart ? Null : ShieldPart;
                        msg = "Shield Capacitor";
                    }
                    if(ShieldPart is "ZDRPGShieldAccessory")
                    {
                        Shield.Accessory = Shield.Accessory == ShieldPart ? Null : ShieldPart;
                        msg = "Shield Accessory";
                    }
                        
                    Shield.CalculateShieldStats();
                    console.printf(msg .. " equipped");
                }
            } 
        }

        if (e.Name ~== "UseMedkit" && players[e.Player].mo.health > 0)
        {
            let item = players[e.Player].mo.FindInventory("ZDRPGMedkitActivator");
            if (item)
                item.Use(true);
        }

        if (e.Name ~== "ToggleShield" && players[e.Player].mo.health > 0)
        {
            let item = ZDRPGShield(players[e.Player].mo.FindInventory("ZDRPGShield"));
            if (item)
                item.ToggleShield();
        }
    }
}