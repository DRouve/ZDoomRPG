class ZDRPGStats: Inventory
{
    int Strength;
    int Defense;
    int Vitality;
    int Energy;
    int Regeneration;
    int Agility;
    int Capacity;
    int Luck;

    int EP;
    int MaxEP;

    int Level;
    int Rank;

    property Strength     : Strength;
    property Defense      : Defense;
    property Vitality     : Vitality;
    property Energy       : Energy;
    property Regeneration : Regeneration;
    property Agility      : Agility;
    property Capacity     : Capacity;
    property Luck         : Luck;

    property EP           : EP;
    property MaxEP        : MaxEP;

    property Level        : Level;
    property Rank         : Rank;

    Default {
        Inventory.Amount 0;
        Inventory.MaxAmount 1;
        +Inventory.PersistentPower;
        +Inventory.Autoactivate;
    }

    override void AttachToOwner (Actor actor) 
	{
        Super.AttachToOwner(actor); 
        
        // Set default stats
        if(owner.bIsMonster) {
            self.monsterStatsHandler(owner);
        } else {
            self.playerStartStats(owner);
        }

        // Set maximum health & EP
        self.setMaxHealth(owner, self.getMaxHealth(owner));
        self.MaxEP = 100;
        self.EP = self.MaxEP;
	}

    /** 
     *  Sets actor's maxHealth
     *   
     *  @param Actor actor
     *  @return void
     */
    void setMaxHealth(Actor actor, int value) {
        if(!actor.bIsMonster) {
            let actor = PlayerPawn(actor);
            actor.MaxHealth = value;
        }
        actor.A_SetHealth(value);
        
    }

    /**
     *  Returns actor's calculated maxHealth
     *   
     *  @param Actor actor
     *  @return void
     */
    int getMaxHealth(Actor actor) {
        return actor.SpawnHealth() + self.Vitality;
    }

    /**
     *  Set monster's initial stats and update it
     *   
     *  @param Actor actor
     *  @return void
     */
    void monsterStatsHandler(Actor actor)
    {
        self.Strength     = 10;
        self.Defense      = 10;
        self.Vitality     = 100;
        self.Energy       = 100;
        self.Regeneration = 100;
        self.Agility      = 100;
        self.Capacity     = 100;
        self.Luck         = 100;
    }

    /**
     *  Set player's initial stats from settings in Options
     *   
     *  @param Actor actor
     *  @return void
     */
    void playerStartStats(Actor actor)
    {
        let player = actor.player;
        self.Strength     = CVar.GetCVar("drpg_start_strength",     player).GetInt();
        self.Defense      = CVar.GetCVar("drpg_start_defense",      player).GetInt();
        self.Vitality     = CVar.GetCVar("drpg_start_vitality",     player).GetInt();
        self.Energy       = CVar.GetCVar("drpg_start_energy",       player).GetInt();
        self.Regeneration = CVar.GetCVar("drpg_start_regeneration", player).GetInt();
        self.Agility      = CVar.GetCVar("drpg_start_agility",      player).GetInt();
        self.Capacity     = CVar.GetCVar("drpg_start_capacity",     player).GetInt();
        self.Luck         = CVar.GetCVar("drpg_start_luck",         player).GetInt();

        self.Level        = CVar.GetCVar("drpg_start_level", player).GetInt() > 0 ? CVar.GetCVar("drpg_start_level", player).GetInt() : 1; 
        self.Rank         = CVar.GetCVar("drpg_start_rank",  player).GetInt() > 0 ? CVar.GetCVar("drpg_start_rank",  player).GetInt() : 1;
    }

    override void Tick () 
	{
        Super.Tick(); 
        if(owner.health < self.getMaxHealth(owner)) {
            self.regenerateHealth();
        }
	}

    /**
     *  Regenerates actor's health
     *   
     *  @param Actor actor
     *  @return void
     */
    void regenerateHealth() {
        if((GameTic % 35) == 0)
		{
            int hpRestoreAmount = self.Regeneration / 100 + 1;
            if(owner.Health + hpRestoreAmount > self.getMaxHealth(owner)) {
                owner.A_SetHealth(self.getMaxHealth(owner));
            } else {
                owner.GiveBody(self.Regeneration / 100 + 1);
            }
		}
    }

    override void ModifyDamage (int damage, Name damageType, out int newdamage, bool passive, Actor inflictor, Actor source, int flags) 
	{
        if (!passive && damage > 0)
		{
            let targetStats = self.GetStats(source);
            newdamage = damage + (self.Strength - targetStats.Defense); 
            console.printf("Enemy health: %d", source.health);
		}
	}

    static ZDRPGStats GetStats(Actor actor) {
        return ZDRPGStats(actor.FindInventory("ZDRPGStats"));
    }
}