class ZDRPGSkill: Inventory
{
    int SkillLevel;
    int ModulesCost;
    int EPCost;
    int Power;

    string SkillCategory;
    int FontColor;

    property SkillLevel   : SkillLevel;
    property ModulesCost  : ModulesCost;
    property EPCost       : EPCost;
    property Power        : Power;
    
    property SkillCategory : SkillCategory;
    property FontColor : FontColor;
    
    Default {
        Inventory.Amount 0;
        Inventory.MaxAmount 1;
        +Inventory.Undroppable;
        +Inventory.PersistentPower;
    }
}

/*class ZDRPGOffenseSkill : ZDRPGSkill
{
    Default {
        Tag "Offense";
        ZDRPGSkill.FontColor Font.CR_RED;
    }   
}
class ZDRPGSupportSkill : ZDRPGSkill
{
    Default {
        Tag "Support";
        ZDRPGSkill.FontColor Font.CR_BRICK;
    }
}
class ZDRPGSummonSkill : ZDRPGSkill
{
    Default {
        Tag "Summon";
        ZDRPGSkill.FontColor Font.CR_ORANGE;
    }
}
class ZDRPGAuraSkill : ZDRPGSkill
{
    Default {
        Tag "Auras";
        ZDRPGSkill.FontColor Font.CR_CYAN;
    }
}
class ZDRPGPowerupSkill : ZDRPGSkill
{
    Default {
        Tag "Powerups";
        ZDRPGSkill.FontColor Font.CR_GREEN;
    }
}
class ZDRPGUtilitySkill : ZDRPGSkill
{
    Default {
        Tag "Utility";
        ZDRPGSkill.FontColor Font.CR_GREY;
    }
}*/

class ZDRPGTransport : ZDRPGSkill
{
    Default {
        Tag "Transport";
        ZDRPGSkill.EPCost 0;
        ZDRPGSkill.Power  50;
        ZDRPGSkill.SkillCategory "Utility";
        ZDRPGSkill.FontColor Font.CR_GRAY;
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
        ZDRPGSkill.SkillCategory "Support";
        ZDRPGSkill.FontColor Font.CR_BRICK;
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
        ZDRPGSkill.SkillCategory "Support";
        ZDRPGSkill.FontColor Font.CR_BRICK;
    }

    override bool Use(bool pickup)
    {
        console.printf("i'm used2222222");
        let Stats = ZDRPGStats.GetStats(owner);
        Stats.EP -= self.EPCost;
        return true;
    }
}