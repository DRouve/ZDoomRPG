/* HEALING ITEMS

    Health Bonus        - +1 HP
    Stimpack            - +10 Medkit
    Medikit             - +15 Medkit
    Large Medikit       - +25 Medkit
    Extra-Large Medikit - +50 Medkit
    Med-Pack            - +75 Medkit
    Surgery Kit         - +100 Medkit
    
    Medkit Refill       - Full Medkit (Only available in the shop)
    
    Soulspheres         - +100-300 HP
    
    1-Up                - Increases Lives by 1
    3-Up                - Increases Lives by 3
    5-Up                - Increases Lives by 5

*/

class ZDRPGMedkit: Inventory
{
    int GiveAmount;
    property GiveAmount : GiveAmount;
    Default {
        Inventory.Amount 0;
    }

    override bool TryPickup (in out Actor toucher) 
	{
        let Inventory = ZDRPGPlayerInventory(toucher.FindInventory("ZDRPGPlayerInventory"));
        if(Inventory.Medkit < Inventory.MaxMedkit) {
            if(Inventory.Medkit + self.GiveAmount >= Inventory.MaxMedkit) 
            {
                Inventory.Medkit = Inventory.MaxMedkit;
            }
            else 
            {
                Inventory.Medkit += self.GiveAmount;
            }
            self.Destroy();
			return true;
        }
        return false;
	}
}

class ZDRPGStimpack: ZDRPGMedkit
{
    Default {
        ZDRPGMedkit.GiveAmount 10;
    }

    States
    {
        Spawn:
            STIM A -1;
            Stop;
    }
}

class ZDRPGMedikit: ZDRPGMedkit
{
    Default {
        ZDRPGMedkit.GiveAmount 15;
    }

    States
    {
        Spawn:
            MEDI A -1;
            Stop;
    }
}

class ZDRPGLargeMedikit: ZDRPGMedkit
{
    Default {
        ZDRPGMedkit.GiveAmount 25;
    }

    States
    {
        Spawn:
            MEDL A -1;
            Stop;
    }
}

class ZDRPGXLMedikit: ZDRPGMedkit
{
    Default {
        ZDRPGMedkit.GiveAmount 50;
    }

    States
    {
        Spawn:
            MEDX A -1;
            Stop;
    }
}

class ZDRPGMedPack: ZDRPGMedkit
{
    Default {
        ZDRPGMedkit.GiveAmount 75;
    }

    States
    {
        Spawn:
            MEDP A -1;
            Stop;
    }
}

class ZDRPGSurgeryKit: ZDRPGMedkit
{
    Default {
        ZDRPGMedkit.GiveAmount 100;
    }

    States
    {
        Spawn:
            MEDS A -1;
            Stop;
    }
}

class ZDRPGMedkitRefill: ZDRPGMedkit
{
    Default {
        ZDRPGMedkit.GiveAmount 100000;
    }

    States
    {
        Spawn:
            MEDK A -1;
            Stop;
    }
}
/*
// Basic Health
actor DRPGBasicHealth : Health
{
    Inventory.Amount 1
    Inventory.MaxAmount 0x7FFFFFFF
}

// Health Bonus
actor DRPGHealthBonus : CustomInventory
{
    +INVENTORY.ALWAYSPICKUP
    
    Inventory.PickupMessage "$GOTHTHBONUS"
    Inventory.PickupSound "items/vial"
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        BON1 ABCDCB 6 Bright
        Goto Spawn+1
    Pickup:
        TNT1 A 0 ACS_NamedExecuteWithResult("AddHealthDirect", 5, 200)
        Stop
    }
}

// Stimpack
ACTOR DRPGStimpack : CustomInventory
{
    Inventory.PickupMessage "You got a Stimpack!"
    Inventory.PickupSound "items/health"
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        STIM A -1
        Stop
    Pickup:
        TNT1 A 0 A_JumpIf(CallACS("CheckMedkitMax"), "PickupFail")
        TNT1 A 0 ACS_NamedExecuteAlways("AddMedkit", 0, 10)
        Stop
    PickupFail:
        TNT1 A 0
        Fail
    }
}

// Medikit
ACTOR DRPGMedikit : CustomInventory
{
    Inventory.PickupMessage "You got a medium Medikit!"
    Inventory.PickupSound "items/health"

    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        MEDI A -1
        Stop
    Pickup:
        TNT1 A 0 A_JumpIf(CallACS("CheckMedkitMax"), "PickupFail")
        TNT1 A 0 ACS_NamedExecuteAlways("AddMedkit", 0, 15)
        Stop
    PickupFail:
        TNT1 A 0
        Fail
    }
}

// Large Medikit
actor DRPGLargeMedikit : CustomInventory 25030
{
    Inventory.PickupMessage "You got a large Medikit!"
    Inventory.PickupSound "items/health"
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        MEDL A -1
        Stop
    Pickup:
        TNT1 A 0 A_JumpIf(CallACS("CheckMedkitMax"), "PickupFail")
        TNT1 A 0 ACS_NamedExecuteAlways("AddMedkit", 0, 25)
        Stop
    PickupFail:
        TNT1 A 0
        Fail
    }
}

// Extra-Large Medikit
actor DRPGXLMedikit : CustomInventory 25031
{
    Inventory.PickupMessage "You got an Extra-large Medikit!"
    Inventory.PickupSound "items/health"
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        MEDX A -1
        Stop
    Pickup:
        TNT1 A 0 A_JumpIf(CallACS("CheckMedkitMax"), "PickupFail")
        TNT1 A 0 ACS_NamedExecuteAlways("AddMedkit", 0, 50)
        Stop
    PickupFail:
        TNT1 A 0
        Fail
    }
}

// Med Pack
actor DRPGMedPack : CustomInventory 25032
{
    Inventory.PickupMessage "You got a Med Pack!"
    Inventory.PickupSound "items/health"
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        MEDP A -1
        Stop
    Pickup:
        TNT1 A 0 A_JumpIf(CallACS("CheckMedkitMax"), "PickupFail")
        TNT1 A 0 ACS_NamedExecuteAlways("AddMedkit", 0, 75)
        Stop
    PickupFail:
        TNT1 A 0
        Fail
    }
}

// Surgery Kit
actor DRPGSurgeryKit : CustomInventory 25033
{
    Inventory.PickupMessage "You got a Surgery Kit!"
    Inventory.PickupSound "items/health"
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        MEDS AB 8
        Goto Spawn+1
    Pickup:
        TNT1 A 0 A_JumpIf(CallACS("CheckMedkitMax"), "PickupFail")
        TNT1 A 0 ACS_NamedExecuteAlways("AddMedkit", 0, 100)
        Stop
    PickupFail:
        TNT1 A 0
        Fail
    }
}

// Medkit Refill
ACTOR DRPGMedkitRefill : CustomInventory
{
    Inventory.PickupMessage "You got a Medkit refill."
    Inventory.PickupSound "items/health"

    States
    {
    Spawn:
        MEDK A -1
        Stop
    Pickup:
        TNT1 A 0 ACS_NamedExecuteAlways("AddMedkit", 0, 1000000)
        Stop
    }
}

// Soulspheres
ACTOR DRPGSoulsphere : CustomInventory
{
    +FLOATBOB
    -COUNTITEM
    
    +INVENTORY.AUTOACTIVATE
    +INVENTORY.ALWAYSPICKUP
    +INVENTORY.FANCYPICKUPSOUND
    +INVENTORY.BIGPOWERUP
    
    Inventory.PickupMessage "You got a Soulsphere!"
    Inventory.PickupSound "powerups/soulsphere"
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        SOUL ABCDCB 6 Bright
        Goto Spawn+1
    Pickup:
        TNT1 A 0 ACS_NamedExecuteWithResult("AddHealthDirect", 100, 200)
        TNT1 A 0 ACS_NamedExecuteWithResult("ClearStatusEffects")
        Stop
    }
}

ACTOR DRPGSoulsphere2 : DRPGSoulsphere 25034
{
    Translation "192 : 207 = 112 : 127", "240 : 247 = 127 : 127"
    
    States
    {
    Pickup:
        TNT1 A 0 ACS_NamedExecuteWithResult("AddHealthDirect", 200, 200)
        TNT1 A 0 ACS_NamedExecuteWithResult("ClearStatusEffects")
        Stop
    }
}

ACTOR DRPGSoulsphere3 : DRPGSoulsphere 25035
{
    Translation "192 : 207 = 172 : 187", "240 : 247 = 191 : 191"
    
    States
    {
    Pickup:
        TNT1 A 0 ACS_NamedExecuteWithResult("AddHealth", 300, 200)
        TNT1 A 0 ACS_NamedExecuteWithResult("ClearStatusEffects")
        Stop
    }
}

// 1-Ups
ACTOR DRPGLife : Inventory
{
    -INVBAR
    
    Inventory.MaxAmount 5
    Inventory.InterHubAmount 5
    Inventory.PickupMessage "You got a Life!"
    Inventory.PickupSound "health/1up"
}

ACTOR DRPG1Up : CustomInventory 25036
{
    -INVBAR
    +FLOATBOB
    +INVENTORY.FANCYPICKUPSOUND
    
    Inventory.PickupMessage "You got a \cd1-Up!"
    Inventory.PickupSound "health/1up"
    
    Scale 0.5
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        P1UP ABCD 4 Bright
        TNT1 A 0 A_Jump(232, 2)
        TNT1 A 0 A_PlaySound("hums/extralife", CHAN_6, 4.0, false, 0.5)
        TNT1 A 0
        Goto Spawn+1
    Pickup:
        TNT1 A 0 A_GiveInventory("DRPGLife", 1)
        Stop
    }
}

ACTOR DRPG3Up : DRPG1Up
{
    Inventory.PickupMessage "You got a \ch3-Up!"
    Inventory.PickupSound "health/3up"
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        P3UP ABCD 4 Bright
        TNT1 A 0 A_Jump(232, 2)
        TNT1 A 0 A_PlaySound("hums/extralife", CHAN_6, 4.0, false, 0.5)
        TNT1 A 0
        Goto Spawn+1
    Pickup:
        TNT1 A 0 A_GiveInventory("DRPGLife", 3)
        Stop
    }
}

ACTOR DRPG5Up : DRPG1Up
{
    Inventory.PickupMessage "You got a \cg5-Up!"
    Inventory.PickupSound "health/5up"
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        P5UP ABCD 4 Bright
        TNT1 A 0 A_Jump(232, 2)
        TNT1 A 0 A_PlaySound("hums/extralife", CHAN_6, 4.0, false, 0.5)
        TNT1 A 0
        Goto Spawn+1
    Pickup:
        TNT1 A 0 A_GiveInventory("DRPGLife", 5)
        Stop
    }
}

// EP Capsule
actor DRPGEPCapsule : CustomInventory 25037
{
    inventory.PickupMessage "Got an EP Capsule!"
    Inventory.PickupSound "health/epcapsule"
    
    Scale 0.5
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
    SpawnLoop:
        EPUP ABCDEFGHIHGFEDCB 3 Bright
        Loop
    Pickup:
        TNT1 A 0 A_JumpIf(CallACS("GetEP") >= CallACS("GetEPMax"), "SpawnLoop")
        TNT1 A 0 ACS_NamedExecuteAlways("AddEP", 0, CallACS("GetEPMax") / 10)
        Stop
    }
}

// Little EP Capsule
actor DRPGLittleEPCapsule : DRPGEPCapsule 25039
{
    Scale 0.40
    
    States
    {
    Pickup:
        TNT1 A 0 A_JumpIf(CallACS("GetEP") >= CallACS("GetEPMax"), "SpawnLoop")
        TNT1 A 0 ACS_NamedExecuteAlways("AddEP", 0, CallACS("GetEPMax") / 15)
        Stop
    }
}

// Big EP Capsule
actor DRPGBigEPCapsule : DRPGEPCapsule 25038
{
    Scale 0.75
    
    States
    {
    Pickup:
        TNT1 A 0 A_JumpIf(CallACS("GetEP") >= CallACS("GetEPMax"), "SpawnLoop")
        TNT1 A 0 ACS_NamedExecuteAlways("AddEP", 0, CallACS("GetEPMax") / 4)
        Stop
    }
}
*/