class ZDRPGCredits: Inventory
{
    Default {
        scale 0.5;
        Inventory.PickupSound "credits/pickup";
        
        +INVENTORY.ALWAYSPICKUP;
        Inventory.Amount 1;
        Inventory.MaxAmount 1000000000;
    }

    override bool TryPickup (in out Actor toucher) 
	{
        if(toucher.player)
        {
            let playerInventory = ZDRPGPlayerInventory(toucher.FindInventory("ZDRPGPlayerInventory"));
            playerInventory.Credits += self.Amount;
            return false;
        }
        Super.TryPickup(toucher);
        return true;      
	}
}


// Empty Credits
class ZDRPGCreditsEmpty : Actor
{
    Default
    {
        BounceType "Classic";
        BounceFactor 0.5;
        WallBounceFactor 0.5;
        
        +NOBLOCKMAP;
        +NOTELEPORT;
        +NOTRIGGER;
        +MOVEWITHSECTOR;
        
        scale 0.5;
    }
    
        
    States
    {
        Spawn:
            CBRD A 1;
        FadeOut:
            CBRD A 1 A_FadeOut(0.0025, true);
            Loop;
    }
}

// 1 Credit - Green
class ZDRPGCredits1 : ZDRPGCredits
{
    Default
    {
        Inventory.PickupMessage "You got a \cdCredit\c-.";
        Inventory.Amount 1;
    }
    
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            CRED A -1 Bright;
            Stop;
    }
}

// 5 Credits - Blue
class ZDRPGCredits5 : ZDRPGCredits
{
    Default
    {
        Inventory.PickupMessage "You got \cn5 Credits\c-.";
        Inventory.Amount 5;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            CRED B -1 Bright;
            Stop;
    }
}

// 10 Credits - Yellow
class ZDRPGCredits10 : ZDRPGCredits
{
    Default
    {
        Inventory.PickupMessage "You got \cf10 Credits\c-.";
        Inventory.Amount 10;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            CRED C -1 Bright;
            Stop;
    }
}

// 20 Credits - Red
class ZDRPGCredits20 : ZDRPGCredits
{
    Default
    {
        Inventory.PickupMessage "You got \ca20 Credits\c-.";
        Inventory.Amount 20;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            CRED D -1 Bright;
            Stop;
    }
}

// 50 Credits - Purple
class ZDRPGCredits50 : ZDRPGCredits
{
    Default
    {
        Inventory.PickupMessage "You got \ct50 Credits\c-.";
        Inventory.Amount 50;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            CRED E -1 Bright;
            Stop;
    }
}

// 100 Credits - Orange
class ZDRPGCredits100 : ZDRPGCredits
{
    Default
    {
        Inventory.PickupMessage "You got \ci100 Credits\c-.";
        Inventory.Amount 100;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            CRED F -1 Bright;
            Stop;
    }
}

// 250 Credits - Silver
class ZDRPGCredits250 : ZDRPGCredits
{
    Default
    {
        Inventory.PickupMessage "You got \cw250 Credits\c-.";
        Inventory.Amount 250;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            CRED G -1 Bright;
            Stop;
    }
}

// 500 Credits - Gold
class ZDRPGCredits500 : ZDRPGCredits
{
    Default
    {
        Inventory.PickupMessage "You got \cf500 Credits\c-.";
        Inventory.Amount 500;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            CRED H -1 Bright;
            Stop;
    }
}

// 1000 Credits - Rainbow
class ZDRPGCredits1000 : ZDRPGCredits
{
    Default
    {
        Inventory.PickupMessage "You got 1000 \cjC\cdr\cne\cfd\cai\ctt\cis\c-! Holy Crap!";
        Inventory.Amount 1000;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            CRED ABCDEFGHCF 3 Bright;
            Goto Spawn+1;
    }
}

// UAC Card
class ZDRPGUACCard : Inventory
{
    Default
    {
        scale 0.33;
    
        Inventory.Amount 1;
        Inventory.MaxAmount 4;
        Inventory.PickupMessage "You got a UAC Card!";
        Inventory.PickupSound "credits/pickup";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            TNT1 A 0
            {
                A_JumpIf(CallACS("GetShopCard") == 0, "CardBronze");
                A_JumpIf(CallACS("GetShopCard") == 1, "CardSilver");
                A_JumpIf(CallACS("GetShopCard") == 2, "CardGold");
                A_JumpIf(CallACS("GetShopCard") >= 3, "CardPlatinum");
            }
            Stop;
        CardBronze:
            UCRD A -1 Bright;
            Stop;
        CardSilver:
            UCRD B -1 Bright;
            Stop;
        CardGold:
            UCRD C -1 Bright;
            Stop;
        CardPlatinum:
            UCRD D -1 Bright;
            Stop;
    }
}

class ZDRPGDiamondUACCard : ZDRPGUACCard
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            UCRD E -1 Bright;
            Stop;
    }
}
