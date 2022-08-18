class ZDRPGAug: Inventory
{
    int Level;
    int UpgradeCost;
    int BatteryConsumption;
    int Power;

    property Level              : Level;
    property UpgradeCost        : UpgradeCost;
    property BatteryConsumption : BatteryConsumption;
    property Power              : Power;
    
    Default {
        Inventory.Amount 0;
        Inventory.MaxAmount 1;
        +Inventory.Undroppable;
        +Inventory.PersistentPower;
    }
}

class ZDRPGAugMuscleReplacer : ZDRPGAug
{
    Default {
        Tag "Muscle Replacer";
        ZDRPGAug.UpgradeCost 25;
        ZDRPGAug.Power  50;
    }

    override bool Use(bool pickup)
    {
        console.printf("aug used");
        //let Stats = ZDRPGStats.GetStats(owner);
        //Stats.EP -= self.EPCost;
        return true;
    }
}

class ZDRPGAugDermalArmor : ZDRPGAug
{
    Default {
        Tag "Dermal Armor";
        ZDRPGAug.UpgradeCost 33;
        ZDRPGAug.Power  50;
    }

    override bool Use(bool pickup)
    {
        console.printf("aug222 used");
        //let Stats = ZDRPGStats.GetStats(owner);
        //Stats.EP -= self.EPCost;
        return true;
    }
}