class ZDRPGSkill: Inventory
{
    int SkillLevel;
    int ModulesCost;
    int EPCost;
    int Power;

    property SkillLevel   : SkillLevel;
    property ModulesCost  : ModulesCost;
    property EPCost       : EPCost;
    property Power        : Power;
    
    Default {
        Inventory.Amount 0;
        Inventory.MaxAmount 1;
        +Inventory.Undroppable;
        +Inventory.PersistentPower;
    }
}

class ZDRPGTransport : ZDRPGSkill
{
    Default {
        Tag "Transport";
        ZDRPGSkill.EPCost 0;
        ZDRPGSkill.Power  50;
    }

    override bool Use(bool pickup)
    {
        let Stats = ZDRPGStats.GetStats(owner);
        if(Stats.LastMap || Level.MapName != 'Outpost')
        {
            let destination = Stats.LastMap;
            Stats.LastMap = Level.MapName;
            if(Level.MapName == 'Outpost')
            {
                Level.ChangeLevel(destination);
                return true;
            }
            Level.ChangeLevel('Outpost');
            return true;
        }
        console.printf('No prev map found');
        return false;
    }
}

class ZDRPGHeal : ZDRPGSkill
{
    Default {
        Tag "Heal";
        ZDRPGSkill.EPCost 25;
        ZDRPGSkill.Power  50;
    }

    override bool Use(bool pickup)
    {
        console.printf("i'm used");
        let Stats = ZDRPGStats.GetStats(owner);
        Stats.EP -= self.EPCost;
        return true;
    }
}

class ZDRPGMagnetize : ZDRPGSkill
{
    Default {
        Tag "Magnetize";
        ZDRPGSkill.EPCost 33;
        ZDRPGSkill.Power  50;
    }

    override bool Use(bool pickup)
    {
        console.printf("i'm used2222222");
        let Stats = ZDRPGStats.GetStats(owner);
        Stats.EP -= self.EPCost;
        return true;
    }
}