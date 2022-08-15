class ZDRPGWorldHandler : EventHandler 
{
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
            Stats.Level += 1;
            console.printf("level: %d", Stats.Level);   
        }
    }
}