class ZDRPGHealFromMod : ZDRPGSkill
{
    Default {
        Tag "HealFromMod";
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