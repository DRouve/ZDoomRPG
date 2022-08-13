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
        
        // Set default values
        let player = owner.player;
        
        self.Credits = CVar.GetCVar("drpg_start_credits", player).GetInt();
        self.Modules = CVar.GetCVar("drpg_start_modules", player).GetInt();
        self.Medkit  = CVar.GetCVar("drpg_start_medkit",  player).GetInt();

        let Stats = ZDRPGStats.GetStats(owner);

        self.MaxMedkit = Stats.Capacity;
	}
}