class ZDRPGSkill: Inventory
{
    int SkillLevel;
    int MaxLevel;
    int ModulesCost;
    int EPCost;
    int Power;

    string SkillCategory;
    int FontColor;

    string Icon;

    array <string> Descriptions;

    property SkillLevel   : SkillLevel;
    property MaxLevel     : MaxLevel;
    property ModulesCost  : ModulesCost;
    property EPCost       : EPCost;
    property Power        : Power;
    
    property SkillCategory : SkillCategory;
    property FontColor     : FontColor;

    property Icon : Icon;

    property Descriptions : Descriptions;
    
    Default {
        Inventory.Amount 0;
        Inventory.MaxAmount 1;
        +Inventory.Undroppable;
        +Inventory.PersistentPower;
        
        ZDRPGSkill.SkillLevel 0;
        ZDRPGSkill.MaxLevel 1;
        ZDRPGSkill.EPCost     0;
        ZDRPGSkill.ModulesCost 250;
    }

    void UpgradeSkill()
    {
        if(self.SkillLevel == self.MaxLevel)
            return;
        
        let PlayerInventory = ZDRPGPlayerInventory.GetInventory(owner);
        let UpgradeCost = (self.SkillLevel + 1) * self.ModulesCost;
        if(PlayerInventory.Modules < UpgradeCost)
        {
            console.printf("Not enough modules");
            return;
        }
        PlayerInventory.Modules -= (self.SkillLevel + 1) * self.ModulesCost;

        self.SkillLevel++;
    }

    override bool Use(bool pickup)
    {
        if(self.SkillLevel == 0) {
            console.printf("You don't know this skill yet");
            return false;
        }
        let Stats = ZDRPGStats.GetStats(owner);
        if(Stats.EP < self.EPCost)
        {
            console.printf("Not enough EP");
            return false;
        }

        self.SkillEffect();

        Stats.EP -= self.SkillLevel * self.EPCost;
        return true;
    }

    virtual void SkillEffect() {}
}

class ZDRPGSupportSkill : ZDRPGSkill
{
    Default {
        Tag "Support";
        ZDRPGSkill.FontColor Font.CR_BRICK;
    }
}

class ZDRPGPowerupSkill : ZDRPGSkill
{
    Default {
        Tag "Powerups";
        ZDRPGSkill.FontColor Font.CR_DARKGREEN;
    }
}

class ZDRPGAuraSkill : ZDRPGSkill
{
    Default {
        Tag "Auras";
        ZDRPGSkill.FontColor Font.CR_LIGHTBLUE;
    }
}

class ZDRPGOffenseSkill : ZDRPGSkill
{
    Default {
        Tag "Offense";
        ZDRPGSkill.FontColor Font.CR_RED;
    }   
}

class ZDRPGSummonSkill : ZDRPGSkill
{
    Default {
        Tag "Summon";
        ZDRPGSkill.FontColor Font.CR_ORANGE;
    }
}

class ZDRPGUtilitySkill : ZDRPGSkill
{
    Default {
        Tag "Utility";
        ZDRPGSkill.FontColor Font.CR_GREY;
    }
}

// Support

class ZDRPGSkillHeal : ZDRPGSupportSkill
{
    Default {
        Tag "Heal";
        ZDRPGSkill.SkillLevel 1;
        ZDRPGSkill.MaxLevel   4;
        ZDRPGSkill.EPCost     50;
        ZDRPGSkill.Icon "S_Heal.png";
    }

    override void SkillEffect()
    {
        //self.UpgradeSkill();
        //self.SkillLevel++;
        console.printf("skillLevel: %d", self.SkillLevel);
    }
}

class ZDRPGSkillHealSummons : ZDRPGSupportSkill
{
    Default {
        Tag "Heal Summons";
        ZDRPGSkill.EPCost 150;
        ZDRPGSkill.Icon "S_Heal2.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillDecontamination : ZDRPGSupportSkill
{
    Default {
        Tag "Decontamination";
        ZDRPGSkill.EPCost 300;
        ZDRPGSkill.Icon "S_Decont.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillRepairArmor : ZDRPGSupportSkill
{
    Default {
        Tag "Repair Armor";
        ZDRPGSkill.EPCost 150;
        ZDRPGSkill.Icon "S_RArmor.png";
    }

    override void SkillEffect()
    {
        
    }
}

// Powerups

class ZDRPGSkillInvulnerability : ZDRPGPowerupSkill
{
    Default {
        Tag "Invulnerability";
        ZDRPGSkill.MaxLevel 2;
        ZDRPGSkill.EPCost 500;
        ZDRPGSkill.Icon "S_Invuln.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillInvisibility : ZDRPGPowerupSkill
{
    Default {
        Tag "Invisibility";
        ZDRPGSkill.MaxLevel 2;
        ZDRPGSkill.EPCost 150;
        ZDRPGSkill.Icon "S_Invis.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillTimeFreeze : ZDRPGPowerupSkill
{
    Default {
        Tag "Time Freeze";
        ZDRPGSkill.MaxLevel 2;
        ZDRPGSkill.EPCost 200;
        ZDRPGSkill.Icon "S_TFreez.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillEnviroShield : ZDRPGPowerupSkill
{
    Default {
        Tag "Enviro-Shield";
        ZDRPGSkill.EPCost 100;
        ZDRPGSkill.Icon "S_ENShld.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillNightVision : ZDRPGPowerupSkill
{
    Default {
        Tag "Night Vision";
        ZDRPGSkill.EPCost 150;
        ZDRPGSkill.Icon "S_NVisi.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillBerserk : ZDRPGPowerupSkill
{
    Default {
        Tag "Berserk";
        ZDRPGSkill.EPCost 300;
        ZDRPGSkill.Icon "S_Berser.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillMentalMapping : ZDRPGPowerupSkill
{
    Default {
        Tag "Berserk";
        ZDRPGSkill.EPCost 500;
        ZDRPGSkill.Icon "S_MMap.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSupplyDrop : ZDRPGPowerupSkill
{
    Default {
        Tag "Supply Drop";
        ZDRPGSkill.MaxLevel 3;
        ZDRPGSkill.EPCost 150;
        ZDRPGSkill.Icon "S_SuDrop.png";
    }

    override void SkillEffect()
    {
        
    }
}

// Auras

class ZDRPGSkillRedAura : ZDRPGAuraSkill
{
    Default {
        Tag "Red Aura";
        ZDRPGSkill.MaxLevel 6;
        ZDRPGSkill.EPCost 125;
        ZDRPGSkill.Icon "S_Aura1.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillGreenAura : ZDRPGAuraSkill
{
    Default {
        Tag "Green Aura";
        ZDRPGSkill.MaxLevel 5;
        ZDRPGSkill.EPCost 125;
        ZDRPGSkill.Icon "S_Aura2.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillWhiteAura : ZDRPGAuraSkill
{
    Default {
        Tag "White Aura";
        ZDRPGSkill.MaxLevel 2;
        ZDRPGSkill.EPCost 150;
        ZDRPGSkill.Icon "S_Aura3.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillPinkAura : ZDRPGAuraSkill
{
    Default {
        Tag "Pink Aura";
        ZDRPGSkill.MaxLevel 3;
        ZDRPGSkill.EPCost 150;
        ZDRPGSkill.Icon "S_Aura4.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillBlueAura : ZDRPGAuraSkill
{
    Default {
        Tag "Blue Aura";
        ZDRPGSkill.MaxLevel 4;
        ZDRPGSkill.EPCost 150;
        ZDRPGSkill.Icon "S_Aura5.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillPurpleAura : ZDRPGAuraSkill
{
    Default {
        Tag "Purple Aura";
        ZDRPGSkill.MaxLevel 3;
        ZDRPGSkill.EPCost 150;
        ZDRPGSkill.Icon "S_Aura6.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillOrangeAura : ZDRPGAuraSkill
{
    Default {
        Tag "Orange Aura";
        ZDRPGSkill.MaxLevel 3;
        ZDRPGSkill.EPCost 150;
        ZDRPGSkill.Icon "S_Aura7.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillDarkBlueAura : ZDRPGAuraSkill
{
    Default {
        Tag "Dark Blue Aura";
        ZDRPGSkill.MaxLevel 4;
        ZDRPGSkill.EPCost 150;
        ZDRPGSkill.Icon "S_Aura8.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillYellowAura : ZDRPGAuraSkill
{
    Default {
        Tag "Yellow Aura";
        ZDRPGSkill.MaxLevel 4;
        ZDRPGSkill.EPCost 150;
        ZDRPGSkill.Icon "S_Aura9.png";
    }

    override void SkillEffect()
    {
        
    }
}

// Offense

class ZDRPGSkillWeaken : ZDRPGOffenseSkill
{
    Default {
        Tag "Weaken";
        ZDRPGSkill.MaxLevel 5;
        ZDRPGSkill.EPCost 100;
        ZDRPGSkill.Icon "S_Weaken.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillTranslocate : ZDRPGOffenseSkill
{
    Default {
        Tag "Translocate";
        ZDRPGSkill.EPCost 50;
        ZDRPGSkill.Icon "S_Transl.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillRepulsion : ZDRPGOffenseSkill
{
    Default {
        Tag "Repulsion";
        ZDRPGSkill.MaxLevel 4;
        ZDRPGSkill.EPCost 50;
        ZDRPGSkill.Icon "S_Repuls.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillAuraSteal : ZDRPGOffenseSkill
{
    Default {
        Tag "Aura Steal";
        ZDRPGSkill.EPCost 300;
        ZDRPGSkill.Icon "S_AuraSt.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSoulSteal : ZDRPGOffenseSkill
{
    Default {
        Tag "Soul Steal";
        ZDRPGSkill.EPCost 50;
        ZDRPGSkill.Icon "S_SoulSt.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillDisruption : ZDRPGOffenseSkill
{
    Default {
        Tag "Disruption";
        ZDRPGSkill.EPCost 50;
        ZDRPGSkill.Icon "S_Disrpt.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillPlasmaBeam : ZDRPGOffenseSkill
{
    Default {
        Tag "Plasma Beam";
        ZDRPGSkill.MaxLevel 3;
        ZDRPGSkill.EPCost 50;
        ZDRPGSkill.Icon "S_PlsBea.png";
    }

    override void SkillEffect()
    {
        
    }
}

// Summon

class ZDRPGSkillSummonMarine : ZDRPGSummonSkill
{
    Default {
        Tag "Summon Marine";
        ZDRPGSkill.MaxLevel 8;
        ZDRPGSkill.EPCost 60;
        ZDRPGSkill.Icon "S_Summon.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSummonFormerHuman : ZDRPGSummonSkill
{
    Default {
        Tag "Summon Former Human";
        ZDRPGSkill.EPCost 150;
        ZDRPGSkill.Icon "S_Summon.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSummonFormerSergeant : ZDRPGSummonSkill
{
    Default {
        Tag "Summon Former Sergeant";
        ZDRPGSkill.EPCost 120;
        ZDRPGSkill.Icon "S_Summon.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSummonFormerCommando : ZDRPGSummonSkill
{
    Default {
        Tag "Summon Former Commando";
        ZDRPGSkill.EPCost 250;
        ZDRPGSkill.Icon "S_Summon.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSummonImp : ZDRPGSummonSkill
{
    Default {
        Tag "Summon Imp";
        ZDRPGSkill.EPCost 120;
        ZDRPGSkill.Icon "S_Summon.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSummonDemon : ZDRPGSummonSkill
{
    Default {
        Tag "Summon Demon";
        ZDRPGSkill.EPCost 120;
        ZDRPGSkill.Icon "S_Summon.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSummonCacodemon : ZDRPGSummonSkill
{
    Default {
        Tag "Summon Cacodemon";
        ZDRPGSkill.EPCost 250;
        ZDRPGSkill.Icon "S_Summon.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSummonHellKnight : ZDRPGSummonSkill
{
    Default {
        Tag "Summon Hell Knight";
        ZDRPGSkill.EPCost 300;
        ZDRPGSkill.Icon "S_Summon.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSummonBaronOfHell : ZDRPGSummonSkill
{
    Default {
        Tag "Summon Baron of Hell";
        ZDRPGSkill.EPCost 450;
        ZDRPGSkill.Icon "S_Summon.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSummonLostSoul : ZDRPGSummonSkill
{
    Default {
        Tag "Summon Lost Soul";
        ZDRPGSkill.EPCost 75;
        ZDRPGSkill.Icon "S_Summon.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSummonPainElemental : ZDRPGSummonSkill
{
    Default {
        Tag "Summon Pain Elemental";
        ZDRPGSkill.EPCost 375;
        ZDRPGSkill.Icon "S_Summon.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSummonRevenant : ZDRPGSummonSkill
{
    Default {
        Tag "Summon Revenant";
        ZDRPGSkill.EPCost 450;
        ZDRPGSkill.Icon "S_Summon.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSummonMancubus : ZDRPGSummonSkill
{
    Default {
        Tag "Summon Mancubus";
        ZDRPGSkill.EPCost 475;
        ZDRPGSkill.Icon "S_Summon.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSummonArachnotron : ZDRPGSummonSkill
{
    Default {
        Tag "Summon Arachnotron";
        ZDRPGSkill.EPCost 450;
        ZDRPGSkill.Icon "S_Summon.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSummonArchVile : ZDRPGSummonSkill
{
    Default {
        Tag "Summon Arch-Vile";
        ZDRPGSkill.EPCost 600;
        ZDRPGSkill.Icon "S_Summon.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSummonCyberdemon : ZDRPGSummonSkill
{
    Default {
        Tag "Summon Cyberdemon";
        ZDRPGSkill.EPCost 750;
        ZDRPGSkill.Icon "S_Summon.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillSummonSpiderMastermind : ZDRPGSummonSkill
{
    Default {
        Tag "Summon Spider Mastermind";
        ZDRPGSkill.EPCost 900;
        ZDRPGSkill.Icon "S_Summon.png";
    }

    override void SkillEffect()
    {
        
    }
}

// Utility

class ZDRPGSkillBreakdownArmor : ZDRPGUtilitySkill
{
    Default {
        Tag "Breakdown Armor";
        ZDRPGSkill.EPCost 200;
        ZDRPGSkill.Icon "S_BArmor.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillForceWall : ZDRPGUtilitySkill
{
    Default {
        Tag "Force Wall";
        ZDRPGSkill.MaxLevel 3;
        ZDRPGSkill.EPCost 100;
        ZDRPGSkill.Icon "S_FWall.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillRally : ZDRPGUtilitySkill
{
    Default {
        Tag "Rally";
        ZDRPGSkill.EPCost 5;
        ZDRPGSkill.Icon "S_Rally.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillUnsummon : ZDRPGUtilitySkill
{
    Default {
        Tag "Unsummon";
        ZDRPGSkill.MaxLevel 2;
        ZDRPGSkill.Icon "S_Unsumm.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillRecall : ZDRPGUtilitySkill
{
    Default {
        Tag "Recall";
        ZDRPGSkill.EPCost 10;
        ZDRPGSkill.Icon "S_Recall.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillMagnetize : ZDRPGUtilitySkill
{
    Default {
        Tag "Magnetize";
        ZDRPGSkill.EPCost 33;
        ZDRPGSkill.Power  50;
        ZDRPGSkill.Icon "S_Magnet.png";
    }

    override void SkillEffect()
    {
        
    }
}

class ZDRPGSkillTransport : ZDRPGUtilitySkill
{
    Default {
        Tag "Transport";
        ZDRPGSkill.SkillLevel 1;
        ZDRPGSkill.MaxLevel   1;
        ZDRPGSkill.Icon "S_Transp.png";
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
