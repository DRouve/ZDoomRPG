class RPG 
{
    // Initializes an item and adds it to the Items array
    static void ItemInit()
    {
        int TID;
        /*
        // Delay while the Items array is being initialized
        while (!ItemTIDsInitialized) Delay(1);

        // [KS] Some items cease existing once they're added to inventory
        // If that's the case, return early so we don't add empty item info
        if (ClassifyActor(0) == ACTOR_WORLD)
            return;

        // Add to Items array
        for (int i = 0; i < MAX_ITEMS; i++)
            if (ItemTIDs[i] == -1)
            {
                if (DebugLog)
                    Log("\CdDEBUG: \C-Item \Cd%S\C- added (Index \Cd%d\C-)", GetActorClass(0), i);

                // Doesn't have a TID, so assign it one
                if (ActivatorTID() == 0)
                {
                    TID = UniqueTID();
                    ItemTIDs[i] = TID;
                    Thing_ChangeTID(0, TID);
                }
                else
                    ItemTIDs[i] = ActivatorTID();

                break;
            }
        */
    } 
}

class RPGSystem : Inventory 
{
	Default 
	{
		inventory.maxamount 1;
        +INVENTORY.AUTOACTIVATE;
	}
	
	/*override void ModifyDamage (int damage, Name damageType, out int newdamage, bool passive, Actor inflictor, Actor source, int flags) 
	{
        if (!passive && damage > 0)
		{
            let pp = DRPGDoomPlayer(owner);
            newdamage = damage + pp.Luck;
		}
	}*/
}

