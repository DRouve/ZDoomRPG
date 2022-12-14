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

    int OldStrength;
    int OldDefense;
    int OldVitality;
    int OldEnergy;
    int OldRegeneration;
    int OldAgility;
    int OldCapacity;
    int OldLuck;

    double WeaponSpeed;

    int MaxHealth;

    int EP;
    int MaxEP;
    int EPCostMultiplier;

    int XP;
    int Lvl;
    int RankXP;
    int RankLvl;

    int OldLvl;
    int OldRankLvl;

    string LastMap;

    // Monster-only stats

    double DamageTakenTable[Players.Size()];
    int XPReward;

    Default 
    {
        Inventory.Amount 1;
        Inventory.MaxAmount 1;
        +Inventory.Undroppable;
        +Inventory.Untossable;
        +Inventory.PersistentPower;
    }

    override void AttachToOwner (Actor other) {
        Super.AttachToOwner(other); 

        int StartMaxHealth;
        int StartMaxEP;
        
        // Set default stats
        if(owner.bIsMonster) {
            self.monsterStatsHandler();
            StartMaxHealth = self.CalculateMonsterMaxHealth();
            StartMaxEP = 100;
        } else {
            self.playerStartStats();
            StartMaxHealth = 50 + ((self.Lvl + 1) / 2) * 5 + self.Vitality * 5;
            StartMaxEP = 50 + ((self.Lvl + 1) / 2) * 5 + self.Energy * 5; 
        }

        // Set maximum health & EP 
        self.setMaxHealth(StartMaxHealth);
        self.MaxEP = StartMaxEP;
        self.EP = self.MaxEP;
	}

    /** 
     *  Set owner's (Actor or Player) maxHealth
     *   
     *  @param int value
     *  @return void
     */
    void setMaxHealth(int value) {
        bool HealPlayer = false;
        if(!owner.bIsMonster) {
            let pp = PlayerPawn(owner);
            if(pp.Health == pp.GetMaxHealth())
                HealPlayer = true;
            pp.MaxHealth = value;
        }
        self.MaxHealth = value;
        if(owner.bIsMonster || (!owner.bIsMonster && HealPlayer))
            owner.A_SetHealth(value);
    }

    void setMaxEP(int value) {
        bool RestoreEP = false;
        if(self.EP == self.MaxEP)
            RestoreEP = true;

        self.MaxEP = value;
        if(RestoreEP)
            self.EP = self.MaxEP;
    }

    /**
     *  Calculate monster's initial MaxHealth
     *   
     *  @param Actor other
     *  @return int
     */
    int CalculateMonsterMaxHealth() {
        let Stats = self.GetStats(owner);

        int Health = owner.SpawnHealth();
        int HealthAddition = owner.SpawnHealth() * CVar.GetCVar("drpg_monster_vitality_effect").GetInt();
        int HealthBoost = (Stats.Vitality * CVar.GetCVar("drpg_monster_vitality_boost").GetInt() * 100) / 100;

        HealthAddition *= Stats.Vitality;
        HealthAddition /= 1000;

        Health += HealthAddition + HealthBoost;

        return Health; 
    }

    /**
     *  Set monster's initial stats and update it
     *   
     *  @return void
     */
    void monsterStatsHandler()
    {
        self.Strength     = 10;
        self.Defense      = 10;
        self.Vitality     = 10;
        self.Energy       = 100;
        self.Regeneration = 100;
        self.Agility      = 100;
        self.Capacity     = 100;
        self.Luck         = 100;

        self.OldStrength     = self.Strength;    
        self.OldDefense      = self.Defense;     
        self.OldVitality     = self.Vitality;   
        self.OldEnergy       = self.Energy;      
        self.OldRegeneration = self.Regeneration;
        self.OldAgility      = self.Agility;     
        self.OldCapacity     = self.Capacity;    
        self.OldLuck         = self.Luck; 

        self.WeaponSpeed  = double(self.Agility) / 100;

        owner.GiveInventory("ZDRPGCredits", random(0, 273));
    }

    /**
     *  Set player's initial stats from settings in Options
     *   
     *  @return void
     */
    void playerStartStats()
    {
        let player = owner.player;

        self.Strength     = CVar.GetCVar("drpg_start_strength",     player).GetInt();
        self.Defense      = CVar.GetCVar("drpg_start_defense",      player).GetInt();
        self.Vitality     = CVar.GetCVar("drpg_start_vitality",     player).GetInt();
        self.Energy       = CVar.GetCVar("drpg_start_energy",       player).GetInt();
        self.Regeneration = CVar.GetCVar("drpg_start_regeneration", player).GetInt();
        self.Agility      = CVar.GetCVar("drpg_start_agility",      player).GetInt();
        self.Capacity     = CVar.GetCVar("drpg_start_capacity",     player).GetInt();
        self.Luck         = CVar.GetCVar("drpg_start_luck",         player).GetInt();     

        self.OldStrength     = self.Strength;    
        self.OldDefense      = self.Defense;     
        self.OldVitality     = self.Vitality;   
        self.OldEnergy       = self.Energy;      
        self.OldRegeneration = self.Regeneration;
        self.OldAgility      = self.Agility;     
        self.OldCapacity     = self.Capacity;    
        self.OldLuck         = self.Luck;        

        self.WeaponSpeed  = double(self.Agility) / 100;

        self.Lvl  = CVar.GetCVar("drpg_start_level", player).GetInt() > 0 ? CVar.GetCVar("drpg_start_level", player).GetInt() : 1; 
        self.RankLvl = CVar.GetCVar("drpg_start_rank",  player).GetInt() > 0 ? CVar.GetCVar("drpg_start_rank",  player).GetInt() : 0;
    }

    override void Tick () 
	{
        Super.Tick(); 
        if(owner) 
        {
            self.StatChangesHandler();

            if(owner.health < self.MaxHealth) 
                self.regenerateHealth();
            
            let Stats = self.GetStats(owner);
            if(Stats.EP < Stats.MaxEP) 
                self.regenerateEP();
        }
	}

    void regenerateHealth() {
        if((GameTic % 35) == 0)
		{
            int hpRestoreAmount = self.Regeneration / 100 + 1;
            if(owner.Health + hpRestoreAmount > self.MaxHealth) {
                owner.A_SetHealth(self.MaxHealth);
            } else {
                owner.GiveBody(self.Regeneration / 100 + 1);
            }
		}
    }

    void regenerateEP() {
        if((GameTic % 35) == 0)
		{
            let Stats = self.GetStats(owner);
            int EPRestoreAmount = self.Regeneration / 100 + 1;
            if(Stats.EP + EPRestoreAmount > Stats.MaxEP) {
                Stats.EP = Stats.MaxEP;
            } else {
                Stats.EP += EPRestoreAmount;
            }
		}
    }

    void StatChangesHandler() {
        let staticHandler = ZDRPGStaticHandler(StaticEventHandler.Find("ZDRPGStaticHandler")); 
        let Stats = self.GetStats(owner);
        let PlayerInventory = ZDRPGPlayerInventory.GetInventory(owner);

        if(Stats.XP >= staticHandler.XPTable[Stats.Lvl])
        {
            Stats.XP -= staticHandler.XPTable[Stats.Lvl];
            int Modules = ((Stats.Lvl + 1) * 100) * CVar.GetCVar("drpg_module_levelfactor", owner.player).GetFloat();
            Stats.Lvl++;
            PlayerInventory.Modules += Modules;
            
            //console.printf("+ modules: %d", Modules);  
            console.printf("Level up!");   
        }

        if(Stats.OldLvl != Stats.Lvl) {
            self.setMaxHealth(self.MaxHealth + ((Stats.Lvl - Stats.OldLvl) * 5));
            self.setMaxEP(self.MaxEP + ((Stats.Lvl - Stats.OldLvl) * 5));
            Stats.OldLvl = Stats.Lvl; 
        }

        if(Stats.OldRankLvl != Stats.RankLvl) {
            Stats.OldRankLvl = Stats.RankLvl; 
        }

        if(Stats.OldStrength != Stats.Strength) {
            Stats.OldStrength = Stats.Strength;
        }

        if(Stats.OldDefense != Stats.Defense) {
            Stats.OldDefense = Stats.Defense;
        }

        if(Stats.OldVitality != Stats.Vitality) {
            self.setMaxHealth(self.MaxHealth + ((Stats.Vitality - Stats.OldVitality) * 5));
            Stats.OldVitality = Stats.Vitality;
        }

        if(Stats.OldEnergy != Stats.Energy) {
            self.setMaxEP(self.MaxEP + ((Stats.Energy - Stats.OldEnergy) * 5));
            Stats.OldEnergy = Stats.Energy;
        }

        if(Stats.OldRegeneration != Stats.Regeneration) {
            Stats.OldRegeneration = Stats.Regeneration;
        }

        if(Stats.OldAgility != Stats.Agility) {
            Stats.WeaponSpeed = double(Stats.Agility) / 100;
            Stats.OldAgility = Stats.Agility;
        }

        if(Stats.OldCapacity != Stats.Capacity) {
            PlayerInventory.UpdateAmmoLimits();
            Stats.OldCapacity = Stats.Capacity;
        }

        if(Stats.OldLuck != Stats.Luck) {
            Stats.OldLuck = Stats.Luck;
        }
    }

    override void ModifyDamage (int damage, Name damageType, out int newdamage, bool passive, Actor inflictor, Actor source, int flags) 
	{
        if (!passive && damage > 0) {
            int targetDefense = 0;
            let targetStats = self.GetStats(source);
            if(targetStats)
                targetDefense = targetStats.Defense;
            newdamage = damage + (self.Strength - targetDefense); 
            console.printf("Enemy health: %d", source.health);
		}

        // calculate damage taken by monster from player to calculate gained XP
        if(passive && owner.bIsMonster && source.player) {
            let MonsterStats = ZDRPGStats.GetStats(owner);
            if(damage >= MonsterStats.CalculateMonsterMaxHealth() && owner.Health == MonsterStats.CalculateMonsterMaxHealth())
                DamageTakenTable[source.PlayerNumber()] += MonsterStats.CalculateMonsterMaxHealth();
            else if(damage >= owner.Health)
                DamageTakenTable[source.PlayerNumber()] += owner.Health;
            else
                DamageTakenTable[source.PlayerNumber()] += owner.Health - (owner.Health - damage);

            console.printf("damage taken: %d", DamageTakenTable[source.PlayerNumber()]); 
        }        
	}

    static ZDRPGStats GetStats(Actor other) {
        return ZDRPGStats(other.FindInventory("ZDRPGStats"));
    }

    void IncreaseStat(int stat)
    {
        int statValue;
        let Stats = ZDRPGStats.GetStats(owner);
        
        switch(stat) {
            case 1:
                statValue = Stats.Strength;
                break;
            case 2:
                statValue = Stats.Defense;
                break;
            case 3:
                statValue = Stats.Vitality;
                break;
            case 4:
                statValue = Stats.Energy;
                break;
            case 5:
                statValue = Stats.Regeneration;
                break;
            case 6:
                statValue = Stats.Agility;
                break;
            case 7:
                statValue = Stats.Capacity;
                break;
            case 8:
                statValue = Stats.Luck;
                break;
        }
        let upgradeCost = ((statValue + 1) * ZDRPGStaticHandler.MODULE_STAT_MULT) * CVar.GetCVar("drpg_module_statfactor", owner.player).GetFloat();
        if (upgradeCost < 0)
            upgradeCost = -upgradeCost;
        else if (upgradeCost == 0)
            upgradeCost = (1 * ZDRPGStaticHandler.MODULE_STAT_MULT) * CVar.GetCVar("drpg_module_statfactor", owner.player).GetFloat();

        let PlayerInventory = ZDRPGPlayerInventory.GetInventory(owner);
        if(PlayerInventory.Modules < upgradeCost)
        {
            console.printf("not enough modules");
            return;
        }

        self.StatUpInt(owner, stat);
        PlayerInventory.Modules -= upgradeCost;
    } 

    static void StatUpInt(Actor other, int stat) 
    {
        let Stats = ZDRPGStats.GetStats(other);
        if(stat == 1) {
            Stats.Strength++;
            console.printf("Strength: %d", Stats.Strength);
        }
        if(stat == 2) {
            Stats.Defense++;
            console.printf("Defense: %d", Stats.Defense);
        }
        if(stat == 3) {
            Stats.Vitality++;
            console.printf("Vitality: %d", Stats.Vitality);
        }
        if(stat == 4) {
            Stats.Energy++;
            console.printf("Energy: %d", Stats.Energy);
        }
        if(stat == 5) {
            Stats.Regeneration++;
            console.printf("Regeneration: %d", Stats.Regeneration);
        }
        if(stat == 6) {
            Stats.Agility++;
            console.printf("Agility: %d", Stats.Agility);
        }
        if(stat == 7) {
            Stats.Capacity++;
            console.printf("Capacity: %d", Stats.Capacity);
        }
        if(stat == 8) {
            Stats.Luck++;
            console.printf("Luck: %d", Stats.Luck);
        }
    }

    static void StatUpString(Actor other, string stat) 
    {
        let Stats = ZDRPGStats.GetStats(other);
        if(stat == "Strength") {
            Stats.Strength++;
            console.printf("Strength: %d", Stats.Strength);
        }
    }
}