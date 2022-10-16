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
        if (e.Thing && e.Thing.bIsMonster)
        {  
            let MonsterStats = ZDRPGStats.GetStats(e.Thing);
            for(int i = 0; i < Players.Size(); i++)
            {
                if(PlayerInGame[i] && MonsterStats.DamageTakenTable[i]) {
                    double DamageMultiplier;
                    if(MonsterStats.DamageTakenTable[i] >= MonsterStats.CalculateMonsterMaxHealth())
                        DamageMultiplier = 1.0;
                    else 
                        DamageMultiplier = MonsterStats.DamageTakenTable[i] / MonsterStats.CalculateMonsterMaxHealth();

                    console.printf("table: %f", MonsterStats.DamageTakenTable[i] / MonsterStats.CalculateMonsterMaxHealth());   
                    
                    let Stats = ZDRPGStats.GetStats(Players[i].mo);
                    int XPAmount = 100 * DamageMultiplier;
                    Stats.XP += XPAmount;
                    console.printf("xp: %d", Stats.XP);   
                    let staticHandler = ZDRPGStaticHandler(StaticEventHandler.Find("ZDRPGStaticHandler")); 
                    console.printf("table: %d", staticHandler.XPTable[Stats.Lvl]);
                }
            }
            
            array <string> creditsList;
            Actor spawnedCredits;

            let credits = ZDRPGCredits(e.Thing.FindInventory("ZDRPGCredits"));
            let enemyCreditsAmount = credits.Amount;
            console.printf("before: %d", enemyCreditsAmount);
            while(enemyCreditsAmount >= 1000)
            {
                creditsList.Push("ZDRPGCredits1000");
                enemyCreditsAmount -= 1000;
            }

            while(enemyCreditsAmount >= 500)
            {
                creditsList.Push("ZDRPGCredits500");
                enemyCreditsAmount -= 500;
            }
                
                
            while(enemyCreditsAmount >= 250)
            {
                creditsList.Push("ZDRPGCredits250");
                enemyCreditsAmount -= 250;
            }

            while(enemyCreditsAmount >= 100)
            {
                creditsList.Push("ZDRPGCredits100");
                enemyCreditsAmount -= 100;
            }

            while(enemyCreditsAmount >= 50)
            {
                creditsList.Push("ZDRPGCredits50");
                enemyCreditsAmount -= 50;
            }

            while(enemyCreditsAmount >= 20)
            {
                creditsList.Push("ZDRPGCredits20");
                enemyCreditsAmount -= 20;
            }

            while(enemyCreditsAmount >= 10)
            {
                creditsList.Push("ZDRPGCredits10");
                enemyCreditsAmount -= 10;
            }

            while(enemyCreditsAmount >= 5 )
            {
                creditsList.Push("ZDRPGCredits5");
                enemyCreditsAmount -= 5;
            }

            console.printf("after: %d", enemyCreditsAmount);

            for(int i = 0; i < enemyCreditsAmount; i++)
                creditsList.Push("ZDRPGCredits1");

            for(int i = 0; i < creditsList.Size(); i++)
            {
                spawnedCredits = Actor.Spawn(creditsList[i], (e.Thing.pos.x, e.Thing.pos.y, e.Thing.z * 1.5));
                spawnedCredits.vel +=(frandom(-1,1),frandom(-1,1),5);
            }
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