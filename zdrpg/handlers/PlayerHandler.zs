class ZDRPGPlayerHandler : EventHandler 
{
    override void PlayerSpawned(PlayerEvent e)
    {
        PlayerInfo player = players[e.PlayerNumber];
        player.mo.GiveInventory("ZDRPGStats", 1);
        player.mo.GiveInventory("ZDRPGPlayerInventory", 1);   
        player.mo.GiveInventory("ZDRPGMedkitActivator", 1);   
        player.mo.GiveInventory("ZDRPGShieldActivator", 1);   

        // adding skills and augs
        for (int i=0; i<allactorclasses.size(); i++) {
            if ((allactorclasses[i] is 'ZDRPGSkill' && allactorclasses[i].getClassName() != 'ZDRPGSkill') 
            ||  (allactorclasses[i] is 'ZDRPGAug'   && allactorclasses[i].getClassName() != 'ZDRPGAug')) {
                player.mo.GiveInventory(allactorclasses[i].GetClassName(), 1);
            }
        }

        int lump;
        lump = Wads.FindLump("verylonglumpname");
        if(lump)
        {
            string jsonSkills = Wads.ReadLump(lump);
            console.printf("lump: %s", jsonSkills);
        }
        //whatever.Replace("\r","");
    }

    override void NetworkProcess(ConsoleEvent e)
    {
        if (e.Player < 0 || !PlayerInGame[e.Player] || !(players[e.Player].mo))
            return;

        /*Array<string> command;
        e.Name.Split (command, ":");
    
        if(command [0] ~== "statUp" && command.Size() > 1)
        {
            ZDRPGStats.StatUp(players[e.Player], command[1]);
        }*/
        
        
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

        if (e.Name ~== "UseMedkit" && players[e.Player].mo.health > 0)
        {
            let item = players[e.Player].mo.FindInventory("ZDRPGMedkitActivator");
            if (item)
                item.Use(true);
        }
    }
}