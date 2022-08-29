class ZDRPGStimSmall : Inventory
{
    Default
    {
        Scale 0.25;
    
        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.PickupMessage "Got a Small Stim!";
        Inventory.PickupSound "items/stim";
        Inventory.UseSound "items/stim";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STIM B -1 Bright;
            Stop;
    }
}

class ZDRPGStimMedium : ZDRPGStimSmall 
{
    Default
    {
        Scale 0.325;
        Inventory.PickupMessage "Got a Medium Stim!";
    }

    
}

class ZDRPGStimLarge : ZDRPGStimSmall 
{
    Default
    {
        Scale 0.4;
        Inventory.PickupMessage "Got a Large Stim!";
    }
}

class ZDRPGStimXL : ZDRPGStimSmall 
{
    Default
    {
        Scale 0.5;
        Inventory.PickupMessage "Got an Extra-Large Stim!";
    }
    
}

class ZDRPGStimDetox : Inventory 
{
    Default
    {
        Scale 0.5;
    
        Tag "Detox Hypospray - Removes all Toxicity, Status Effects and Energy Burnout";
        
        //+INVBAR;
        
        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.PickupMessage "Got a \cdDetox\c- Hypospray!";
        Inventory.PickupSound "items/stim";
        Inventory.UseSound "items/stim";
        Inventory.Icon "STIMC";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STIM C -1 Bright;
            Stop;
        Use:
            TNT1 A 0 
            {
                ACS_NamedExecuteAlways("TossStim", 0);
                ACS_NamedExecuteAlways("AddToxicity", 0, -100);
                ACS_NamedExecuteAlways("ClearStatusEffects", 0);
                ACS_NamedExecuteAlways("ClearBurnout", 0);
            }
            Stop;
        UseFail:
            TNT1 A 0;
            Fail;
    }
}

class ZDRPGStimSmallTossed : ZDRPGStimSmall
{
    Default
    {
        BounceType "Classic";
        BounceFactor 0.25;
        WallBounceFactor 0.25;
        
        +NOBLOCKMAP;
        +NOTELEPORT;
        +NOTRIGGER;
        +MOVEWITHSECTOR;
        +THRUACTORS;
        -SPECIAL;
    }
    
    States
    {
        Spawn:
            STIM B 1;
        FadeOut:
            STIM B 1 A_FadeOut(0.0025, true);
            Loop;
    }
}

class ZDRPGStimMediumTossed : ZDRPGStimMedium
{
    Default
    {
        BounceType "Classic";
        BounceFactor 0.25;
        WallBounceFactor 0.25;
        
        +NOBLOCKMAP;
        +NOTELEPORT;
        +NOTRIGGER;
        +MOVEWITHSECTOR;
        +THRUACTORS;
        -SPECIAL;
    }
    
    States
    {
        Spawn:
            STIM B 1;
        FadeOut:
            STIM B 1 A_FadeOut(0.0025, true);
            Loop;
    }
}

class ZDRPGStimLargeTossed : ZDRPGStimLarge
{
    Default
    {
        BounceType "Classic";
        BounceFactor 0.25;
        WallBounceFactor 0.25;
        
        +NOBLOCKMAP;
        +NOTELEPORT;
        +NOTRIGGER;
        +MOVEWITHSECTOR;
        +THRUACTORS;
        -SPECIAL;
    }
    
    States
    {
        Spawn:
            STIM B 1;
        FadeOut:
            STIM B 1 A_FadeOut(0.0025, true);
            Loop;
    }
}

class ZDRPGStimXLTossed : ZDRPGStimXL
{
    Default
    {
        BounceType "Classic";
        BounceFactor 0.25;
        WallBounceFactor 0.25;
        
        +NOBLOCKMAP;
        +NOTELEPORT;
        +NOTRIGGER;
        +MOVEWITHSECTOR;
        +THRUACTORS;
        -SPECIAL;
    }
    
    States
    {
        Spawn:
            STIM B 1;
        FadeOut:
            STIM B 1 A_FadeOut(0.0025, true);
            Loop;
    }
}

// Vials

class ZDRPGVial : Inventory
{
    Default
    {
        Scale 0.5;
        Inventory.PickupSound "items/vial";
    }
}

class ZDRPGVialStrength : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got a \cgStrength\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL A -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 0, 1);
            Stop;
    }
}

class ZDRPGVialDefense : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got a \cdDefense\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL B -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 1, 1);
            Stop;
    }
}

class ZDRPGVialVitality : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got a \caVitality\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL C -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 2, 1);
            Stop;
    }
}

class ZDRPGVialEnergy : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got an \cnEnergy\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL D -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 3, 1);
            Stop;
    }
}

class ZDRPGVialRegeneration : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got a \ctRegeneration\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL E -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 4, 1);
            Stop;
    }
}

class ZDRPGVialAgility : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got an \ciAgility\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL F -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 5, 1);
            Stop;
    }
}

class ZDRPGVialCapacity : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got a \chCapacity\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL G -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 6, 1);
            Stop;
    }
}

class ZDRPGVialLuck : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got a \cfLuck\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL H -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 7, 1);
            Stop;
    }
}

class ZDRPGVialPurifier : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got a \ccPurifier\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL I -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 8, 1);
            Stop;
    }
}

class ZDRPGVialPotency : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got a \cjPotency\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL J -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 9, 1);
            Stop;
    }
}

class ZDRPGVialIndestructible : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got an \cqIndestructible\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL K -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 10, 1);
            Stop;
    }
}

class ZDRPGVialShadow : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got a \crShadow\c- Vial.";
    }

    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL L -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 11, 1);
            Stop;
    }
}

class ZDRPGVialInfinity : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got an \ckInfinity\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL M -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 12, 1);
            Stop;
    }
}

class ZDRPGVialChrono : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got a \cdChrono\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL N -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 13, 1);
            Stop;
    }
}

class ZDRPGVialAdrenaline : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got an \ctAdrenaline\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL O -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 14, 1);
            Stop;
    }
}

class ZDRPGVialGravity : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got a \ciGravity\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL P -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 15, 1);
            Stop;
    }
}

class ZDRPGVialVampire : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got a \caVampire\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL Q -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 16, 1);
            Stop;
    }
}

class ZDRPGVialRage : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got a \cmRage\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL R -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 17, 1);
            Stop;
    }
}

class ZDRPGVialMagnetic : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got a \ccMagnetic\c- Vial.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STVL S -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteAlways("AddCompound", 0, 18, 1);
            Stop;
    }
}

// Stim Packages
class ZDRPGStimPackageStat : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got a Stat Stim Package.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STPA A -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 
            {
                ACS_NamedExecuteAlways("AddCompound", 0, 0, Random(1, 5));
                ACS_NamedExecuteAlways("AddCompound", 0, 1, Random(1, 5));
                ACS_NamedExecuteAlways("AddCompound", 0, 2, Random(1, 5));
                ACS_NamedExecuteAlways("AddCompound", 0, 3, Random(1, 5));
                ACS_NamedExecuteAlways("AddCompound", 0, 4, Random(1, 5));
                ACS_NamedExecuteAlways("AddCompound", 0, 5, Random(1, 5));
                ACS_NamedExecuteAlways("AddCompound", 0, 6, Random(1, 5));
                ACS_NamedExecuteAlways("AddCompound", 0, 7, Random(1, 5));
                ACS_NamedExecuteAlways("AddCompound", 0, 8, Random(1, 5));
                ACS_NamedExecuteAlways("AddCompound", 0, 9, Random(1, 5));
            }
            Stop;
    }
}

class ZDRPGStimPackagePowerup : ZDRPGVial
{
    Default
    {
        Inventory.PickupMessage "Got a Powerup Stim Package.";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            STPA B -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 
            {
                ACS_NamedExecuteAlways("AddCompound", 0, 10, Random(1, 5));
                ACS_NamedExecuteAlways("AddCompound", 0, 11, Random(1, 5));
                ACS_NamedExecuteAlways("AddCompound", 0, 12, Random(1, 5));
                ACS_NamedExecuteAlways("AddCompound", 0, 13, Random(1, 5));
                ACS_NamedExecuteAlways("AddCompound", 0, 14, Random(1, 5));
                ACS_NamedExecuteAlways("AddCompound", 0, 15, Random(1, 5));
                ACS_NamedExecuteAlways("AddCompound", 0, 16, Random(1, 5));
                ACS_NamedExecuteAlways("AddCompound", 0, 17, Random(1, 5));
                ACS_NamedExecuteAlways("AddCompound", 0, 18, Random(1, 5));
            }
            Stop;
    }
}

// Stim Powerups
class ZDRPGPowerStimIndestructible : PowerInvulnerable
{ 
    Default
    {
        Powerup.Duration 4;
        //-INVBAR;
    } 
}
class ZDRPGPowerStimShadow : PowerGhost
{ 
    Default
    {
        Powerup.Duration 4; 
        //-INVBAR;
    } 
}
class ZDRPGPowerStimInfinity2 : PowerupGiver 
{
    Default
    {
        +Inventory.AutoActivate;
        //Powerup.Type PowerInfiniteAmmo;
        Powerup.Duration 4;
    }
}
class ZDRPGPowerStimChrono : PowerTimeFreezer                
{ 
    Default
    {
        Powerup.Duration 4; 
        //-INVBAR;
    } 
}
class ZDRPGPowerStimGravity : PowerFlight
{ 
    Default
    {
        Powerup.Duration 4;
        //-INVBAR;
    } 
}
class ZDRPGPowerStimVampire : PowerDrain
{ 
    Default
    {
        Powerup.Duration 4;
        //-INVBAR;
    } 
}
