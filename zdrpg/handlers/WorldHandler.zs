class ZDRPGWorldHandler : EventHandler 
{
    /*array <string> mapPacks;

    override void WorldLoaded(WorldEvent e)
    {
        if(!mapPacks.Size())
        {
            int levelsCount = LevelInfo.GetLevelInfoCount();
            for(int i=0; i<levelsCount; i++)
            {
                let level = LevelInfo.GetLevelInfo(i);
                if(level.MapExists(level.MapName))
                {
                    if(i > 0)
                    {
                        let prevLevel = LevelInfo.GetLevelInfo(i-1);
                        if(prevLevel.MapName.Left(prevLevel.MapName.length()-2) == level.MapName.Left(level.MapName.length()-2) || level.LookupLevelName() == "UAC Outpost") 
                            continue;
                    }
                    string mapName = level.MapName.Left(level.MapName.length()-2);
                    string mapPackName = Stringtable.Localize("$C_"..mapName);
                    mapPacks.Push(mapPackName);
                }
            }
        }
    }*/

    override void WorldThingSpawned(WorldEvent e)
    {
        if (e.Thing && e.Thing.bIsMonster)
        {  
            e.Thing.GiveInventory("ZDRPGStats", 1);    
        }
    }

    override void WorldThingDied(WorldEvent e)
    {
        if (e.Thing && e.Thing.bIsMonster && e.Thing.target && !e.Thing.target.bIsMonster)
        {  
            let Stats = ZDRPGStats(e.Thing.target.FindInventory("ZDRPGStats"));
            Stats.Lvl += 1;
            console.printf("level: %d", Stats.Lvl);   
        }
    }

    override void CheckReplacement (ReplaceEvent e)
    {
        let staticHandler = ZDRPGStaticHandler(StaticEventHandler.Find("ZDRPGStaticHandler"));
        if(staticHandler.replacements.Size() > 0)
        {
            array <string> replaceInfo;
            for(int i = 0; i < staticHandler.replacements.size(); i++)
            {
                staticHandler.replacements[i].Split(replaceInfo, ':');
                if (e.Replacee is replaceInfo[0])
                {
                    e.Replacement = replaceInfo[1];
                }
                replaceInfo.clear();
            }
        }
    }
}