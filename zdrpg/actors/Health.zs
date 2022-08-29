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

// Health Bonus
class ZDRPGHealthBonus : Inventory
{
    Default
    {
        +INVENTORY.ALWAYSPICKUP;
        Inventory.Amount 5;
        Inventory.PickupMessage "$GOTHTHBONUS";
        Inventory.PickupSound "items/vial";
    }
    
    States
    {
        Spawn:
            BON1 ABCDCB 6 Bright;
            Loop;
    }

    override bool TryPickup (in out Actor toucher) 
	{
        let Stats = ZDRPGStats.GetStats(toucher);
        let overhealMax = Stats.MaxHealth + 100;
        if(toucher.Health < overhealMax)
        {
            if(toucher.Health+self.Amount >= overhealMax)
                toucher.A_SetHealth(overhealMax);
            else
                toucher.GiveBody(self.Amount, overhealMax);
        }
        return false;
	}
}

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

// Soulspheres
class ZDRPGSoulsphere : Inventory
{
    Default
    {
        +FLOATBOB;
        -COUNTITEM;
        
        +INVENTORY.AUTOACTIVATE;
        +INVENTORY.ALWAYSPICKUP;
        +INVENTORY.FANCYPICKUPSOUND;
        +INVENTORY.BIGPOWERUP;
        
        Inventory.PickupMessage "You got a Soulsphere!";
        Inventory.PickupSound "powerups/soulsphere";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SOUL ABCDCB 6 Bright;
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 
            {
                ACS_NamedExecuteWithResult("AddHealthDirect", 100, 200);
                ACS_NamedExecuteWithResult("ClearStatusEffects");
            }
            Stop;
    }
}

class ZDRPGSoulsphere2 : ZDRPGSoulsphere
{
    Default
    {
        Translation "192 : 207 = 112 : 127", "240 : 247 = 127 : 127";
    }
    
    
    States
    {
        Pickup:
            TNT1 A 0 
            {
                ACS_NamedExecuteWithResult("AddHealthDirect", 200, 200);
                ACS_NamedExecuteWithResult("ClearStatusEffects");
            }
            Stop;
    }
}

class ZDRPGSoulsphere3 : ZDRPGSoulsphere
{
    Default
    {
        Translation "192 : 207 = 172 : 187", "240 : 247 = 191 : 191";
    }
    
    States
    {
        Pickup:
            TNT1 A 0 
            {
                ACS_NamedExecuteWithResult("AddHealth", 300, 200);
                ACS_NamedExecuteWithResult("ClearStatusEffects");
            }
            Stop;
    }
}

// 1-Ups
class ZDRPGLife : Inventory
{
    Default
    {
        //-INVBAR;
    
        Inventory.MaxAmount 5;
        Inventory.InterHubAmount 5;
        Inventory.PickupMessage "You got a Life!";
        Inventory.PickupSound "health/1up";
    }
    
}

class ZDRPG1Up : Inventory
{
    Default
    {
        //-INVBAR;
        +FLOATBOB;
        +INVENTORY.FANCYPICKUPSOUND;
        
        Inventory.PickupMessage "You got a \cd1-Up!";
        Inventory.PickupSound "health/1up";
        
        Scale 0.5;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            P1UP ABCD 4 Bright;
            TNT1 A 0 
            {
                A_Jump(232, 1);
                A_StartSound("hums/extralife", CHAN_6, 4.0, false, 0.5);
            }
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 A_GiveInventory("ZDRPGLife", 1);
            Stop;
    }
}

class ZDRPG3Up : ZDRPG1Up
{
    Default
    {
        Inventory.PickupMessage "You got a \ch3-Up!";
        Inventory.PickupSound "health/3up";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            P3UP ABCD 4 Bright;
            TNT1 A 0 
            {
                A_Jump(232, 1);
                A_PlaySound("hums/extralife", CHAN_6, 4.0, false, 0.5);
            }
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 A_GiveInventory("ZDRPGLife", 3);
            Stop;
    }
}

class ZDRPG5Up : ZDRPG1Up
{
    Default
    {
        Inventory.PickupMessage "You got a \cg5-Up!";
        Inventory.PickupSound "health/5up";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            P5UP ABCD 4 Bright;
            TNT1 A 0 
            {
                A_Jump(232, 1);
                A_StartSound("hums/extralife", CHAN_6, 4.0, false, 0.5);
            }
            Goto Spawn+1;
        Pickup:
            TNT1 A 0 A_GiveInventory("ZDRPGLife", 5);
            Stop;
    }
}

// EP Capsule
class ZDRPGEPCapsule : Inventory
{
    Default
    {
        Inventory.PickupSound "health/epcapsule";
        inventory.PickupMessage "Got an EP Capsule!";
        Scale 0.5;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
        SpawnLoop:
            EPUP ABCDEFGHIHGFEDCB 3 Bright;
            Loop;
        Pickup:
            TNT1 A 0 
            {
                A_JumpIf(CallACS("GetEP") >= CallACS("GetEPMax"), "SpawnLoop");
                ACS_NamedExecuteAlways("AddEP", 0, CallACS("GetEPMax") / 10);
            }
            Stop;
    }
}

// Little EP Capsule
class ZDRPGLittleEPCapsule : ZDRPGEPCapsule
{
    Default
    {
        Scale 0.40;
    }
    
    States
    {
        Pickup:
            TNT1 A 0 
            {
                A_JumpIf(CallACS("GetEP") >= CallACS("GetEPMax"), "SpawnLoop");
                ACS_NamedExecuteAlways("AddEP", 0, CallACS("GetEPMax") / 15);
            }
            Stop;
    }
}

// Big EP Capsule
class ZDRPGBigEPCapsule : ZDRPGEPCapsule
{
    Default
    {
        Scale 0.75;
    }
    
    States
    {
        Pickup:
            TNT1 A 0 
            {
                A_JumpIf(CallACS("GetEP") >= CallACS("GetEPMax"), "SpawnLoop");
                ACS_NamedExecuteAlways("AddEP", 0, CallACS("GetEPMax") / 4);
            }
            Stop;
    }
}