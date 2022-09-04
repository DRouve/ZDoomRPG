// SPECIAL
// --------------------------------------------------

class ZDRPGLuckDropper : MapSpot
{
    States
    {
        Spawn:
            TNT1 A -1 NoDelay ACS_NamedExecuteWithResult("SpawnLuckItem");
            Stop;
    }
}

class ZDRPGGenericMonsterDropper : RandomSpawner
{
    Default
    {
        -NOBLOCKMAP;
        -NOSECTOR;
        -THRUACTORS;
        +INVISIBLE;
        +SOLID;
        Radius 50;
        Height 110;

        DropItem "ZombieMan",            255, 700;
        DropItem "ShotgunGuy",           255, 700;
        DropItem "ChaingunGuy",          255, 500;
        DropItem "DoomImp",              255, 500;
        DropItem "Demon",                255, 400;
        DropItem "Spectre",              255, 300;
        DropItem "Cacodemon",            255, 300;
        DropItem "Fatso",                255, 300;
        DropItem "HellKnight",           255, 240;
        DropItem "Arachnotron",          255, 200;
        DropItem "PainElemental",        255, 100;
        DropItem "Revenant",             255, 100;
        DropItem "BaronOfHell",          255, 100;
        DropItem "Archvile",             255,  20;
        DropItem "Cyberdemon",           255,   1;
    }
    
    States
    {
        Spawn:
            TNT1 A -1 NoDelay 
            {
                bSolid = false;
            }
            Stop;
    }
}

class ZDRPGGenericDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGHealthDropper",                255, 10;
        DropItem "ZDRPGEPDropper",                    255, 10;
        DropItem "ZDRPGArmorDropper",                 255, 10;
        DropItem "ZDRPGPowerupDropper",               255, 5;
        DropItem "ZDRPGWeaponDropper",                255, 5;
        DropItem "ZDRPGAmmoDropper",                  255, 10;
        DropItem "ZDRPGModuleDropper",                255, 1;
        DropItem "ZDRPGAugDropper",                   255, 1;
        DropItem "ZDRPGBatteryDropper",               255, 1;
        DropItem "ZDRPGShieldDropper",                255, 1;
        DropItem "ZDRPGStimDropper",                  255, 1;
        DropItem "ZDRPGVialDropper",                  255, 1;
        DropItem "ZDRPGChipDropper",                  255, 5;
        DropItem "ZDRPGTurretDropper",                255, 3;
    }   
}

class ZDRPGGenericBossDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGMoneyDropper";
        DropItem "ZDRPGHealthDropper";
        DropItem "ZDRPGEPDropper";
        DropItem "ZDRPGArmorDropper";
        DropItem "ZDRPGPowerupDropper";
        DropItem "ZDRPGWeaponDropper";
        DropItem "ZDRPGAmmoDropper";
        DropItem "ZDRPGModuleDropper";
        DropItem "ZDRPGAugDropper";
        DropItem "ZDRPGBatteryDropper";
        DropItem "ZDRPGShieldDropper";
        DropItem "ZDRPGStimPackageStat";
        DropItem "ZDRPGStimPackagePowerup";
        DropItem "ZDRPGChipDropper";
        DropItem "ZDRPGTurretDropper";
    }
}

class ZDRPGMoneyDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGCredits1",         255, 75;
        DropItem "ZDRPGCredits5",         255, 10;
        DropItem "ZDRPGCredits10",        255, 8;
        DropItem "ZDRPGCredits20",        255, 4;
        DropItem "ZDRPGCredits50",        255, 2;
        DropItem "ZDRPGCredits100",       255, 1;
    }
}

class ZDRPGHealthDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGHealthBonus",      255, 150;
        DropItem "ZDRPGStimpack",         255, 100;
        DropItem "ZDRPGMedikit",          255, 30;
        DropItem "ZDRPGLargeMedikit",     255, 10;
        DropItem "ZDRPGXLMedikit",        255, 6;
        DropItem "ZDRPGMedPack",          255, 3;
        DropItem "ZDRPGSurgeryKit",       255, 1;
    }
}

class ZDRPGLifeDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPG1Up",              255, 100;
    //  DropItem "ZDRPG3Up",              255, 5;
    //  DropItem "ZDRPG5Up",              255, 1;
    }
}

class ZDRPGEPDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGLittleEPCapsule",  255, 50;
        DropItem "ZDRPGEPCapsule",        255, 40;
        DropItem "ZDRPGBigEPCapsule",     255, 10;
    }
}

class ZDRPGArmorDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGGreenArmorRandomizer", 255, 75;
        DropItem "ZDRPGBlueArmorRandomizer",  255, 25;
    }
}

class ZDRPGPowerupDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGInvulnerabilitySphere", 255, 10;
        DropItem "ZDRPGInvulnerabilityCharge", 255, 10;
        DropItem "ZDRPGBlurSphere",            255, 10;
        DropItem "ZDRPGInvisibilityCharge",    255, 10;
        DropItem "ZDRPGTimeSphere",            255, 10;
        DropItem "ZDRPGRegenSphere",           255, 10;
        DropItem "ZDRPGRadSuit",               255, 10;
        DropItem "ZDRPGInfrared",              255, 10;
    //  DropItem "ZDRPGBerserk",               255, 10;
    }
}

class ZDRPGImmunityCrystalDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGImmunityCrystalMelee";
        DropItem "ZDRPGImmunityCrystalBullet";
        DropItem "ZDRPGImmunityCrystalFire";
        DropItem "ZDRPGImmunityCrystalPlasma";
        DropItem "ZDRPGImmunityCrystalLightning";
        DropItem "ZDRPGImmunityCrystalToxic";
        DropItem "ZDRPGImmunityCrystalRadiation";
    }
}

class ZDRPGWeaponDropper : RandomSpawner 
{
    Default
    {
        DropItem "Pistol",           255, 7;
        DropItem "Shotgun",          255, 6;
        DropItem "SuperShotgun",     255, 5;
        DropItem "Chaingun",         255, 4;
        DropItem "RocketLauncher",   255, 3;
        DropItem "PlasmaRifle",      255, 2;
        DropItem "BFG9000",          255, 1;
        DropItem "Chainsaw",         255, 1;
    }
}

class ZDRPGAmmoDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGClip",                 255, 80;
        DropItem "ZDRPGShell",                255, 60;
        DropItem "ZDRPGRocketAmmo",           255, 20;
        DropItem "ZDRPGCell",                 255, 10;
        DropItem "ZDRPGClipBox",              255, 4;
        DropItem "ZDRPGShellBox",             255, 3;	
        DropItem "ZDRPGRocketBox",            255, 2;	
        DropItem "ZDRPGCellPack",             255, 1;
    }
}

class ZDRPGModuleDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGModulePickup";
    }
}

class ZDRPGAugDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGAugCanister",          255, 25;
        DropItem "ZDRPGAugUpgradeCanister",   255, 70;
        DropItem "ZDRPGAugSlotUpgrade",       255, 5;
    }
}

class ZDRPGBatteryDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGBatterySmall",         255, 19;
        DropItem "ZDRPGBatteryLarge",         255, 1;
    }
}

class ZDRPGShieldDropper : RandomSpawner
{
    Default
    {
        // Bodies
        DropItem "ZDRPGShieldBody1",          255, 40; // UAC
        DropItem "ZDRPGShieldBody2",          255, 33; // XTron
        DropItem "ZDRPGShieldBody3",          255, 32; // Black Mesa
        DropItem "ZDRPGShieldBody4",          255, 28; // EDF
        DropItem "ZDRPGShieldBody5",          255, 25; // Cyberdyne Systems
        DropItem "ZDRPGShieldBody6",          255, 24; // Misfit Tech
        DropItem "ZDRPGShieldBody7",          255, 16; // Shadaloo
        DropItem "ZDRPGShieldBody8",          255, 22; // Arkai
        DropItem "ZDRPGShieldBody9",          255, 21; // Ironclad Inc.
        DropItem "ZDRPGShieldBody10",         255, 21; // Yholl
        DropItem "ZDRPGShieldBody11",         255, 19; // Hyperix
        DropItem "ZDRPGShieldBody12",         255, 17; // Xaser Inc.
        DropItem "ZDRPGShieldBody13",         255, 16; // dataDyne
        DropItem "ZDRPGShieldBody14",         255, 13; // Starbright
        DropItem "ZDRPGShieldBody15",         255, 13; // Hellsing
        DropItem "ZDRPGShieldBody16",         255, 12; // S.H.I.E.L.D.
        DropItem "ZDRPGShieldBody17",         255, 9;  // UAC Elite
        DropItem "ZDRPGShieldBody18",         255, 9;  // Stark Industries
        DropItem "ZDRPGShieldBody19",         255, 8;  // Weyland-Yutani
        DropItem "ZDRPGShieldBody20",         255, 5;  // Megalith
        DropItem "ZDRPGShieldBody21",         255, 2;  // Reaper Industries
        DropItem "ZDRPGShieldBody22",         255, 2;  // Eternity Systems
        
        // Batteries
        DropItem "ZDRPGShieldBattery1",       255, 29; // Crappy
        DropItem "ZDRPGShieldBattery2",       255, 24; // Bullet
        DropItem "ZDRPGShieldBattery3",       255, 20; // Elegant
        DropItem "ZDRPGShieldBattery4",       255, 18; // Spiked
        DropItem "ZDRPGShieldBattery5",       255, 17; // Stubborn
        DropItem "ZDRPGShieldBattery6",       255, 14; // Mirrored
        DropItem "ZDRPGShieldBattery7",       255, 13; // Refined
        DropItem "ZDRPGShieldBattery8",       255, 9;  // Clustered
        DropItem "ZDRPGShieldBattery9",       255, 8;  // Winged
        DropItem "ZDRPGShieldBattery10",      255, 6;  // Overcharged
        DropItem "ZDRPGShieldBattery11",      255, 3;  // Superb
        DropItem "ZDRPGShieldBattery12",      255, 2;  // Redundant
        DropItem "ZDRPGShieldBattery13",      255, 2;  // Reinforced
        
        // Capacitors
        DropItem "ZDRPGShieldCapacitor1",     255, 38; // Standard
        DropItem "ZDRPGShieldCapacitor2",     255, 32; // Outdated
        DropItem "ZDRPGShieldCapacitor3",     255, 29; // Cooled
        DropItem "ZDRPGShieldCapacitor4",     255, 26; // Warm
        DropItem "ZDRPGShieldCapacitor5",     255, 20; // Inefficient
        DropItem "ZDRPGShieldCapacitor6",     255, 18; // Energized
        DropItem "ZDRPGShieldCapacitor7",     255, 15; // Infused
        DropItem "ZDRPGShieldCapacitor8",     255, 13; // Plasmatic
        DropItem "ZDRPGShieldCapacitor9",     255, 11; // Burning
        DropItem "ZDRPGShieldCapacitor10",    255, 9;  // Pulsating
        DropItem "ZDRPGShieldCapacitor11",    255, 8;  // Fiery
        DropItem "ZDRPGShieldCapacitor12",    255, 6;  // Eternal
        DropItem "ZDRPGShieldCapacitor13",    255, 3;  // Overloaded
        DropItem "ZDRPGShieldCapacitor14",    255, 2;  // Dark
        DropItem "ZDRPGShieldCapacitor15",    255, 2;  // Chaotic
        
        // Accessories
        // THE CURSE OF YHOLL STRIKES A SECOND TIME also have some nice weights
        DropItem "ZDRPGShieldAccessory1",     255, 5; // X-7
        DropItem "ZDRPGShieldAccessory2",     255, 4; // SGENX-5b
        DropItem "ZDRPGShieldAccessory3",     255, 4; // AMP-3000
        DropItem "ZDRPGShieldAccessory4",     255, 5; // HRY-VP80
        DropItem "ZDRPGShieldAccessory5",     255, 5; // DEF-2
        DropItem "ZDRPGShieldAccessory6",     255, 5; // B1-ZUT3
        DropItem "ZDRPGShieldAccessory7",     255, 6; // CNV-RT99
        DropItem "ZDRPGShieldAccessory8",     255, 5; // REK-T50
        DropItem "ZDRPGShieldAccessory9",     255, 4; // UW-0t
        DropItem "ZDRPGShieldAccessory10",    255, 6; // CU-256
        DropItem "ZDRPGShieldAccessory11",    255, 6; // TX-BGONN
        DropItem "ZDRPGShieldAccessory12",    255, 6; // WRP30-LITE
        DropItem "ZDRPGShieldAccessory13",    255, 3; // NOV-A2
        DropItem "ZDRPGShieldAccessory14",    255, 5; // LZ-Y200
        DropItem "ZDRPGShieldAccessory15",    255, 5; // BST-700
        DropItem "ZDRPGShieldAccessory16",    255, 2; // PH-D88
        DropItem "ZDRPGShieldAccessory17",    255, 1; // BATT-B
        DropItem "ZDRPGShieldAccessory18",    255, 3; // SHVR-Z7
        DropItem "ZDRPGShieldAccessory19",    255, 4; // MM-12
        DropItem "ZDRPGShieldAccessory20",    255, 4; // MRTE-KRAR
        DropItem "ZDRPGShieldAccessory21",    255, 3; // SP-00k
        DropItem "ZDRPGShieldAccessory22",    255, 3; // RR-G0
        DropItem "ZDRPGShieldAccessory23",    255, 2; // E1N-T31
        DropItem "ZDRPGShieldAccessory24",    255, 3; // PATR-0T
        DropItem "ZDRPGShieldAccessory25",    255, 4; // RNJSUS-2
        DropItem "ZDRPGShieldAccessory26",    255, 2; // PWAA-9001
        DropItem "ZDRPGShieldAccessory27",    255, 2; // AW-G01
        DropItem "ZDRPGShieldAccessory28",    255, 1; // SCL-AR53
        DropItem "ZDRPGShieldAccessory29",    255, 1; // RF-CT
        DropItem "ZDRPGShieldAccessory30",    255, 6; // TEW-11
        DropItem "ZDRPGShieldAccessory31",    255, 5; // NU-YU5
        DropItem "ZDRPGShieldAccessory32",    255, 4; // RUS-ROU1
        DropItem "ZDRPGShieldAccessory33",    255, 4; // TENS-H11
        DropItem "ZDRPGShieldAccessory34",    255, 3; // TEEM-AU5
        DropItem "ZDRPGShieldAccessory35",    255, 3; // VENG-R
        DropItem "ZDRPGShieldAccessory36",    255, 4; // SANIC-S88
        DropItem "ZDRPGShieldAccessory37",    255, 5; // NAKD-N0W
        DropItem "ZDRPGShieldAccessory38",    255, 3; // HA3-L1N
        DropItem "ZDRPGShieldAccessory39",    255, 3; // HAET-60
        DropItem "ZDRPGShieldAccessory40",    255, 6; // PHA-LX2
        DropItem "ZDRPGShieldAccessory41",    255, 3; // IKU-N7
        DropItem "ZDRPGShieldAccessory42",    255, 4; // REGN-ER8
        DropItem "ZDRPGShieldAccessory43",    255, 3; // COUN-TR20
        DropItem "ZDRPGShieldAccessory44",    255, 3; // PRO-100
        DropItem "ZDRPGShieldAccessory45",    255, 4; // ADPT-V15
        DropItem "ZDRPGShieldAccessory46",    255, 2; // OCD-MX90
        DropItem "ZDRPGShieldAccessory47",    255, 2; // MASTA-R4
        DropItem "ZDRPGShieldAccessory48",    255, 1; // HOW-EV3N
        DropItem "ZDRPGShieldAccessory49",    255, 3; // K00-LAYD
        DropItem "ZDRPGShieldAccessory50",    255, 2; // SKROO-G3
        DropItem "ZDRPGShieldAccessory51",    255, 1; // INFI-NT1
        DropItem "ZDRPGShieldAccessory52",    255, 1; // REMI-500
        DropItem "ZDRPGShieldAccessory53",    255, 1; // FLAN-495
        DropItem "ZDRPGShieldAccessory54",    255, 3; // TOJ1-K0
        DropItem "ZDRPGShieldAccessory55",    255, 4; // TRANS-EB2S2
        DropItem "ZDRPGShieldAccessory56",    255, 6; // LIL-ZZ8
        DropItem "ZDRPGShieldAccessory57",    255, 2; // MURD-BURD
        DropItem "ZDRPGShieldAccessory58",    255, 2; // LKY-BSTRD4
        DropItem "ZDRPGShieldAccessory59",    255, 4; // HEL-FY20
        DropItem "ZDRPGShieldAccessory60",    255, 3; // MUN3-MAG
        DropItem "ZDRPGShieldAccessory61",    255, 2; // EFF-C13
        DropItem "ZDRPGShieldAccessory62",    255, 2; // SYN-C3P
        DropItem "ZDRPGShieldAccessory63",    255, 4; // TUFF-MAG3
        DropItem "ZDRPGShieldAccessory64",    255, 3; // UBR-MANZ5
        DropItem "ZDRPGShieldAccessory65",    255, 2; // HORD-3RR
        DropItem "ZDRPGShieldAccessory66",    255, 3; // S-SP4G3TT
    }
}

class ZDRPGStimDropper : RandomSpawner
{
    Default
    {
        // Stims
        DropItem "ZDRPGStimSmall",            255, 70;
        DropItem "ZDRPGStimMedium",           255, 20;
        DropItem "ZDRPGStimLarge",            255, 9;
        DropItem "ZDRPGStimXL",               255, 1;
    }
}

class ZDRPGVialDropper : RandomSpawner
{
    Default
    {
        // Stats
        DropItem "ZDRPGVialStrength",         255, 20;
        DropItem "ZDRPGVialDefense",          255, 20;
        DropItem "ZDRPGVialVitality",         255, 20;
        DropItem "ZDRPGVialEnergy",           255, 20;
        DropItem "ZDRPGVialRegeneration",     255, 20;
        DropItem "ZDRPGVialAgility",          255, 20;
        DropItem "ZDRPGVialCapacity",         255, 20;
        DropItem "ZDRPGVialLuck",             255, 20;
        
        // Rare Vials
        DropItem "ZDRPGVialDropperRare",      255, 5;
        
        // Stim Packages
    //  DropItem "ZDRPGStimPackageStat",      255, 1;
    //  DropItem "ZDRPGStimPackagePowerup",   255, 1;
    }
}

class ZDRPGVialDropperRare : RandomSpawner
{
    Default
    {
        // Boosters
        DropItem "ZDRPGVialPotency",          255, 10;
        DropItem "ZDRPGVialPurifier",         255, 10;
        
        // Powerups
        DropItem "ZDRPGVialIndestructible",   255, 10;
        DropItem "ZDRPGVialShadow",           255, 10;
        DropItem "ZDRPGVialInfinity",         255, 10;
        DropItem "ZDRPGVialChrono",           255, 10;
        DropItem "ZDRPGVialAdrenaline",       255, 10;
        DropItem "ZDRPGVialGravity",          255, 10;
        DropItem "ZDRPGVialVampire",          255, 10;
        DropItem "ZDRPGVialRage",             255, 10;
        DropItem "ZDRPGVialMagnetic",         255, 10;

        // Stims
        DropItem "ZDRPGStimDropper",          255, 5;
    }
}

class ZDRPGTurretDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGTurretPart",       255, 93;
        DropItem "ZDRPGTurretPartCrate",  255, 5;
        DropItem "ZDRPGDestroyedTurret",  255, 2;
    }
}

class ZDRPGChipDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGChipGold",         255, 32;
        DropItem "ZDRPGChipPlatinum",     255, 1;
    }   
}

class ZDRPGHealthMonsterDropper : RandomSpawner 
{
    Default
    {
        DropItem "ZDRPGStimpack",         255, 80;
        DropItem "ZDRPGMedikit",          255, 15;
        DropItem "ZDRPGLargeMedikit",     255, 5;
    }
}

class ZDRPGEPMonsterDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGLittleEPCapsule",  255, 50;
        DropItem "ZDRPGEPCapsule",        255, 40;
        DropItem "ZDRPGBigEPCapsule",     255, 10;
    }
}

class ZDRPGAmmoMonsterDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGClip",             255, 150;
        DropItem "ZDRPGShell",            255, 75;
        DropItem "ZDRPGRocketAmmo",       255, 45;
        DropItem "ZDRPGCell",             255, 30;
    }
}

class ZDRPGTurretMonsterDropper : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGTurretPart",       255, 98;
        DropItem "ZDRPGTurretPartCrate",  255, 2;
    }
}

// MARINES
// --------------------------------------------------

class ZDRPGMarineOutpostSpawner : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGMarineGuardPistol",            255, 12;
        DropItem "ZDRPGMarineGuardShotgun",           255, 15;
        DropItem "ZDRPGMarineGuardDoubleShotgun",     255, 5;
        DropItem "ZDRPGMarineGuardChaingun",          255, 7;
        DropItem "ZDRPGMarineGuardBattleRifle",       255, 20;
        DropItem "ZDRPGMarineFemGuardBattleRifle",    255, 20;
    }
}

class ZDRPGMarineReinforcementSpawner : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGMarineShotgun",                255, 15;
        DropItem "ZDRPGMarineDoubleShotgun",          255, 5;
        DropItem "ZDRPGMarineChaingun",               255, 10;
        DropItem "ZDRPGMarineBattleRifle",            255, 20;
        DropItem "ZDRPGMarineFemBattleRifle",         255, 20;
        DropItem "ZDRPGMarineRocketLauncher",         255, 6;
        DropItem "ZDRPGMarinePlasmaRifle",            255, 8;
        DropItem "ZDRPGMarineBFG9000",                255, 2;
    }
}

// LOOT
// --------------------------------------------------

// Generic Loot locations
class ZDRPGGenericLootRandomizer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGLootMedicalSupplies",     255, 30;
        DropItem "ZDRPGLootChemicals",           255, 30;
        DropItem "ZDRPGLootHazardousMaterials",  255, 30;
        DropItem "ZDRPGLootAnomalousMaterials",  255, 30;
        DropItem "ZDRPGLootBriefcase",           255, 30;
        DropItem "ZDRPGLootComputerData",        255, 30;
        DropItem "ZDRPGLootGunParts",            255, 15;
        DropItem "ZDRPGLootAmmoCasings",         255, 15;
        DropItem "ZDRPGLootFuelCapsule",         255, 10;
        DropItem "ZDRPGLootScrapMetals",         255, 15;
        DropItem "ZDRPGLootScrapElectronics",    255, 15;
        DropItem "ZDRPGLootExperimentalParts",   255, 10;
        DropItem "ZDRPGLootDemonArtifact",       255, 5;
    }
}

// AMMO
// --------------------------------------------------

// Backpack locations
class ZDRPGBackpackRandomizer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGSmallBackpack",    255, 50;
        DropItem "ZDRPGBackpack",         255, 40;
        DropItem "ZDRPGBigBackpack",      255, 10;
    //  DropItem "ZDRPGCrate",            255, 1;
    }
}

// HEALTH ITEMS
// --------------------------------------------------

// Health Bonus Locations
class ZDRPGHealthBonusReplacer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGLootSpawner",      255, 226;
        DropItem "ZDRPGHealthBonus",      255, 30;
    }

    override Name ChooseSpawn()
    {
        for(int i = 0; i<Players.Size(); i++)
		{
            let playerStart = LevelLocals.PickPlayerStart(i);
            if(LevelLocals.Vec3Diff(playerStart, self.pos).length() <= 550)
                return 'ZDRPGHealthBonus';
        }

        return super.ChooseSpawn();
    }
}

// Stimpack Locations
class ZDRPGStimpackRandomizer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGHealthBonus",      255, 100;
        DropItem "ZDRPGStimpack",         255, 50;
        DropItem "ZDRPGMedikit",          255, 15;
        DropItem "ZDRPGLargeMedikit",     255, 5;
    }
}

// Medikit Locations
class ZDRPGMedikitRandomizer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGHealthBonus",      255, 150;
        DropItem "ZDRPGStimpack",         255, 50;
        DropItem "ZDRPGMedikit",          255, 30;
        DropItem "ZDRPGLargeMedikit",     255, 10;
        DropItem "ZDRPGXLMedikit",        255, 6;
        DropItem "ZDRPGMedPack",          255, 3;
        DropItem "ZDRPGSurgeryKit",       255, 1;
    }
}

// Soulsphere Locations
class ZDRPGSoulSphereRandomizer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGSoulsphere",   255, 70;
        DropItem "ZDRPGSoulsphere2",  255, 20;
        DropItem "ZDRPGSoulsphere3",  255, 9;
        DropItem "ZDRPGLifeDropper",  255, 1;
    }
}

// ARMOR ITEMS
// --------------------------------------------------

// Armor Bonus Locations
class ZDRPGArmorBonusReplacer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGArmorBonusSpawner",    255, 226;
        DropItem "ZDRPGArmorBonus",           255, 30;
    }
}

// Green Armor Locations
class ZDRPGGreenArmorRandomizer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGGreenArmor",               255, 50;
        DropItem "ZDRPGReinforcedGreenArmor",     255, 10;
        DropItem "ZDRPGBlueArmor",                255, 40;
        DropItem "ZDRPGReinforcedBlueArmor",      255, 5;
        DropItem "ZDRPGYellowArmor",              255, 10;
        DropItem "ZDRPGReinforcedYellowArmor",    255, 1;
    }
}

// Blue Armor Locations
class ZDRPGBlueArmorRandomizer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGYellowArmor",              255, 75;
        DropItem "ZDRPGReinforcedYellowArmor",    255, 20;
        DropItem "ZDRPGRedArmor",                 255, 20;
        DropItem "ZDRPGReinforcedRedArmor",       255, 5;
        DropItem "ZDRPGWhiteArmor",               255, 5;
        DropItem "ZDRPGReinforcedWhiteArmor",     255, 1;
    }
}

// POWERUPS
// --------------------------------------------------

// Invulnerability Sphere Locations
class ZDRPGInvulnerabilitySphereRandomizer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGInvulnerabilitySphere",    255, 100;
    //  DropItem "ZDRPGCrate",                    255, 1;
    }
}

// Blur Sphere Locations
class ZDRPGBlurSphereRandomizer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGBlurSphere",               255, 100;
    //  DropItem "ZDRPGCrate",                    255, 1;
    }
}

// SHOP DISPLAYS
// --------------------------------------------------

class ZDRPGShopWeaponRandomizer : RandomSpawner
{
    Default
    {
        DropItem "Pistol",               255, 8;
        DropItem "Shotgun",              255, 7;
        DropItem "SuperShotgun",         255, 6;
        DropItem "Chaingun",             255, 5;
        DropItem "RocketLauncher",       255, 4;
        DropItem "PlasmaRifle",          255, 3;
        DropItem "BFG9000",              255, 2;
        DropItem "Chainsaw",             255, 1;
    }
}

class ZDRPGShopAmmoRandomizer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGClip",             255, 11;
        DropItem "ZDRPGClipBox",          255, 10;
        DropItem "ZDRPGShell",            255, 9;
        DropItem "ZDRPGShellBox",         255, 8;
        DropItem "ZDRPGRocketAmmo",       255, 7;
        DropItem "ZDRPGRocketBox",        255, 6;
        DropItem "ZDRPGCell",             255, 5;
        DropItem "ZDRPGCellPack",         255, 4;
        DropItem "ZDRPGSmallBackpack",    255, 3;
        DropItem "ZDRPGBackpack",         255, 2;
        DropItem "ZDRPGBigBackpack",      255, 1;
    }
}

class ZDRPGShopHealthRandomizer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGStimpack",         255, 10;
        DropItem "ZDRPGMedikit",          255, 9;
        DropItem "ZDRPGLargeMedikit",     255, 8;
        DropItem "ZDRPGXLMedikit",        255, 7;
        DropItem "ZDRPGMedPack",          255, 6;
        DropItem "ZDRPGSurgeryKit",       255, 5;
        DropItem "ZDRPGSoulSphere",       255, 4;
        DropItem "ZDRPGSoulsphere2",      255, 3;
        DropItem "ZDRPGSoulsphere3",      255, 2;
        DropItem "ZDRPGLifeDropper",      255, 1;
    }
}

class ZDRPGShopArmorRandomizer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGGreenArmor",       255, 5;
        DropItem "ZDRPGBlueArmor",        255, 4;
        DropItem "ZDRPGYellowArmor",      255, 3;
        DropItem "ZDRPGRedArmor",         255, 2;
        DropItem "ZDRPGWhiteArmor",       255, 1;
    }
}

class ZDRPGShopPowerupRandomizer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGInvulnerabilityCharge",    255, 1;
        DropItem "ZDRPGInvisibilityCharge",       255, 1;
        DropItem "ZDRPGTimeSphere",               255, 1;
        DropItem "ZDRPGRegenSphere",              255, 5;
        DropItem "ZDRPGRadSuit",                  255, 5;
        DropItem "ZDRPGInfrared",                 255, 5;
        DropItem "ZDRPGAllMap",                   255, 5;
    //  DropItem "ZDRPGBerserk",                  255, 5;
    }
}

class ZDRPGShopMiscRandomizer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGTurretPart";
    }
}

class ZDRPGShopShieldRandomizer : ZDRPGShieldDropper {}

class ZDRPGShopAugRandomizer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGVialDropper",              255, 25;
        DropItem "ZDRPGStimDropper",              255, 10;
        DropItem "ZDRPGAugDropper",               255, 1;
    }
}

class ZDRPGShopRandomizer : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGShopWeaponRandomizer";
        DropItem "ZDRPGShopAmmoRandomizer";
        DropItem "ZDRPGShopHealthRandomizer";
        DropItem "ZDRPGShopArmorRandomizer";
        DropItem "ZDRPGShopPowerupRandomizer";
        DropItem "ZDRPGShopMiscRandomizer";
        DropItem "ZDRPGShopShieldRandomizer";
        DropItem "ZDRPGShopAugRandomizer";
    }
}

// Generic Item Dropper
class ZDRPGItemDropper : Actor
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_Jump(32, "DropItem");
            TNT1 A -1;
            Stop;
        DropItem:
            TNT1 A 1 A_SpawnItemEx("ZDRPGAmmoDropper", 0, 0, 0, Random(-4, 4), Random(-4, 4), Random(1, 8));
            TNT1 A 0 A_Jump(32, "DropItem");
            TNT1 A -1;
            Stop;
    }
}

//DOOMRPG REBALANCE ACS RANDOMIZERS
// --------------------------------------------------

// Health Bonus Randomizer
class ZDRPGLootSpawner : RandomSpawner
{
    Default
    {
        DropItem "ZDRPGLootMedicalSupplies";
        DropItem "ZDRPGLootChemicals";
        DropItem "ZDRPGLootHazardousMaterials";
        DropItem "ZDRPGLootAnomalousMaterials";
        DropItem "ZDRPGLootBriefcase";
        DropItem "ZDRPGLootComputerData";
        DropItem "ZDRPGLootGunParts";
        DropItem "ZDRPGLootAmmoCasings";
        DropItem "ZDRPGLootFuelCapsule";
        DropItem "ZDRPGLootScrapMetals";
        DropItem "ZDRPGLootScrapElectronics";
        DropItem "ZDRPGLootExperimentalParts";
        DropItem "ZDRPGLootDemonArtifact";
    }
}

// Armor Bonus Randomizer
class ZDRPGArmorBonusSpawner : MapSpot
{
    States
    {
        Spawn:
            TNT1 A -1 NoDelay ACS_NamedExecuteWithResult("ZDRPGGenericLootSpawner");
            Stop;
    }
}

// Armor Randomizer
class ZDRPGArmorSpawner : MapSpot
{
    States
    {
        Spawn:
            TNT1 A -1 NoDelay ACS_NamedExecuteWithResult("ZDRPGArmorSpawner");
            Stop;
    }
}

// Weapon Randomizer
class ZDRPGWeaponSpawner : MapSpot
{
    States
    {
        Spawn:
            TNT1 A -1 NoDelay ACS_NamedExecuteWithResult("ZDRPGWeaponSpawner");
            Stop;
    }
}

// Shield Randomizer
class ZDRPGShieldSpawner : MapSpot
{
    States
    {
        Spawn:
            TNT1 A -1 NoDelay ACS_NamedExecuteWithResult("ZDRPGShieldSpawner");
            Stop;
    }
}