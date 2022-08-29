// Invulnerability Sphere
class ZDRPGInvulnerabilityPower : PowerupGiver
{
    Default
    {
        Inventory.MaxAmount 0;
    
        +INVENTORY.AUTOACTIVATE;
        +INVENTORY.ADDITIVETIME;
        +INVENTORY.PERSISTENTPOWER;

        Powerup.Type "PowerInvulnerable";
        Powerup.Color "255, 255, 0", 0.015;
    }
}

class ZDRPGInvulnerabilitySphere : Inventory
{
    Default
    {
        Tag "Invulnerability Sphere - Invulnerability for 30 seconds";
    
        Inventory.PickupMessage "You got an Invulnerability Sphere!";
        Inventory.PickupSound "powerups/protect";
        
        -COUNTITEM;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            PINV ABCD 6 Bright;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 A_JumpIf(CallACS("GetStimPowerupActive"), "PickupFail");
            TNT1 A 0 A_GiveInventory("ZDRPGInvulnerabilityPower", 1);
            Stop;
        PickupFail:
            TNT1 A 0;
            Fail;
    }
}

// Invulnerability Charge
class ZDRPGInvulnerabilityChargePower : PowerupGiver
{
    Default
    {
        Inventory.MaxAmount 0;
    
        +INVENTORY.AUTOACTIVATE;
        +INVENTORY.ADDITIVETIME;
        +INVENTORY.PERSISTENTPOWER;

        Powerup.Type "PowerInvulnerable";
        Powerup.Mode "Reflective";
        Powerup.Color "255, 255, 0", 0.015;
    }
}

class ZDRPGInvulnerabilityCharge : Inventory
{
    Default
    {
        //+INVBAR;

        Tag "Invulnerability Charge - Reflective Invulnerability for 30 seconds";

        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.PickupMessage "You got an Invulnerability Charge!";
        Inventory.PickupSound "powerups/protect";
        Inventory.UseSound "powerups/protect";
        Inventory.Icon "CRG2";
    }

    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            CRG2 ABC 3 Bright;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_JumpIf(CallACS("GetStimPowerupActive"), "UseFail");
            TNT1 A 0 A_GiveInventory("ZDRPGInvulnerabilityChargePower", 1);
            Stop;
        UseFail:
            TNT1 A 0;
            Fail;
    } 
}

class ZDRPGInvulnerabilitySurvive : PowerupGiver
{
    Default
    {
        Inventory.MaxAmount 0;
    
        +INVENTORY.AUTOACTIVATE;
        +INVENTORY.ADDITIVETIME;
        +INVENTORY.PERSISTENTPOWER;

        Powerup.Type "PowerInvulnerable";
        Powerup.Duration -3;
    }
}

// Invisibility Sphere
class ZDRPGInvisibilityPower : PowerupGiver
{
    Default
    {
        Inventory.MaxAmount 0;
    
        +INVENTORY.AUTOACTIVATE;
        +INVENTORY.ADDITIVETIME;
        +INVENTORY.PERSISTENTPOWER;

        Powerup.Type "PowerInvisibility";
    }
}

class ZDRPGBlurSphere : Inventory
{
    Default
    {
        Tag "Blur Sphere - Partial Invisibility for 60 seconds";
    
        +VISIBILITYPULSE;
        +FLOATBOB;
        -COUNTITEM;

        Inventory.PickupMessage "You got an Invisibility Sphere!";
        Inventory.PickupSound "powerups/invis";

        RenderStyle "Translucent";
    }

    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            PINS ABCD 6 Bright;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 A_JumpIf(CallACS("GetStimPowerupActive"), "PickupFail");
            TNT1 A 0 A_GiveInventory("ZDRPGInvisibilityPower", 1);
            Stop;
        PickupFail:
            TNT1 A 0;
            Fail;
    }
}   

// Invisibility Charge
class ZDRPGInvisibilityChargePower : PowerupGiver
{
    Default
    {
        Inventory.MaxAmount 0;
    
        +INVENTORY.AUTOACTIVATE;
        +INVENTORY.ADDITIVETIME;
        +INVENTORY.PERSISTENTPOWER;

        Powerup.Type "PowerInvisibility";
        Powerup.Strength 100;
        Powerup.Duration -60;
    }
}

class ZDRPGInvisibilityCharge : Inventory
{
    Default
    {
        //+INVBAR;

        Tag "Invisibility Charge - Complete Invisibility for 60 seconds";

        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.PickupMessage "You got an Invisibility Charge!";
        Inventory.PickupSound "powerups/invis";
        Inventory.UseSound "powerups/invis";
        Inventory.Icon "CRG1";
    }

    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            CRG1 ABC 3 Bright;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_JumpIf(CallACS("GetStimPowerupActive"), "UseFail");
            TNT1 A 0 A_GiveInventory("ZDRPGInvisibilityChargePower", 1);
            Stop;
        UseFail:
            TNT1 A 0;
            Fail;
    }
} 

// Time Sphere
class ZDRPGTimeFreezer : PowerupGiver
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
        +INVENTORY.ADDITIVETIME;
        +INVENTORY.PERSISTENTPOWER;
        
        Powerup.Type "PowerTimeFreezer";
        Powerup.Color "Black";
        Powerup.Duration -10;
    }
}

class ZDRPGTimeSphere : Inventory
{
    Default
    {
        Tag "Time Sphere - Stops Time for 10 Seconds";
    
        Scale 0.75;  
        
        //+INVBAR;
        +FLOATBOB;
        
        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.Pickupmessage "You got a Time Sphere!";
        Inventory.PickupSound "powerups/time";
        Inventory.Icon "TIME";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            TIME ABCDCB 4 bright;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_JumpIf(CallACS("GetStimPowerupActive"), "UseFail");
            TNT1 A 2 A_SpawnItemEx("ZDRPGTimeFreezerSound");
            TNT1 A 2 A_GiveInventory("ZDRPGTimeFreezer", 1);
            Stop;
        UseFail:
            TNT1 A 0;
            Fail;
    }
}

// Regeneration Sphere
class ZDRPGRegenSphere : Inventory
{
    Default
    {
        Tag "Regeneration Sphere - Quickly regenerates HP and EP";
    
        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.PickupMessage "You got a Regeneration Sphere!";
        Inventory.PickupSound "powerups/regen";
        Inventory.UseSound "powerups/regen";
        Inventory.Icon "REGN";

        //+INVBAR;
        +FLOATBOB;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            REGN ABCDCB 4 Bright;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_JumpIf(CallACS("GetStimPowerupActive"), "UseFail");
            TNT1 A 0 ACS_NamedExecute("RegenBoost", 0);
            Stop;
        UseFail:
            TNT1 A 0;
            Fail;
    }
}

// Radiation Suit
class ZDRPGRadSuitPower : PowerupGiver
{
    Default
    {
        Inventory.MaxAmount 0;
    
        +INVENTORY.AUTOACTIVATE;
        +INVENTORY.ADDITIVETIME;
        +INVENTORY.PERSISTENTPOWER;
        
        Powerup.Type "PowerIronFeet";
        Powerup.Color "255, 255, 0", 0.015;
    }
}

class ZDRPGRadSuit : Inventory Replaces Radsuit
{
    Default
    {
        Tag "Radiation Suit - Protects against Damaging Environments";

        //+INVBAR;
        
        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.PickupMessage "You got a Radiation Suit!";
        Inventory.PickupSound "powerups/suit";
        Inventory.UseSound "powerups/suit";
        Inventory.Icon "SUIT";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SUIT A -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_GiveInventory("ZDRPGRadSuitPower", 1);
            Stop;
    }
}   

// IR Goggles
class ZDRPGInfraredPower : PowerupGiver
{
    Default
    {
        Inventory.MaxAmount 0;
    
        +INVENTORY.AUTOACTIVATE;
        +INVENTORY.ADDITIVETIME;
        +INVENTORY.PERSISTENTPOWER;

        Powerup.Type "PowerLightAmp";
    }
}

class ZDRPGInfrared : Inventory Replaces Infrared
{
    Default
    {
        Tag "Night-Vision Goggles - See in the Dark";
    
        //+INVBAR;
        -COUNTITEM;
        
        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.PickupMessage "You got a pair of Infrared Goggles!";
        Inventory.PickupSound "powerups/light";
        Inventory.UseSound "powerups/light" ;
        Inventory.Icon "PVIS";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            PVIS A 6 Bright;
            PVIS B 6;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_GiveInventory("ZDRPGInfraredPower", 1);
            Stop;
    }
}

// Computer Area Map and Scanner
class ZDRPGAllMap : AllMap Replaces AllMap
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
        +INVENTORY.FANCYPICKUPSOUND;
        +INVENTORY.ALWAYSPICKUP;
        
        Inventory.PickupMessage "You got a Computer Area Map!";
        Inventory.PickupSound "powerups/map";
        
        -COUNTITEM;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            PMAP ABCDCB 6 Bright;
            Goto Spawn+1;
        Use:
            TNT1 A 1 A_GiveInventory("ZDRPGAllMapRevealer", 1);
    //      TNT1 A 1 A_GiveInventory("ZDRPGAllMapScanner", 1);
            Stop;
    }
}

class ZDRPGAllMapRevealer : MapRevealer {}

class ZDRPGAllMapScanner : PowerupGiver
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
        -INVENTORY.INVBAR;
        Inventory.MaxAmount 0;

        Powerup.Type "PowerScanner";
        Powerup.Duration -0x7FFFFFFF;
    }
}

// Berserk Pack
class ZDRPGBerserk : Berserk Replaces Berserk
{
    Default
    {
        Tag "Berserk Pack - Full Health and Increased Melee Damage";
    
        //+INVBAR;
        -INVENTORY.AUTOACTIVATE;
        -INVENTORY.ALWAYSPICKUP;
        
        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.PickupMessage "You got a Berserk Pack!";
        Inventory.PickupSound "powerups/berserk";
        Inventory.UseSound "powerups/berserk";
        Inventory.Icon "PSTR";
        
        -COUNTITEM;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            PSTR A -1;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_JumpIfInventory("PowerStrength", 1, 1);
            TNT1 A 0 
            {
                ACS_NamedExecuteAlways("AddToxicity", 0, 10);
                ACS_NamedExecuteAlways("AMShieldCharge", 0);
                ACS_NamedExecuteAlways("AddHealth", 0, 100, 100);
                A_GiveInventory("PowerStrength");
            }
            Stop;
    }
}

// Wings
class ZDRPGFlightPower : PowerupGiver
{
    Default
    {
        Inventory.MaxAmount 0;
    
        +INVENTORY.AUTOACTIVATE;
        
        Powerup.Type "PowerFlight";
        Powerup.Duration -0x7FFFFFFF;
    }
}

class ZDRPGWings : Inventory
{
    Default
    {
        Tag "Wings - Allows Flight";
    
        //+INVBAR;
        +FLOATBOB;

        Inventory.DefMaxAmount;
        Inventory.InterHubAmount 1000;
        Inventory.PickupMessage "You got a pair of Wings!";
        Inventory.PickupSound "powerups/wings";
        Inventory.UseSound "powerups/wings";
        Inventory.Icon "WINGS";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            WING A -1 Bright;
            Stop;
        Pickup:
            TNT1 A 0 ACS_NamedExecuteWithResult("CheckCapacity");
            Stop;
        Use:
            TNT1 A 0 A_GiveInventory("ZDRPGFlightPower", 1);
            Stop;
    }
}

// Megasphere
class ZDRPGMegasphere : Inventory Replaces MegaSphere
{
    Default
    {
        RenderStyle "Add";
    
        Inventory.PickupMessage "You got a Megasphere!";
        Inventory.PickupSound "powerups/megasphere";
        
        -COUNTITEM;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            MEGA ABCD 6 BRIGHT;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 
            {
                A_GiveInventory("ZDRPGSoulSphere3");
                ACS_NamedExecuteAlways("AddEP", 0, 1000000);
                ACS_NamedExecuteAlways("AddShield", 0, 1000000);
                ACS_NamedExecuteAlways("AddMedkit", 0, 1000000);
            }
            Stop;
    }
}   

// Immunity Crystals

class ZDRPGImmunityCrystal : Inventory
{
    Default
    {
        Health 1000;
        Height 32;
        Radius 16;
        Mass 0x7FFFFFFF;

        Inventory.Amount 1;
        Inventory.MaxAmount 1;
        
        Inventory.PickupSound "powerups/crystal";
        
        //+INVBAR;
        +BRIGHT;
        +THRUACTORS;
        +DONTGIB;
        +SHOOTABLE;
        +NOBLOOD;
        -SPECIAL;
    }

    States
    {
        FloorHit:
            TNT1 A 0
            {
                A_ChangeFlag("SPECIAL", true);
                A_ChangeFlag("THRUACTORS", false);
            } 
        Death:
            TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("ZDRPGImmunityCrystalDebris", 0, 0, Height / 2, Random(-8, 8), Random(-8, 8), 8, 0, SXF_NOCHECKPOSITION);
            Stop;
    }
}

class ZDRPGImmunityCrystalMelee : ZDRPGImmunityCrystal
{
    Default
    {
        Inventory.PickupMessage "Got a Melee Immunity Crystal!";
        Inventory.Icon "CRYSA";
    
        Tag "Melee Immunity Crystal";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_JumpIf(Abs(VelZ) <= 0.01, "FloorHit");
            CRYS A 1;
            Loop;
        Spawn2:
            TNT1 A 0 
            {
                A_SpawnItemEx(
                    "ZDRPGImmunityCrystalBeamMelee",
                    Cos((CallACS("GetTimer") / 256.0) * 360.0) * 512,
                    Sin((CallACS("GetTimer") / 256.0) * 360.0) * 512,
                    0, 0, 0, 0, 0, 
                    SXF_NOCHECKPOSITION
                );
                A_SpawnItemEx(
                    "ZDRPGImmunityCrystalBeamMelee",
                    Cos((CallACS("GetTimer") / 256.0 + 17.5) * 360.0) * 512,
                    Sin((CallACS("GetTimer") / 256.0 + 17.5) * 360.0) * 512,
                    0, 0, 0, 0, 0, 
                    SXF_NOCHECKPOSITION
                );
                A_RadiusGive("ZDRPGPowerImmunityMelee", 512.0, RGF_PLAYERS);

            }
            CRYS A 1 A_SpawnItemEx("ZDRPGImmunityCrystalPulseMelee", Random(-8, 8), Random(-8, 8), Random(-16, 8), 0, 0, 0, 0, SXF_NOCHECKPOSITION);
            Loop;
        Use:
            TNT1 A 0 A_SpawnItemEx("ZDRPGImmunityCrystalMelee", 0, 0, 40, 16, 0, 0, 0, SXF_SETMASTER);
            Stop;
    }
}

class ZDRPGImmunityCrystalBullet : ZDRPGImmunityCrystal
{
    Default
    {
        Inventory.PickupMessage "Got a Bullet Immunity Crystal!";
        Inventory.Icon "CRYSB";
        
        Tag "Bullet Immunity Crystal";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_JumpIf(Abs(VelZ) <= 0.01, "FloorHit");
            CRYS B 1;
            Loop;
        Spawn2:
            TNT1 A 0 
            {
                A_SpawnItemEx(
                    "ZDRPGImmunityCrystalBeamBullet",
                    Cos((CallACS("GetTimer") / 256.0) * 360.0) * 512,
                    Sin((CallACS("GetTimer") / 256.0) * 360.0) * 512,
                    0, 0, 0, 0, 0, 
                    SXF_NOCHECKPOSITION
                );
                A_SpawnItemEx(
                    "ZDRPGImmunityCrystalBeamBullet",
                    Cos((CallACS("GetTimer") / 256.0 + 17.5) * 360.0) * 512,
                    Sin((CallACS("GetTimer") / 256.0 + 17.5) * 360.0) * 512,
                    0, 0, 0, 0, 0, 
                    SXF_NOCHECKPOSITION
                );
                A_RadiusGive("ZDRPGPowerImmunityBullet", 512.0, RGF_PLAYERS);
            }
            CRYS B 1 A_SpawnItemEx("ZDRPGImmunityCrystalPulseBullet", Random(-8, 8), Random(-8, 8), Random(-16, 8), 0, 0, 0, 0, SXF_NOCHECKPOSITION);
            Loop;
        Use:
            TNT1 A 0 A_SpawnItemEx("ZDRPGImmunityCrystalBullet", 0, 0, 40, 16, 0, 0, 0, SXF_SETMASTER);
            Stop;
    }
}

class ZDRPGImmunityCrystalFire : ZDRPGImmunityCrystal
{
    Default
    {
        Inventory.PickupMessage "Got a Fire Immunity Crystal!";
        Inventory.Icon "CRYSC";
        
        Tag "Fire Immunity Crystal";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_JumpIf(Abs(VelZ) <= 0.01, "FloorHit");
            CRYS C 1 A_SpawnItemEx("ZDRPGImmunityCrystalPulseFire", Random(-8, 8), Random(-8, 8), Random(-16, 8), 0, 0, 0, 0, SXF_NOCHECKPOSITION);
            Loop;
        Spawn2:
            TNT1 A 0 
            {
                A_SpawnItemEx(
                    "ZDRPGImmunityCrystalBeamFire",
                    Cos((CallACS("GetTimer") / 256.0) * 360.0) * 512,
                    Sin((CallACS("GetTimer") / 256.0) * 360.0) * 512,
                    0, 0, 0, 0, 0, 
                    SXF_NOCHECKPOSITION
                );
                A_SpawnItemEx(
                    "ZDRPGImmunityCrystalBeamFire",
                    Cos((CallACS("GetTimer") / 256.0 + 17.5) * 360.0) * 512,
                    Sin((CallACS("GetTimer") / 256.0 + 17.5) * 360.0) * 512,
                    0, 0, 0, 0, 0, 
                    SXF_NOCHECKPOSITION
                );
                A_RadiusGive("ZDRPGPowerImmunityFire", 512.0, RGF_PLAYERS);
            }
            CRYS C 1 A_SpawnItemEx("ZDRPGImmunityCrystalPulseFire", Random(-8, 8), Random(-8, 8), Random(-16, 8), 0, 0, 0, 0, SXF_NOCHECKPOSITION);
            Loop;
        Use:
            TNT1 A 0 A_SpawnItemEx("ZDRPGImmunityCrystalFire", 0, 0, 40, 16, 0, 0, 0, SXF_SETMASTER);
            Stop;
    }
}

class ZDRPGImmunityCrystalPlasma : ZDRPGImmunityCrystal
{
    Default
    {
        Inventory.PickupMessage "Got a Plasma Immunity Crystal!";
        Inventory.Icon "CRYSD";

        Tag "Plasma Immunity Crystal";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_JumpIf(Abs(VelZ) <= 0.01, "FloorHit");
            CRYS D 1;
            Loop;
        Spawn2:
            TNT1 A 0 
            {
                A_SpawnItemEx(
                    "ZDRPGImmunityCrystalBeamPlasma",
                    Cos((CallACS("GetTimer") / 256.0) * 360.0) * 512,
                    Sin((CallACS("GetTimer") / 256.0) * 360.0) * 512,
                    0, 0, 0, 0, 0, 
                    SXF_NOCHECKPOSITION
                );
                A_SpawnItemEx(
                    "ZDRPGImmunityCrystalBeamPlasma",
                    Cos((CallACS("GetTimer") / 256.0 + 17.5) * 360.0) * 512,
                    Sin((CallACS("GetTimer") / 256.0 + 17.5) * 360.0) * 512,
                    0, 0, 0, 0, 0, 
                    SXF_NOCHECKPOSITION
                );
                A_RadiusGive("ZDRPGPowerImmunityPlasma", 512.0, RGF_PLAYERS);
            }
            CRYS D 1 A_SpawnItemEx("ZDRPGImmunityCrystalPulsePlasma", Random(-8, 8), Random(-8, 8), Random(-16, 8), 0, 0, 0, 0, SXF_NOCHECKPOSITION);
            Loop;
        Use:
            TNT1 A 0 A_SpawnItemEx("ZDRPGImmunityCrystalPlasma", 0, 0, 40, 16, 0, 0, 0, SXF_SETMASTER);
            Stop;
    }
}

class ZDRPGImmunityCrystalLightning : ZDRPGImmunityCrystal
{
    Default
    {
        Inventory.PickupMessage "Got a Lightning Immunity Crystal!";
        Inventory.Icon "CRYSE";

        Tag "Lightning Immunity Crystal";   
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_JumpIf(Abs(VelZ) <= 0.01, "FloorHit");
            CRYS E 1;
            Loop;
        Spawn2:
            TNT1 A 0 
            {
                A_SpawnItemEx(
                    "ZDRPGImmunityCrystalBeamLightning",
                    Cos((CallACS("GetTimer") / 256.0) * 360.0) * 512,
                    Sin((CallACS("GetTimer") / 256.0) * 360.0) * 512,
                    0, 0, 0, 0, 0, 
                    SXF_NOCHECKPOSITION
                );
                A_SpawnItemEx(
                    "ZDRPGImmunityCrystalBeamLightning",
                    Cos((CallACS("GetTimer") / 256.0 + 17.5) * 360.0) * 512,
                    Sin((CallACS("GetTimer") / 256.0 + 17.5) * 360.0) * 512,
                    0, 0, 0, 0, 0, 
                    SXF_NOCHECKPOSITION
                );
                A_RadiusGive("ZDRPGPowerImmunityLightning", 512.0, RGF_PLAYERS);
            }
            CRYS E 1 A_SpawnItemEx("ZDRPGImmunityCrystalPulseLightning", Random(-8, 8), Random(-8, 8), Random(-16, 8), 0, 0, 0, 0, SXF_NOCHECKPOSITION);
            Loop;
        Use:
            TNT1 A 0 A_SpawnItemEx("ZDRPGImmunityCrystalLightning", 0, 0, 40, 16, 0, 0, 0, SXF_SETMASTER);
            Stop;
    }
}

class ZDRPGImmunityCrystalToxic : ZDRPGImmunityCrystal
{
    Default
    {
        Inventory.PickupMessage "Got a Toxic Immunity Crystal!";
        Inventory.Icon "CRYSF";
        
        Tag "Toxic Immunity Crystal";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_JumpIf(Abs(VelZ) <= 0.01, "FloorHit");
            CRYS F 1;
            Loop;
        Spawn2:
            TNT1 A 0 
            {
                A_SpawnItemEx(
                    "ZDRPGImmunityCrystalBeamToxic",
                    Cos((CallACS("GetTimer") / 256.0) * 360.0) * 512,
                    Sin((CallACS("GetTimer") / 256.0) * 360.0) * 512,
                    0, 0, 0, 0, 0, 
                    SXF_NOCHECKPOSITION
                );
                A_SpawnItemEx(
                    "ZDRPGImmunityCrystalBeamToxic",
                    Cos((CallACS("GetTimer") / 256.0 + 17.5) * 360.0) * 512,
                    Sin((CallACS("GetTimer") / 256.0 + 17.5) * 360.0) * 512,
                    0, 0, 0, 0, 0, 
                    SXF_NOCHECKPOSITION
                );
                A_RadiusGive("ZDRPGPowerImmunityToxic", 512.0, RGF_PLAYERS);
            }
            CRYS F 1 A_SpawnItemEx("ZDRPGImmunityCrystalPulseToxic", Random(-8, 8), Random(-8, 8), Random(-16, 8), 0, 0, 0, 0, SXF_NOCHECKPOSITION);
            Loop;
        Use:
            TNT1 A 0 A_SpawnItemEx("ZDRPGImmunityCrystalToxic", 0, 0, 40, 16, 0, 0, 0, SXF_SETMASTER);
            Stop;
    }
}

class ZDRPGImmunityCrystalRadiation : ZDRPGImmunityCrystal
{
    Default
    {
        Inventory.PickupMessage "Got a Radiation Immunity Crystal!";
        Inventory.Icon "CRYSG";
        
        Tag "Radiation Immunity Crystal";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_JumpIf(Abs(VelZ) <= 0.01, "FloorHit");
            CRYS G 1;
            Loop;
        Spawn2:
            TNT1 A 0 
            {
                A_SpawnItemEx(
                    "ZDRPGImmunityCrystalBeamRadiation",
                    Cos((CallACS("GetTimer") / 256.0) * 360.0) * 512,
                    Sin((CallACS("GetTimer") / 256.0) * 360.0) * 512,
                    0, 0, 0, 0, 0, 
                    SXF_NOCHECKPOSITION
                );
                A_SpawnItemEx(
                    "ZDRPGImmunityCrystalBeamRadiation",
                    Cos((CallACS("GetTimer") / 256.0 + 17.5) * 360.0) * 512,
                    Sin((CallACS("GetTimer") / 256.0 + 17.5) * 360.0) * 512,
                    0, 0, 0, 0, 0, 
                    SXF_NOCHECKPOSITION
                );
                A_RadiusGive("ZDRPGPowerImmunityRadiation", 512.0, RGF_PLAYERS);
            }
            CRYS G 1 A_SpawnItemEx("ZDRPGImmunityCrystalPulseRadiation", Random(-8, 8), Random(-8, 8), Random(-16, 8), 0, 0, 0, 0, SXF_NOCHECKPOSITION);
            Loop;
        Use:
            TNT1 A 0 A_SpawnItemEx("ZDRPGImmunityCrystalRadiation", 0, 0, 40, 16, 0, 0, 0, SXF_SETMASTER);
            Stop;
    }
}

class ZDRPGPowerImmunityBullet : PowerProtection
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    
        DamageFactor "Bullet", 0;
        Powerup.Duration 35;
    }
}

class ZDRPGPowerImmunityMelee : PowerProtection
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    
        DamageFactor "Melee", 0;
        Powerup.Duration 35;
    }
}

class ZDRPGPowerImmunityFire : PowerProtection
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    
        DamageFactor "Fire", 0;
        DamageFactor "Explosion", 0;
        Powerup.Duration 35;
    }
}

class ZDRPGPowerImmunityPlasma : PowerProtection
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    
        DamageFactor "Plasma", 0;
        Powerup.Duration 35;
    }
}

class ZDRPGPowerImmunityLightning : PowerProtection
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    
        DamageFactor "Electricity", 0;
        DamageFactor "Electric", 0;
        DamageFactor "Lightning", 0;
        Powerup.Duration 35;
    }
}

class ZDRPGPowerImmunityToxic : PowerProtection
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
        
        DamageFactor "Toxicity", 0;
        DamageFactor "Slime", 0;
        Powerup.Duration 35;
    }
}

class ZDRPGPowerImmunityRadiation : PowerProtection
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    
        DamageFactor "Radiation", 0;
        Powerup.Duration 35;
    }
}
