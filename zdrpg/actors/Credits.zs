class ZDRPGCredits: Inventory
{
    Default {
        Inventory.Amount 1;
        Inventory.MaxAmount 1000000000;
    }
}

/*
// Empty Credits
actor DRPGCreditsEmpty
{
    BounceType Classic
    BounceFactor 0.5
    WallBounceFactor 0.5
    
    +NOBLOCKMAP
    +NOTELEPORT
    +NOTRIGGER
    +MOVEWITHSECTOR
    
    scale 0.5
        
    States
    {
    Spawn:
        CBRD A 1
    FadeOut:
        CBRD A 1 A_FadeOut(0.0025, true)
        Loop
    }
}

// 1 Credit - Green
actor DRPGCredits1 : CustomInventory 25020
{
    scale 0.5
    
    Inventory.PickupMessage "You got a \cdCredit\c-."
    Inventory.PickupSound "credits/pickup"
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        CRED A -1 Bright
        Stop
    Pickup:
        TNT1 A 0 A_GiveInventory("DRPGCredits", 1)
        TNT1 A 0 A_SpawnItemEx("DRPGCreditsEmpty", 0, 0, 48, Random(-4, -1), 0, 0)
        Stop
    }
}

// 5 Credits - Blue
actor DRPGCredits5 : DRPGCredits1 25021
{
    Inventory.PickupMessage "You got \cn5 Credits\c-."
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        CRED B -1 Bright
        Stop
    Pickup:
        TNT1 A 0 A_GiveInventory("DRPGCredits", 5)
        TNT1 A 0 A_SpawnItemEx("DRPGCreditsEmpty", 0, 0, 48)
        Stop
    }
}

// 10 Credits - Yellow
actor DRPGCredits10 : DRPGCredits1 25022
{
    Inventory.PickupMessage "You got \cf10 Credits\c-."
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        CRED C -1 Bright
        Stop
    Pickup:
        TNT1 A 0 A_GiveInventory("DRPGCredits", 10)
        TNT1 A 0 A_SpawnItemEx("DRPGCreditsEmpty", 0, 0, 48)
        Stop
    }
}

// 20 Credits - Red
actor DRPGCredits20 : DRPGCredits1 25023
{
    Inventory.PickupMessage "You got \ca20 Credits\c-."
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        CRED D -1 Bright
        Stop
    Pickup:
        TNT1 A 0 A_GiveInventory("DRPGCredits", 20)
        TNT1 A 0 A_SpawnItemEx("DRPGCreditsEmpty", 0, 0, 48)
        Stop
    }
}

// 50 Credits - Purple
actor DRPGCredits50 : DRPGCredits1 25024
{
    Inventory.PickupMessage "You got \ct50 Credits\c-."
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        CRED E -1 Bright
        Stop
    Pickup:
        TNT1 A 0 A_GiveInventory("DRPGCredits", 50)
        TNT1 A 0 A_SpawnItemEx("DRPGCreditsEmpty", 0, 0, 48)
        Stop
    }
}

// 100 Credits - Orange
actor DRPGCredits100 : DRPGCredits1 25025
{
    Inventory.PickupMessage "You got \ci100 Credits\c-."
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        CRED F -1 Bright
        Stop
    Pickup:
        TNT1 A 0 A_GiveInventory("DRPGCredits", 100)
        TNT1 A 0 A_SpawnItemEx("DRPGCreditsEmpty", 0, 0, 48)
        Stop
    }
}

// 250 Credits - Silver
actor DRPGCredits250 : DRPGCredits1 25027
{
    Inventory.PickupMessage "You got \cw250 Credits\c-."
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        CRED G -1 Bright
        Stop
    Pickup:
        TNT1 A 0 A_GiveInventory("DRPGCredits", 250)
        TNT1 A 0 A_SpawnItemEx("DRPGCreditsEmpty", 0, 0, 48)
        Stop
    }
}

// 500 Credits - Gold
actor DRPGCredits500 : DRPGCredits1 25028
{
    Inventory.PickupMessage "You got \cf500 Credits\c-."
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        CRED H -1 Bright
        Stop
    Pickup:
        TNT1 A 0 A_GiveInventory("DRPGCredits", 500)
        TNT1 A 0 A_SpawnItemEx("DRPGCreditsEmpty", 0, 0, 48)
        Stop
    }
}

// 1000 Credits - Rainbow
actor DRPGCredits1000 : DRPGCredits1 25026
{
    Inventory.PickupMessage "You got 1000 \cjC\cdr\cne\cfd\cai\ctt\cis\c-! Holy Crap!"
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        CRED ABCDEFGHCF 3 Bright
        Goto Spawn+1
    Pickup:
        TNT1 A 0 A_GiveInventory("DRPGCredits", 1000)
        TNT1 A 0 A_SpawnItemEx("DRPGCreditsEmpty", 0, 0, 48)
        Stop
    }
}

// UAC Card
actor DRPGUACCard : Inventory
{
    scale 0.33
    
    Inventory.Amount 1
    Inventory.MaxAmount 4
    Inventory.PickupMessage "You got a UAC Card!"
    Inventory.PickupSound "credits/pickup"
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        TNT1 A 0
        TNT1 A 0 A_JumpIf(CallACS("GetShopCard") == 0, "CardBronze")
        TNT1 A 0 A_JumpIf(CallACS("GetShopCard") == 1, "CardSilver")
        TNT1 A 0 A_JumpIf(CallACS("GetShopCard") == 2, "CardGold")
        TNT1 A 0 A_JumpIf(CallACS("GetShopCard") >= 3, "CardPlatinum")
        Stop
    CardBronze:
        UCRD A -1 Bright
        Stop
    CardSilver:
        UCRD B -1 Bright
        Stop
    CardGold:
        UCRD C -1 Bright
        Stop
    CardPlatinum:
        UCRD D -1 Bright
        Stop
    }
}

actor DRPGDiamondUACCard : DRPGUACCard
{
    States
    {
    Spawn:
        TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0)
        UCRD E -1 Bright
        Stop
    }
}
*/