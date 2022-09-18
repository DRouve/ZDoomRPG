class ZDRPGPlayerInventory: Inventory
{
    int Credits;
    int Modules;
    int Medkit;
    int TurretParts;

    int MaxMedkit;

    int MaxItems;
    int MaxWeapons;
    int MaxModPacks;

    property Credits : Credits;
    property Modules : Modules;
    property Medkit  : Medkit;

    property MaxMedkit : MaxMedkit;

    property MaxItems    : MaxItems;
    property MaxWeapons  : MaxWeapons;
    property MaxModPacks : MaxModPacks;

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
        
        self.Credits      = CVar.GetCVar("drpg_start_credits",      player).GetInt();
        self.Modules      = CVar.GetCVar("drpg_start_modules",      player).GetInt();
        self.Medkit       = CVar.GetCVar("drpg_start_medkit",       player).GetInt();
        self.TurretParts  = CVar.GetCVar("drpg_start_turretparts",  player).GetInt();

        let Stats = ZDRPGStats.GetStats(owner);

        self.MaxMedkit = Stats.Capacity;

        GiveUtilityItems();
        GiveStartingAmmo();
        GiveStartingWeapons();
        UpdateAmmoLimits();
	}

    void GiveStartingAmmo() {
        let Stats = ZDRPGStats.GetStats(owner);
        let player = owner.player;

        owner.GiveInventory("Clip", 0);
        owner.GiveInventory("Shell", 0);
        owner.GiveInventory("RocketAmmo", 0);
        owner.GiveInventory("Cell", 0);

        let clipAmmo =   Clip(owner.FindInventory("Clip"));
        let shellAmmo =  Shell(owner.FindInventory("Shell"));
        let rocketAmmo = RocketAmmo(owner.FindInventory("RocketAmmo"));
        let cellAmmo =   Cell(owner.FindInventory("Cell"));

        clipAmmo.Amount   = CVar.GetCVar("drpg_start_ammo_bullet", player).GetInt();
        shellAmmo.Amount  = CVar.GetCVar("drpg_start_ammo_shell",  player).GetInt();
        rocketAmmo.Amount = CVar.GetCVar("drpg_start_ammo_rocket", player).GetInt();
        cellAmmo.Amount   = CVar.GetCVar("drpg_start_ammo_cell",   player).GetInt();

        UpdateAmmoLimits();
        
        /*
        // Dynamic owner's ammo pointers acquiring
        // Currently unused
        array <Inventory> ammoPointers;
        GetAmmoArray(ammoPointers);
        for(int i; i<ammoPointers.Size(); i++) {
            let ammo = ammoPointers[i];
            ammo.Amount = 100;
        }
        */
    }

    void GiveStartingWeapons() {
        let player = owner.player;
        if(CVar.GetCVar("drpg_start_weapon_bfg", player).GetBool()) {
            owner.GiveInventory("BFG9000", 1);
        }
        if(CVar.GetCVar("drpg_start_weapon_chaingun", player).GetBool()) {
            owner.GiveInventory("Chaingun", 1);
        }
        if(CVar.GetCVar("drpg_start_weapon_chainsaw", player).GetBool()) {
            owner.GiveInventory("Chainsaw", 1);
        }
        if(CVar.GetCVar("drpg_start_weapon_pistol", player).GetBool()) {
            owner.GiveInventory("Pistol", 1);
        }
        if(CVar.GetCVar("drpg_start_weapon_plasmarifle", player).GetBool()) {
            owner.GiveInventory("PlasmaRifle", 1);
        }
        if(CVar.GetCVar("drpg_start_weapon_rocketlauncher", player).GetBool()) {
            owner.GiveInventory("RocketLauncher", 1);
        }
        if(CVar.GetCVar("drpg_start_weapon_shotgun", player).GetBool()) {
            owner.GiveInventory("Shotgun", 1);
        }
        if(CVar.GetCVar("drpg_start_weapon_ssg", player).GetBool()) {
            owner.GiveInventory("SuperShotgun", 1);
        }
    }

    void UpdateAmmoLimits() {
        let Stats = ZDRPGStats.GetStats(owner);

        owner.SetAmmoCapacity("Clip",       Stats.Capacity + 40);
        owner.SetAmmoCapacity("Shell",      Stats.Capacity / 2 + 10);
        owner.SetAmmoCapacity("RocketAmmo", Stats.Capacity / 10 + 5);
        owner.SetAmmoCapacity("Cell",       Stats.Capacity / 2 + 20);
    }
    
    void GiveUtilityItems() {
        owner.GiveInventory("ZDRPGMedkitActivator", 1);
        //owner.GiveInventory("ZDRPGShieldActivator", 1);
    }

    static ZDRPGPlayerInventory GetInventory(Actor actor) {
        return ZDRPGPlayerInventory(actor.FindInventory("ZDRPGPlayerInventory"));
    }

    // Dynamic owner's ammo pointers acquiring
    // Currently unused
    /*
    void GetAmmoArray(out array <Inventory> ammoPointers) 
    {   class<Inventory> ammoNames[4] = {
            "Clip",
            "Shell",
            "RocketAmmo",
            "Cell"
        };

        for(int i; i<ammoNames.Size(); i++) {
            Inventory item = owner.FindInventory(ammoNames[i]);
            ammoPointers.Push(item);
        }
    }
    */
}