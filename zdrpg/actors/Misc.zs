// Portable Quick-key Items, for niceness with controller players, and when you don't want to have to use a thousand key binds for everything.

/*ACTOR DRPGPortableStimInjectorItem : CustomInventory
{
    +Inventory.Undroppable
    +InvBar
    
    Inventory.Amount 1
    Inventory.MaxAmount 1
    
    Inventory.Icon "USESTIM"
    
    Tag "Use Stim"
    
    States
    {
    Use:
        TNT1 A 0 ACS_NamedExecuteWithResult ("UseStim")
        Fail
    }
}

ACTOR DRPGPortableStimDisposalItem : CustomInventory
{
    +Inventory.Undroppable
    +InvBar
    
    Inventory.Amount 1
    Inventory.MaxAmount 1
    
    Inventory.Icon "TOSSSTIM"
    
    Tag "Toss Stim"
    
    States
    {
    Use:
        TNT1 A 0 ACS_NamedExecuteWithResult ("ThrowAwayStim")
        Fail
    }
}

ACTOR DRPGPortableFocusItem : CustomInventory
{
    +Inventory.Undroppable
    +InvBar
    
    Inventory.Amount 1
    Inventory.MaxAmount 1
    
    Inventory.Icon "FOCUS"
    
    Tag "Focus Mode"
    
    States
    {
    Use:
        TNT1 A 0 ACS_NamedExecuteWithResult ("ToggleFocusMode")
        Fail
    }
}

ACTOR DRPGPortableAugItem : CustomInventory
{
    +Inventory.Undroppable
    +InvBar
    
    Inventory.Amount 1
    Inventory.MaxAmount 1
    
    Inventory.Icon "AugBatL"
    
    Tag "Reactivate Augs"
    
    States
    {
    Use:
        TNT1 A 0 ACS_NamedExecuteWithResult ("ReactivateDisabledAugs")
        Fail
    }
}

// Icons
Actor DRPGMenuIcon
{
    +NOTIMEFREEZE
    +NOINTERACTION
    
    RenderStyle Add
    
    Scale 0.75
    
    States
    {
    Spawn:
        MNIC A 2 Bright
        Stop
    }
}

Actor DRPGLevelUpArrow
{
    +NOTIMEFREEZE
    +NOINTERACTION
    
    RenderStyle Add
    
    States
    {
    Spawn:
        ARRW A 0 Bright NoDelay A_ChangeVelocity(FRandom(-0.5, 0.5), FRandom(-0.5, 0.5), 1, CVF_REPLACE)
    Fade:
        ARRW A 1 Bright A_FadeOut(0.01, true)
        Loop
    }
}

Actor DRPGRankUpArrow
{
    +NOTIMEFREEZE
    +NOINTERACTION
    
    RenderStyle Add
    
    States
    {
    Spawn:
        ARRW B 0 Bright NoDelay A_ChangeVelocity(FRandom(-0.5, 0.5), FRandom(-0.5, 0.5), 1, CVF_REPLACE)
    Fade:
        ARRW B 1 Bright A_FadeOut(0.01, true)
        Loop
    }
}

Actor DRPGAssassinationIcon
{
    Radius 1
    Height 1
    
    RenderStyle Translucent
    Alpha 0.75
    Scale 0.75
    
    +NOGRAVITY
    +NOBLOCKMAP
    +NOTIMEFREEZE
    +BRIGHT
    
    States
    {
    Spawn:
        ATRG A 2
        Stop
    }
}

Actor DRPGDisruptionIcon
{
    Radius 1
    Height 1
    
    RenderStyle Translucent
    Alpha 0.75
    Scale 0.75
    
    +NOGRAVITY
    +NOBLOCKMAP
    +NOTIMEFREEZE
    +BRIGHT
    
    States
    {
    Spawn:
        DISR A 2
        Stop
    }
}

Actor DRPGPOIArrow
{
    Radius 1
    Height 1
    
    RenderStyle Translucent
    Alpha 0.5
    
    +NOGRAVITY
    +NOBLOCKMAP
    +NOLIFTDROP
    +NOTARGET
    +DONTMORPH
    +DONTSQUASH
    +NOTELEOTHER
    +FLOATBOB
    +NONSHOOTABLE
    
    States
    {
    Spawn:
        ARRW C 4 Bright
        Loop
    }
}

Actor DRPGAlertIcon
{
    +NOINTERACTION
    
    Scale 0.5
    RenderStyle Add
    
    States
    {
    Spawn:
        ALRT A 10 Bright
    Fade:
        ALRT A 1 Bright A_FadeOut(0.05, true)
        Loop
    }
}
*/
// Forcefield Generator
class ZDRPGForcefieldGenerator : Actor
{
    Default
    {
        Radius 8;
        Height 8;
        Speed 0;
        
        RenderStyle "Translucent";
        Alpha 1;
        
        +NOCLIP;
        +NOINTERACTION;
    }
    
    States
    {
        Spawn:
            TNT1 A 0;
        NormalLoop:
            FFGN ABCDCB 1 Bright;
            Goto NormalLoop;
        SixPowerLoop:
            FFGN ABCDCB 1 Bright;
            Goto SixPowerLoop;
        FivePowerLoop:
            FFGN E 1 Bright;
            Goto FivePowerLoop;
        FourPowerLoop:
            FFGN F 1 Bright;
            Goto FourPowerLoop;
        ThreePowerLoop:
            FFGN G 1 Bright;
            Goto ThreePowerLoop;
        TwoPowerLoop:
            FFGN H 1 Bright;
            Goto TwoPowerLoop;
        OnePowerLoop:
            FFGN I 1 Bright;
            Goto OnePowerLoop;
        ZeroPowerLoop:
            FFGN J 1 Bright;
            Goto ZeroPowerLoop;
        Death:
            FFGN K 35 Bright;
            FFGN K 1 Bright A_FadeTo (0, 0.02, 1);
            Goto Death+1;
    }
}

// Bouncy Balls!
class ZDRPGBouncyBall : Actor
{
    int user_type;
    
    Default
    {
        Radius 8;
        Height 32;
        Mass 1;
        Gravity 0.5;
        Speed 0;
        
        BounceType "Doom";
        BounceFActor 1.0;
        
        +SOLID;
        +MISSILE;
        +PUSHABLE;
        +SHOOTABLE;
        +NOBLOOD;
        +BOUNCEONACTORS;
        -BOUNCEAUTOOFF;
    }
    
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ThrustThing(Angle, Random(4, 8), false, 0);
            TNT1 A 0 A_Jump(256, "Ball1", "Ball2", "Ball3", "Ball4", "Ball5", "Ball6");
            Stop;
        Ball1:
            TNT1 A 0 
            {
                user_type = 1;
            }
            SOUL ABCDCB 6 Bright;
            Loop;
        Ball2:
            TNT1 A 0 
            {
                user_type = 2;
            }
            MEGA ABCD 6 Bright;
            Loop;
        Ball3:
            TNT1 A 0 
            {
                user_type = 3;
            }
            PINV ABCD 6 Bright;
            Loop;
        Ball4:
            TNT1 A 0 
            {
                user_type = 4;
            }
            PINS ABCD 6 Bright;
            Loop;
        Ball5:
            TNT1 A 0 
            {
                user_type = 5;
            }
            TIME ABCDCB 4 Bright;
            Loop;
        Ball6:
            TNT1 A 0 
            {
                user_type = 6;
            }
            REGN ABCDCB 4 Bright;
            Loop;
        Death:
            TNT1 A 0 
            {
                ThrustThing(Angle, Random(4, 8), false, 0);
                A_JumpIf(user_type == 1, "Ball1");
                A_JumpIf(user_type == 2, "Ball2");
                A_JumpIf(user_type == 3, "Ball3");
                A_JumpIf(user_type == 4, "Ball4");
                A_JumpIf(user_type == 5, "Ball5");
                A_JumpIf(user_type == 6, "Ball6");
            }
            Stop;
    }
}

// Player Teleport Flag Setter
class ZDRPGPlayerTeleportGhost : Inventory
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    }
    
    States
    {
        Use:
            TNT1 A 0 
            {
                bSOLID = false;   
            }
            Stop;
    }
}

class ZDRPGPlayerTeleportNormal : Inventory
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    }
    
    States
    {
        Use:
            TNT1 A 0
            {
                bSOLID = true;
            }
            Stop;
    }
}

// Misc hacky crap

class ZDRPGTimeFreezerSound : Actor
{
    States
    {
        Spawn:
            TNT1 A 0
            {
                A_StartSound("slomo/in", CHAN_AUTO | CHAN_NOPAUSE, 1.0, false, ATTN_NONE);
                A_StartSound("slomo/loop", CHAN_AUTO | CHAN_NOPAUSE, 1.0, true, ATTN_NONE);
            }

            TNT1 A 7;
            TNT1 A 2;
            TNT1 A 0 A_StartSound("slomo/out", CHAN_AUTO | CHAN_NOPAUSE, 1.0, false, ATTN_NONE);
            TNT1 A 35;
            Stop;
    }
}

class ZDRPGTimeFreezerQuickSound : Actor
{
    States
    {
        Spawn:
            TNT1 A 0
            {
                A_StartSound("slomo/in", CHAN_AUTO | CHAN_NOPAUSE, 1.0, false, ATTN_NONE);
                A_StartSound("slomo/loop", CHAN_AUTO | CHAN_NOPAUSE, 1.0, true, ATTN_NONE);
            }
            
            TNT1 A 7;
            TNT1 A 180;
            TNT1 A 0 A_StartSound("slomo/out", CHAN_AUTO | CHAN_NOPAUSE, 1.0, false, ATTN_NONE);
            TNT1 A 35;
            Stop;
    }
}

class ZDRPGSpeed : PowerupGiver
{
    Default
    {
        //-INVBAR;
        +INVENTORY.AUTOACTIVATE;

        Powerup.Type "PowerDoubleFiringSpeed";
        Powerup.Duration 4;
    }
}

class ZDRPGShotSpawn : Actor
{
    Default
    {
        Mass 5;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_SpawnItemEx("ZDRPGDumbShotgun", Random(0, 80), 0, 0, 0, Random(-30, 30));
            TNT1 A 1 A_Jump(254, "Spawn");
            Stop;
    }
}

class ZDRPGDumbShotgun : Actor
{
    Default
    {
        Mass 10;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            TNT1 A 0 A_StartSound("weapons/shotgr");
            SHOT A 50 A_SetTics(Random(40, 70));
            TNT1 A 0 
            {
                A_StartSound("weapons/shotgf");
                A_SetAngle(Random(0, 256));
                bVISIBILITYPULSE = true;
                A_SetTranslucent(1.0, 1);
            }
            SHOT A 10 Bright A_CustomBulletAttack(30, 45, Random(5, 25), 1, "BulletPuff", 9999.0, CBAF_AIMFACING);
            SHOT A 105;
            TNT1 A 0 A_SetScale(4.0, 4.0);
            TNT1 A 0 A_SetTranslucent(1.0, 0);
            TNT1 A 0 A_StartSound("weapons/rocklx");
            MISL B 3 Bright A_Explode(3, 64, XF_NOTMISSILE, 256, 1);
            MISL C 3 Bright;
            MISL D 3 Bright;
            Stop;
    }
}

class ZDRPGDumbPistol : Actor
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            PIST A 0 A_ChangeVelocity(FRandom(-4.0, 4.0), FRandom(-4.0, 4.0), FRandom(0.0, 32.0));
            PIST A -1;
            Stop;
    }
}

class MapSpotTall : MapSpotGravity
{
    Default
    {
        Height 56;
        Radius 20;
    }
}

class ZDRPG_use_gch_token : Inventory  
{ 
    Default
    {
        Inventory.MaxAmount 1;
    }
}

class ZDRPGEmpty {}