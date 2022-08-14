class ZDRPGSkill: Inventory
{
    int Level;
    int ModulesCost;
    int EPCost;
    int Power;

    property Level        : Level;
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

class ZDRPGHeal : ZDRPGSkill
{
    Default {
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