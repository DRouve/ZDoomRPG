class ZDRPGPlayerInventory: Inventory
{
    int Credits;
    int Modules;
    int Medkit;

    int MaxMedkit;

    property Credits   : Credits;
    property Modules   : Modules;
    property Medkit    : Medkit;

    property MaxMedkit : MaxMedkit;

    Default {
        Inventory.Amount 0;
        Inventory.MaxAmount 1;
        +Inventory.PersistentPower;
        +Inventory.Autoactivate;
    }

    override void AttachToOwner (Actor other) 
	{
        Super.AttachToOwner(other); 
        let player = other.player;
        let Stats = ZDRPGStats.GetStats(other); 
        
        // Set default values
        self.Credits = CVar.GetCVar("drpg_start_credits", player).GetInt();
        self.Modules = CVar.GetCVar("drpg_start_modules", player).GetInt();
        self.Medkit  = CVar.GetCVar("drpg_start_medkit",  player).GetInt();

        self.MaxMedkit = Stats.Capacity;
        console.printf("Capacity: %d", Stats.Capacity);
        console.printf("MaxMedkit: %d", self.MaxMedkit);
	}
}