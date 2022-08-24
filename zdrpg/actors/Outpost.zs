class ZDRPGMarine : Actor
{
    Default {
        Health 10;
    }

    override bool Used(Actor user) 
    {
        ZDRPG_ZF_PlayerMenu link; 
        link.setMenu('ZDRPG_ZF_ShopMenu'); 
        return true;
    }
}

class ZDRPGLevelTransport
{
    static void OpenMenu()
    {
        ZDRPG_ZF_PlayerMenu link;
        link.setMenu('ZDRPG_ZF_TransportMenu');
    }
}

class ZDRPGPowerOutage : Actor
{
    Default {
        Health 125;
        +SHOOTABLE;
        +NOBLOOD;
    }
    States
    {
        Spawn:
            TNT1 A -1;
            Stop;
    }

    override void Die(Actor source, Actor inflictor, int dmgflags, Name MeansOfDeath)
    {
        console.printf('dead. no power for you');
    }
}

class ZDRPGMissionInteraction : Actor
{
    Default {
        Radius 50;
    }
    States
    {
        Spawn:
            TNT1 A -1;
            Stop;
    }

    override bool Used(Actor user) 
    {
        ZDRPG_ZF_PlayerMenu link; 
        link.setMenu('ZDRPG_ZF_AugsMenu'); 
        return true;
    }
}

class ZDRPGShopInteraction : Actor
{
    States
    {
        Spawn:
            TNT1 A -1;
            Stop;
    }

    override bool Used(Actor user) 
    {
        ZDRPG_ZF_PlayerMenu link; 
        link.setMenu('ZDRPG_ZF_ShopMenu'); 
        return true;
    }
}

class ZDRPGSpecialShopInteraction : Actor
{
    States
    {
        Spawn:
            TNT1 A -1;
            Stop;
    }

    override bool Used(Actor user) 
    {
        ZDRPG_ZF_PlayerMenu link; 
        link.setMenu('ZDRPG_ZF_TurretMenu'); 
        return true;
    }
}

class DRPGLootDropper : RandomSpawner //Loot Spawner on Missions BBQ
{
    Default 
    {
        DropItem "DRPGLootMedicalSupplies",    255, 10;
        DropItem "DRPGLootChemicals",          255, 10;
        DropItem "DRPGLootHazardousMaterials", 255, 10;
        DropItem "DRPGLootAnomalousMaterials", 255, 5;
        DropItem "DRPGLootBriefcase",          255, 5;
        DropItem "DRPGLootComputerData",       255, 10;
        DropItem "DRPGLootGunParts",           255, 1;
        DropItem "DRPGLootAmmoCasings",        255, 1;
        DropItem "DRPGLootFuelCapsule",        255, 1;
        DropItem "DRPGLootScrapMetals",        255, 1;
        DropItem "DRPGLootScrapElectronics",   255, 1;
        DropItem "DRPGLootExperimentalParts",  255, 1;
        DropItem "DRPGLootDemonArtifact",      255, 5;
    }
}

class ZDRPGOutpostPadBaseLine : Actor
{
    Default 
    {
        +Missile;
        +NoGravity;
        +NoBlockmap;
        +NoInteraction;
        -Solid;
        Radius 0;
        Height 0;
        RenderStyle "Add";
        Alpha 0.04;
        Scale 0.20;
    }
}

//---Praticle Effects (pad praticle code based on Tormentor667 Stronghold_Pad praticles )
class DRPGBaseLineMed : ZDRPGOutpostPadBaseLine //Medic
{ 
    States
    {
        Spawn:
            HEAS AAAAA 1 Bright A_FadeIn(0.2);
            HEAS AAAAAAAAAAAAAAAA 1 Bright A_FadeOut(0.06);
            Stop;
    }
}

class DRPGBaseLineArmor: ZDRPGOutpostPadBaseLine //Armor
{
    States
    {
        Spawn:
            HEAR AAAAA 1 Bright A_FadeIn(0.2);
            HEAR AAAAAAAAAAAAAAAA 1 Bright A_FadeOut(0.06);
            Stop;
    }
}

class DRPGBaseLineAUG : ZDRPGOutpostPadBaseLine //AUG battery
{
    States
    {
        Spawn:
            HEAB AAAAA 1 Bright A_FadeIn(0.2);
            HEAB AAAAAAAAAAAAAAAA 1 Bright A_FadeOut(0.06);
            Stop;
    }
}

class DRPGBaseLineEP : ZDRPGOutpostPadBaseLine //EP
{
    States
    {
        Spawn:
            HEAM AAAAA 1 Bright A_FadeIn(0.2);
            HEAM AAAAAAAAAAAAAAAA 1 Bright A_FadeOut(0.06);
            Stop;
    }
}

class ZDRPGOutpostParticle : Actor
{
    Default 
    {
        +NoBlockMap;
        +NoGravity;
        +NoSector;
        +NoInteraction;
        +NoClip;
        -Solid;
        +CLIENTSIDEONLY;
    }
    States
    {
        Inactive:
            TNT1 A 1;
            Loop;
    }
}

class MedParticle: ZDRPGOutpostParticle
{
    States
    {
        Spawn:
            Active:
                TNT1 A 0;
                TNT1 A 0 A_JumpIf(Args[1], "Circle");
                TNT1 A 1 A_SpawnItemEx ("DRPGBaseLineMed", random(-Args[0], Args[0]), random(-Args[0], Args[0]), random(0,2*Args[1]), 0, 0, random(1,3), 0, 129, Args[2]); 
                Loop;
            Circle:
                TNT1 A 0;
                TNT1 A 1 A_SpawnItemEx ("DRPGBaseLineMed", random(-Args[0], Args[0]), 0, random(0,2*Args[1]), 0, 0, random(1,3), Random(0, 360), 129, Args[2]) ;
                Loop;
    }     
        
}

class MedParticleRed : MedParticle
{
    Default 
    {
        translation "80:111=176:191";
    }
}

class ArmorParticle : ZDRPGOutpostParticle
{
    States
    {
        Spawn:
            Active:
                TNT1 A 0;
                TNT1 A 0 A_JumpIf(Args[1], "Circle");
                TNT1 A 1 A_SpawnItemEx ("DRPGBaseLineArmor", random(-Args[0], Args[0]), random(-Args[0], Args[0]), random(0,2*Args[1]), 0, 0, random(1,3), 0, 129, Args[2]);
                Loop;
            Circle:
                TNT1 A 0;
                TNT1 A 1 A_SpawnItemEx ("DRPGBaseLineArmor", random(-Args[0], Args[0]), 0, random(0,2*Args[1]), 0, 0, random(1,3), Random(0, 360), 129, Args[2]);
                Loop;
    }     
        
}

class AUGParticle : ZDRPGOutpostParticle
{
    States
    {
        Spawn:
            Active:
                TNT1 A 0;
                TNT1 A 0 A_JumpIf(Args[1], "Circle");
                TNT1 A 1 A_SpawnItemEx ("DRPGBaseLineAUG", random(-Args[0], Args[0]), random(-Args[0], Args[0]), random(0,2*Args[1]), 0, 0, random(1,3), 0, 129, Args[2]);
                Loop;
            Circle:
                TNT1 A 0;
                TNT1 A 1 A_SpawnItemEx ("DRPGBaseLineAUG", random(-Args[0], Args[0]), 0, random(0,2*Args[1]), 0, 0, random(1,3), Random(0, 360), 129, Args[2]);
                Loop;
    }            
}

class EPParticle : ZDRPGOutpostParticle
{
    States
    {
        Spawn:
            Active:
                TNT1 A 0;
                TNT1 A 0 A_JumpIf(Args[1], "Circle");
                TNT1 A 1 A_SpawnItemEx ("DRPGBaseLineEP", random(-Args[0], Args[0]), random(-Args[0], Args[0]), random(0,2*Args[1]), 0, 0, random(1,3), 0, 129, Args[2]);
                Loop;
            Circle:
                TNT1 A 0;
                TNT1 A 1 A_SpawnItemEx ("DRPGBaseLineEP", random(-Args[0], Args[0]), 0, random(0,2*Args[1]), 0, 0, random(1,3), Random(0, 360), 129, Args[2]);
                Loop;
    }        
}

//--------------------------------------------------------
// Signs
class ZDRPGOutpostSign : Actor
{
    Default {
        +SpawnCeiling
        +NoGravity
        +WALLSPRITE
    }
}

class OutpostSignMissionBBS: ZDRPGOutpostSign 
{
    States
    {
        Spawn:
            OMRK A -1 Light("OUTPOSTSIGN");
            Stop;
    }
}

class OutpostSignShop : ZDRPGOutpostSign
{
    Default {
        Scale 1.5;
    }
    States
    {
        Spawn:
            OMRK B -1 Light("OUTPOSTSIGN");
            Stop;
    }
}

class OutpostSignTransporter : ZDRPGOutpostSign
{   
    Default {
        Scale 0.5;
    }
    States
    {
        Spawn:
            OMRK C -1 Light("OUTPOSTSIGN");
            Stop;
    }
}

class OutpostSignSkillComputer : ZDRPGOutpostSign
{
    States
    {
        Spawn:
            OMRK D -1 Light("OUTPOSTSIGN");
            Stop;
    }
}

class OutpostSignRechargePads : ZDRPGOutpostSign
{
    States
    {
        Spawn:
            OMRK G -1 Light("OUTPOSTSIGN");
            Stop;
    }
}

class OutpostSignEastArea : ZDRPGOutpostSign
{
    States
    {
        Spawn:
            OMRK F -1 Light("OUTPOSTSIGN");
            Stop;
    }
}

class OutpostSignItemRoulette : ZDRPGOutpostSign
{
    States
    {
        Spawn:
            OMRK H -1 Light("OUTPOSTSIGN");
            Stop;
    }
}

class OutpostSignArena : ZDRPGOutpostSign
{
    States
    {
        Spawn:
            OMRK E -1 Light("OUTPOSTSIGN");
            Stop;
    }
}

class OutpostSignArenaFar : ZDRPGOutpostSign
{
    States
    {
        Spawn:
            OMRK E -1 Light("OUTPOSTSIGN");
            Stop;
    }
}

class OutpostSignArenaWS : ZDRPGOutpostSign
{
    Default 
    {
        Scale 0.5;
    }

    States
    {
        Spawn:
            OMRK I -1 Light("OUTPOSTSIGN");
            Stop;
    }
}

class OutpostSignArenaStart : ZDRPGOutpostSign
{
    States
    {
        Spawn:
            OMRK J -1 Light("OUTPOSTSIGN");
            Stop;
    }
}

class OutpostSignArenaReady : ZDRPGOutpostSign
{
    Default
    {
        Scale 0.5;
    }

    States
    {
        Spawn:
            OMRK K -1 Light("OUTPOSTSIGN");
            Stop;
    }
}

class OutpostSignShootingRange : ZDRPGOutpostSign
{
    Default
    {
        Scale 0.5;
    }

    States
    {
        Spawn:
            OMRK M -1 Light("OUTPOSTSIGN");
            Stop;
    }
}

class OutpostSignSale : ZDRPGOutpostSign
{   
    Default 
    {
        Scale 0.5;
    }
    
    States
    {
        Spawn:
            OMRK N -1 Light("OUTPOSTSIGN");
            Stop;
    }
}

class OutpostSignSurgeonCapsule : ZDRPGOutpostSign
{
    Default
    {
        Scale 0.5;
    }

    States
    {
        Spawn:
            OMRK O -1 Light("OUTPOSTSIGN");
            Stop;
    }
}

class OutpostSignDisassemblingDevice : ZDRPGOutpostSign
{
    Default
    {
        Scale 0.5;
    }
    
    States
    {
        Spawn:
            OMRK P -1 Light("OUTPOSTSIGN");
            Stop;
    }
}

// Stuff
class OutpostAdminLamp : Actor
{
    Default
    {
        +SOLID;

        Height 48;
        Radius 12;
    }    

    States
    {
        Spawn:
            COLU B -1 Light("OutpostLamp1");
            Stop;
    }
}

class DRPGOutpostAlarm : SwitchableDecoration
{
    Default
    {
        +SpawnCeiling;
        +NoGravity;
    }
    
    States
    {
        Spawn:
            OALM C 0 NoDelay Thing_ChangeTID (0, 1600);
        Inactive:
            OALM C -1;
            Stop;
        Active:
            OALM A 0 A_Jump (256, 1, 2, 3);
            OALM AAA 1 Light ("OUTPOSTALARM");
        AlarmLoop:
            OALM A 4 Light ("OUTPOSTALARM") A_PlaySound ("misc/alarm", CHAN_VOICE, 1.0, 1, ATTN_NORM);
            OALM BCD 4 Light ("OUTPOSTALARM");
            Loop;
    }
}

// Outpost Particle Effects
// --------------------------------------------------

class DRPGOutpostPadParticleSpawner : Actor
{
    int user_angle;
    int user_angleofs;
    int user_radius;

    Default
    {
        +NoBlockmap;
        +NoSector;
        +NoGravity;
        RenderStyle "None";
    }
    States
    {
        Spawn:
            TNT1 A 3;
        MakeCircle:
            TNT1 A 0 
            {
                user_angle += 60;
                A_JumpIf (user_angle >= 360, "Advance");
            }
            Loop;
        Advance:
            TNT1 A 0 
            {
                user_angle = 0;
                user_angleofs += 6;
                user_radius -= 8;
                A_JumpIf (user_radius < 8, 1);
            }
            Goto Spawn;

            TNT1 A 0
            {
                user_radius = 128;
            }
            Goto Spawn;
    }
}

class DRPGOutpostLevelTransportParticleSpawner : DRPGOutpostPadParticleSpawner
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay 
            {
                A_SpawnItemEx ("DRPGOutpostLevelTransportParticle", 32,  0, 0, 0, 0, 0,  user_angle);
                A_SpawnItemEx ("DRPGOutpostLevelTransportParticle", 64,  0, 0, 0, 0, 0, -user_angle);
                A_SpawnItemEx ("DRPGOutpostLevelTransportParticle", 96,  0, 0, 0, 0, 0,  user_angle);
                A_SpawnItemEx ("DRPGOutpostLevelTransportParticle", 128, 0, 0, 0, 0, 0, -user_angle);
            }      
            TNT1 A 3
            {   
                user_angle += 6;
            }
            Loop;
    }
}

class DRPGOutpostHealthPadParticleSpawner : DRPGOutpostPadParticleSpawner 
{
    States
    {
        MakeCircle:
            TNT1 A 0 A_SpawnItemEx ("DRPGOutpostHealthPadParticle", user_radius, 0, 0, 0, 0, 0, user_angle + user_angleofs);
            goto super::MakeCircle;
    }
}

class DRPGOutpostEPPadParticleSpawner : DRPGOutpostPadParticleSpawner
{
    States
    {
        MakeCircle:
            TNT1 A 0 A_SpawnItemEx ("DRPGOutpostEPPadParticle", user_radius, 0, 0, 0, 0, 0, user_angle + user_angleofs);
            goto super::MakeCircle;
    }
}

class DRPGOutpostArmorPadParticleSpawner : DRPGOutpostPadParticleSpawner
{
    States
    {
        MakeCircle:
            TNT1 A 0 A_SpawnItemEx ("DRPGOutpostArmorPadParticle", user_radius, 0, 0, 0, 0, 0, user_angle + user_angleofs);
            goto super::MakeCircle;
    }
}

class DRPGOutpostBatteryPadParticleSpawner : DRPGOutpostPadParticleSpawner
{
    States
    {
        MakeCircle:
            TNT1 A 0 A_SpawnItemEx ("DRPGOutpostBatteryPadParticle", user_radius, 0, 0, 0, 0, 0, user_angle + user_angleofs);
            goto super::MakeCircle;
    }
}

class DRPGOutpostPadParticle : Actor
{
    Default
    {
        +NoInteraction;

        RenderStyle "Add";
        Alpha 1.0;
        Scale 0.05;
    }

    States
    {
        Spawn:
            TNT1 A 0 
            {
                A_ChangeVelocity (0, 0, 0.05);
                A_FadeOut (1.0 / 70);
                A_JumpIf (ScaleX <= 0, "Death");
            }
            Loop;
        Death:
            TNT1 A 0;
            Stop;
    }
}

class DRPGOutpostLevelTransportParticle : DRPGOutpostPadParticle
{
    States
    {
        Spawn:
            PTCL A 1 Bright A_SetScale (ScaleX - (0.05 / 70));
            TNT1 A 0 
            {
                A_ChangeVelocity (0, 0, 0.1);
                A_JumpIf (ScaleX <= 0, "Death");
            }
            Loop;
    }
}



class DRPGOutpostHealthPadParticle : DRPGOutpostPadParticle
{
    Default
    {
        Alpha 0.5;
    }

    States
    {
        Spawn:
            AUEF F 1 Bright A_SetScale (ScaleX - (0.05 / 70));
            TNT1 A 0 {
                A_ChangeVelocity (0, 0, 0.05);
                A_FadeOut (0.5 / 70);
                A_JumpIf (ScaleX <= 0, "Death");
            }
            Loop;
    }
}

class DRPGOutpostEPPadParticle : DRPGOutpostPadParticle
{
    Default
    {
        Alpha 0.5;
    }

    States
    {
        Spawn:
            AUEF G 1 Bright A_SetScale (ScaleX - (0.05 / 70));
            TNT1 A 0 
            {
                A_ChangeVelocity (0, 0, 0.05);
                A_FadeOut (0.5 / 70);
                A_JumpIf (ScaleX <= 0, "Death");
            }
            Loop;
    }
}

class DRPGOutpostArmorPadParticle : DRPGOutpostPadParticle
{
    States
    {
        Spawn:
            AUEF E 1 Bright A_SetScale (ScaleX - (0.05 / 70));
            goto super::Spawn;
    }
}

class DRPGOutpostBatteryPadParticle : DRPGOutpostPadParticle
{ 
    States
    {
        Spawn:
            PTCL B 1 Bright A_SetScale (ScaleX - (0.05 / 70));
            goto super::Spawn;
    }
}

// Automap Markers
// --------------------------------------------------

class OutpostMarker : MapMarker
{
    Default
    {
        Scale 0.25;
        RenderStyle "Add";
    }
}

class OutpostMarker_ArmorPad : OutpostMarker
{
    States
    {
        Spawn:
            OMRK A -1;
            Stop;
    }
}

class OutpostMarker_AugBatteryPad : OutpostMarker 
{
    States
    {
        Spawn:
            OMRK B -1;
            Stop;
    }
}

class OutpostMarker_EPPad : OutpostMarker
{
    States
    {
        Spawn:
            OMRK C -1;
            Stop;
    }
}

class OutpostMarker_HealthPad : OutpostMarker
{
    States
    {
        Spawn:
            OMRK D -1;
            Stop;
    }
}

class OutpostMarker_ItemLockers : OutpostMarker
{
    States
    {
        Spawn:
            OMRK E -1;
            Stop;
    }
}

class OutpostMarker_MissionBBS : OutpostMarker
{
    States
    {
        Spawn:
            OMRK F -1;
            Stop;
    }
}

class OutpostMarker_Shop : OutpostMarker
{
    States
    {
        Spawn:
            OMRK G -1;
            Stop;
    }
}

class OutpostMarker_LevelTransporter : OutpostMarker
{
    States
    {
        Spawn:
            OMRK H -1;
            Stop;
    }
}

class OutpostMarker_SkillComputer : OutpostMarker
{
    States
    {
        Spawn:
            OMRK I -1;
            Stop;
    }
}

class OutpostMarker_TokenConverter : OutpostMarker
{
    States
    {
        Spawn:
            OMRK J -1;
            Stop;
    }
}

class OutpostMarker_GamesTable : OutpostMarker
{
    States
    {
        Spawn:
            OMRK K -1;
            Stop;
    }
}

class OutpostMarker_Sale : OutpostMarker
{
    States
    {
        Spawn:
            OMRK N -1;
            Stop;
    }
}

// Title Map Stuff
// --------------------------------------------------

// Borrowed from DRLA
// WHAT A SHAME

class DRPGTeleportRift : Actor
{
    int user_distance;
    int user_angle;

    Default
    {
        Health 5000;
        Radius 64;
        Height 64;
        Mass 0x7FFFFFFF;
        Speed 0;

        Monster;
        +NOBLOCKMAP;
        +NOGRAVITY;
        +NOTELEPORT;
        +LOOKALLAROUND;
        +INVULNERABLE;

        RenderStyle "Add";
        Alpha 0.33;
        Scale 3.2;
    }

    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_SpawnItemEx("DRPGTeleportRiftAlerter");
        See:
            TNT1 A 0 A_Chase;
            TFOG BBBBCCCCDDDDCCCC 1 Bright A_Jump(12, "MonsterSpawn");
            Loop;
        MonsterSpawn:
            TNT1 A 0 {
                user_distance = random(0, 256);
                user_angle = random(0, 359);
                A_SpawnItemEx("TeleportFog", 0, user_distance, 0, 0, 0, 0, user_angle);
                A_SpawnItemEx("DRPGTeleportRiftSpawner", 0, user_distance, 0, 0, 0, 0, user_angle, SXF_TRANSFERPOINTERS | SXF_SETMASTER, 0, TID + 1);
            }
            Goto See;
    }
}

class DRPGTeleportRiftAlerter : Actor
{
    Default
    {
        Monster;
        +NOBLOCKMAP
        +NOGRAVITY
        +NOTELEPORT
    }
    
    States
    {
        Spawn:
        See:
            TNT1 A 1 NoDelay A_AlertMonsters(1024);
            Loop;
    }
}

class DRPGTeleportRiftSpawner : RandomSpawner
{
    Default
    {
        Radius 200;
        Height 120;

        +SOLID;

        DropItem "ZombieMan",            255, 50;
        DropItem "ShotgunGuy",           255, 50;
        DropItem "ChaingunGuy",          255, 50;
        DropItem "DoomImp",              255, 50;
        DropItem "DoomImp",              255, 50;
        DropItem "Demon",                255, 35;
        DropItem "Spectre",              255, 35;
        DropItem "LostSoul",             255, 9;
        DropItem "Cacodemon",            255, 30;
        DropItem "HellKnight",           128, 26;
        DropItem "Revenant",             255, 12;
        DropItem "Fatso",                255, 15;
        DropItem "PainElemental",        255, 3;
        DropItem "BaronOfHell",          64,  15;
        DropItem "Arachnotron",          255, 12;
        DropItem "Archvile",             255, 2;
        DropItem "Cyberdemon",           255, 1;
        DropItem "SpiderMastermind",     255, 1;
    }
}