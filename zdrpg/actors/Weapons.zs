class DRPGChainsaw : Chainsaw Replaces Chainsaw
{
    int str;
    property Str : str;
    Default {
        Weapon.SlotNumber 1;
        DRPGChainsaw.Str 1;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 {
                RPG.ItemInit();
            }
            CSAW A -1;
            Stop;
    }
}

class DRPGPistol : Pistol Replaces Pistol
{
    Default {
        Weapon.SlotNumber 2;
    }

    States
    {
        Spawn:
            TNT1 A 0; //NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
            PIST A -1;
            Stop;
    }
}

class DRPGShotgun : Shotgun Replaces Shotgun
{
    Default {
        Weapon.SlotNumber 3;
    }

    States
    {
        Spawn:
            TNT1 A 0; //NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
            SHOT A -1;
            Stop;
    }
}

class DRPGSuperShotgun : SuperShotgun Replaces SuperShotgun
{
    Default {
        Weapon.SlotNumber 3;
    }

    States
    {
        Spawn:
            TNT1 A 0; //NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
            SGN2 A -1;
            Stop;
    }
}

class DRPGChaingun : Chaingun Replaces Chaingun
{
    Default {
        Weapon.SlotNumber 4;
    }

    States
    {
        Spawn:
            TNT1 A 0; //NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
            MGUN A -1;
            Stop;
    }
}

class DRPGRocketLauncher : RocketLauncher Replaces RocketLauncher
{
    Default {
        Weapon.SlotNumber 5;
    }

    States
    {
        Spawn:
            TNT1 A 0; //NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
            LAUN A -1;
            Stop;
    }
}

class DRPGPlasmaRifle : PlasmaRifle Replaces PlasmaRIfle
{
    Default {
        Weapon.SlotNumber 6;
    }

    States
    {
        Spawn:
            TNT1 A 0; //NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
            PLAS A -1;
            Stop;
    }
}

class DRPGBFG9000 : BFG9000 Replaces BFG9000
{
    Default {
        Weapon.SlotNumber 7;
    }

    States
    {
        Spawn:
            TNT1 A 0; //NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
            BFUG A -1;
            Stop;
    }
}