class ZDRPGShield : Inventory
{
    Default
    {
        Inventory.Amount 1;
        Inventory.MaxAmount 1;
    }
}

class ZDRPGShieldCapacity : inventory
{ 
    Default 
    {
        Inventory.MaxAmount 100;
    }
}

class ZDRPGShieldCharge : inventory
{ 
    Default 
    {
        Inventory.MaxAmount 1000000;
    }
}

class ZDRPGShieldChargeMax : inventory
{ 
    Default 
    {
        Inventory.MaxAmount 1000000;
    }
}

// Shield Booster
class ZDRPGShieldBooster : Inventory
{
    Default
    {
        Scale 0.5;
    
        Inventory.MaxAmount 0;
        Inventory.PickupMessage "Got a Shield Booster!";
        Inventory.PickupSound "shield/booster";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SBST A 0 Bright A_SpawnItemEx("ZDRPGShieldBoosterBeam", 0, 0, 0, 0, 0, 0, 0, SXF_SETMASTER);
            SBST A -1 Bright;
            Stop;
        Pickup:
            SBST A 0 ACS_NamedExecuteAlways("AddShield", 0, CallACS("GetShieldMax", 0) / 10);
            Stop;
    }
}

class ZDRPGShieldBoosterBeam : Actor
{
    int user_step;

    Default
    {
        Scale 0.25;
        Alpha 0.75;
        RenderStyle "Add";
        
        +FORCEYBILLBOARD;
        
        Translation "0 : 255 = %[0.0, 0.0, 0.0] : [0.0, 0.25, 0.75]";
    }
    
    States
    {
        Spawn:
        FadeLoop:
            BEAM A 1 Bright;
            TNT1 A 0 {
                A_Warp(AAPTR_MASTER, 0, 0, 0, 0, WARPF_NOCHECKPOSITION | WARPF_TOFLOOR | WARPF_COPYINTERPOLATION);
                A_SetTranslucent(0.5 + (0.25 * Sin(user_step)), 1);
                user_step += 10.285714;
                A_Warp(AAPTR_MASTER, 0, 0, 0, 0, WARPF_NOCHECKPOSITION | WARPF_TESTONLY, "FadeLoop");
            } 
        Death:
            TNT1 A 1;
            Stop;
    }
}

// Basic Shield Package
class ZDRPGBasicShieldPackage : Inventory
{
    Default
    {
        +INVENTORY.AUTOACTIVATE;
    
        Inventory.MaxAmount 0;
        Inventory.PickupMessage "You got a Basic Shield Package.";
        Inventory.PickupSound "shield/pickup";
        
        Scale 0.5;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHPA A -1 Bright;
            Stop;
        Use:
            TNT1 A 0 A_GiveInventory("ZDRPGShieldBody1", 1);
            TNT1 A 0 A_GiveInventory("ZDRPGShieldBattery1", 1);
            TNT1 A 0 A_GiveInventory("ZDRPGShieldCapacitor1", 1);
            Stop;
    }
}

class ZDRPGShieldPart : Inventory
{
    Default
    {
        Scale 0.5;
    
        Inventory.MaxAmount 100;
        Inventory.InterHubAmount 100;
        Inventory.PickupMessage "Got a Shield Part!";
        Inventory.PickupSound "shield/pickup";
    }
    

    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHCA A -1 Bright;
            Stop;
        Pickup:
            SHCA A 0;
            Stop;
    }
}

// BODIES
// --------------------------------------------------

class ZDRPGShieldBody1 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO A -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody2 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO B -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody3 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO C -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody4 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO D -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody5 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO E -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody6 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO F -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody7 : ZDRPGShieldPart
{
    Default
    {
        Inventory.PickupSound "shield/bisonpickup";
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO G -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody8 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO H -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody9 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO I -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody10 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO J -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody11 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO K -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody12 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO L -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody13 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO M -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody14 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO N -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody15 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO O -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody16 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO P -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody17 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO Q -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody18 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO R -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody19 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO S -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody20 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO T -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody21 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO U -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody22 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBO V -1 Bright;
            Stop;
    }
}

// BATTERIES
// --------------------------------------------------

class ZDRPGShieldBattery1 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBA A -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery2 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBA B -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery3 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBA C -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery4 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBA D -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery5 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBA E -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery6 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBA F -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery7 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBA G -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery8 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBA H -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery9 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBA I -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery10 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBA J -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery11 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBA K -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery12 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBA L -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery13 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHBA M -1 Bright;
            Stop;
    }
}

// CAPACITORS
// --------------------------------------------------

class ZDRPGShieldCapacitor1 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHCA A -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor2 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHCA B -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor3 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHCA C -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor4 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHCA D -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor5 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHCA E -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor6 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHCA F -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor7 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHCA G -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor8 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHCA H -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor9 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHCA I -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor10 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHCA J -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor11 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHCA K -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor12 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHCA L -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor13 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHCA M -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor14 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHCA N -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor15 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHCA O -1 Bright;
            Stop;
    }
}

// ACCESSORIES
// --------------------------------------------------

class ZDRPGShieldAccessory1 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC A -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory2 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC B -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory3 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC C -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory4 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC D -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory5 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC E -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory6 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC F -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory7 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC G -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory8 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC H -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory9 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC I -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory10 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC J -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory11 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC K -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory12 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC L -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory13 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC M -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory14 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC N -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory15 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC O -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory16 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC P -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory17 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC Q -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory18 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC R -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory19 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC S -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory20 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC T -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory21 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC U -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory22 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC V -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory23 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC W -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory24 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC X -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory25 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC Y -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory26 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHAC Z -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory27 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 A -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory28 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 B -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory29 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 C -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory30 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 D -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory31 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 E -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory32 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 F -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory33 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 G -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory34 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 H -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory35 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 I -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory36 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 J -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory37 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 K -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory38 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 L -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory39 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 M -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory40 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 N -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory41 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 O -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory42 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 P -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory43 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 Q -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory44 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 R -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory45 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 S -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory46 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 T -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory47 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 U -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory48 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 V -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory49 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 W -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory50 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 X -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory51 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 Y -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory52 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 Z -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory53 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 "[" -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory54 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 \ -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory55 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA2 "]" -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory56 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA3 A -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory57 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA3 B -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory58 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA3 C -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory59 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA3 D -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory60 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA3 E -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory61 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA3 F -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory62 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA3 G -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory63 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA3 H -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory64 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA3 I -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory65 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA3 J -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory66 : ZDRPGShieldPart
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay ACS_NamedExecuteAlways("ItemInit", 0);
            SHA3 K -1 Bright;
            Stop; 
    }
}

// ACCESSORY STUFF
// --------------------------------------------------

// Powerups
class PowerShieldLightAmp : PowerLightAmp
{
    Default
    {
        Powerup.Duration -0x7FFFFFFF;
    }
}

class PowerShieldInvisibility : PowerInvisibility
{
    Default
    {
        Powerup.Duration -0x7FFFFFFF;
    }
}

class PowerShieldGhost : PowerInvisibility
{
    Default
    {
        +GHOST;
        Powerup.Duration -5;
        Powerup.Mode "Translucent";
        Powerup.Strength 0.5;
    }
}

/*class PowerShieldTimeFreezer : PowerTimeFreezer
{
    Default
    {
        Powerup.Duration -0x7FFFFFFF;
    }
}

class ZDRPGShieldTimePause : PowerupGiver
{
    Default
    {
        Inventory.MaxAmount 0;
        +INVENTORY.AUTOACTIVATE;
        Powerup.Type "ShieldTimeFreezer";
        Powerup.Duration -0x7FFFFFFF;
    }
}

class PowerShieldInfiniteAmmo : PowerupGiver
{
    Default
    {
        +Inventory.AutoActivate;
        Powerup.Type PowerInfiniteAmmo;
        Powerup.Duration 4;
    }
}
*/
// Resistances
class ZDRPGShieldNewUProtection : PowerProtection
{
    Default
    {
        DamageFactor 0.1;
        Powerup.Duration -6;
    }
}

class ZDRPGShieldNakedResist : PowerProtection
{
    Default
    {
        DamageFactor 0.75;
        Powerup.Duration 2;
    }
}

class ZDRPGShieldRadialExplosionResist : PowerProtection
{
    Default
    {
        DamageFactor "Fire", 0;
        Powerup.Duration 5;
    }
}

class ZDRPGShieldAdaptiveNormalResist : PowerProtection
{
    Default
    {
        DamageFactor 0.5;
        Powerup.Duration -15;
    }
}

class ZDRPGShieldAdaptiveToxicResist : PowerProtection
{
    Default
    {
        DamageFactor "Toxicity", 0.5;
        Powerup.Duration -15;
    }
}

class ZDRPGShieldAdaptiveMeleeResist : PowerProtection
{
    Default
    {
        DamageFactor "Melee", 0.5;
        Powerup.Duration -15;
    }
}

class ZDRPGShieldAdaptiveFireResist : PowerProtection
{
    Default
    {
        DamageFactor "Fire", 0.5;
        Powerup.Duration -15;
    }
}

class ZDRPGShieldAdaptivePlasmaResist : PowerProtection
{
    Default
    {
        DamageFactor "Plasma", 0.5;
        Powerup.Duration -15;
    }
}

class ZDRPGShieldAdaptiveLightningResist : PowerProtection
{
    Default
    {
        DamageFactor "Electric", 0.5;
        Powerup.Duration -15;
    }
}

// RF-CT flag handlers
class ZDRPGShieldReflection : CustomInventory
{
    Default
    {
        Inventory.MaxAmount 0;
        +INVENTORY.AUTOACTIVATE;
    }
    
    States
    {
        Pickup:
            TNT1 A 0 
            {
                bREFLECTIVE = true;
            }
            Stop;
    }
}

class ZDRPGShieldReflectionOff : CustomInventory
{
    Default
    {
        Inventory.MaxAmount 0;
        +INVENTORY.AUTOACTIVATE;
    }
    
    States
    {
        Pickup:
            TNT1 A 0 
            {
                bREFLECTIVE = false;
            }
            Stop;
    }
}

// COUN-TR20
class ZDRPGShieldCounterBlast : CustomInventory
{
    Default
    {
        Inventory.MaxAmount 0;
        +INVENTORY.AUTOACTIVATE;
    }
    
    States
    {
        Pickup:
            TNT1 A 0 A_Blast(0, 255, 1024, 100, "BlastEffect", "skills/blast");
            Stop;
    }
}

// Radial Explosion for KOOL-AYD and FLAN-495
class ZDRPGShieldExplosion : Rocket
{
    Default
    {
        Radius 1;
        Height 1;
        
        +RANDOMIZE;
        +SYNCHRONIZED;
        -DEHEXPLOSION;
        -ROCKETTRAIL;
    
        Damage 100;
        DamageType "Fire";
        RenderStyle "Add";
        SeeSound "";
        DeathSound ""   ;
    }
    
    States
    {
        Spawn:
        Death:
            TNT1 A 0 NoDelay A_Jump(256, 1, 2, 3, 4);
            TNT1 AAAA 1;
            TNT1 A 0 
            {
                A_Warp(AAPTR_DEFAULT, Random(-8,8), Random(-8,8), 32+Random(-8,8), 0, WARPF_NOCHECKPOSITION);
                A_Explode(256, 128, 0, 1, 128);
                A_StartSound("shield/explosion", CHAN_WEAPON, 0.5);
            }
            MISL BCD 6 Bright;
            Stop;
    }
}

class ZDRPGShieldRadialExplosion : Actor
{
    Default
    {
        Radius 5;
        Height 5;
        
        DamageType "Fire";
        
        Projectile;
        +NOGRAVITY;
        +NOTELEPORT;
        +THRUACTORS;
        +NOEXPLODEFLOOR;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_BFGSpray("ZDRPGShieldExplosion", 45, 1, 360);
            Stop;
    }
}
/*
class ZDRPGShieldRadialExplosionMaker : Inventory
{
    Default
    {
        Inventory.MaxAmount 0;
        +INVENTORY.AUTOACTIVATE;
    }
    
    States
    {
        Pickup:
            TNT1 A 0 A_FireCustomMissile("ZDRPGShieldRadialExplosion", 0, 0);
            Stop;
    }
}*/

// VENG-R Buffs
class ZDRPGShieldAvengerDamage : PowerDamage
{
    Default
    {
        DamageFactor "Normal", 1.5;
        Powerup.Duration -30;
    }
}

class ZDRPGShieldAvengerDefense : PowerProtection
{
    Default
    {
        DamageFactor 0.5;
        Powerup.Duration -30;
    }
}

// TOJI-K0 Lightning & Effects
class ZDRPGShieldLightningParticle : Actor
{
    int user_parttime;

    Default
    {
        Radius 4;
        Height 2;
        +NoInteraction;
        RenderStyle "Add";
        Alpha 1.0;
        Scale 0.0125;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay
            {
                A_Jump(160, "Death");
                user_parttime = 10;
            }  
            // TNT1 A 0 A_ChangeVelocity(FRandom(-0.33, 0.33),FRandom(-0.33, 0.33),FRandom(-0.33, 0.33))
        DecayLoop:
            SLGT A 1 Bright;
            // TNT1 A 0 A_ChangeVelocity(0,0,-0.025)
            TNT1 A 0 
            {
                A_SetScale(0.0125 - (0.0125 * Cos(user_parttime * 90.0 / 10.0)));
                user_parttime--;
                A_JumpIf(user_parttime <= 0, "Death");
            }
            Loop;
        Death:
            TNT1 A 0;
            Stop;
    }
}

/*class ZDRPGShieldLightningAttack : Inventory
{
    Default
    {
        Inventory.MaxAmount 0;
        +INVENTORY.AUTOACTIVATE;
    }
    
    States
    {
        Pickup:
            TNT1 A 0 A_RailAttack (15, 0, 0, "None", "White", RGF_SILENT | RGF_EXPLICITANGLE, 50, "ZDRPGElectricalPuff", frandom(0,359), frandom(-10,10), random(256,512), 1, 1.0, 0, "ZDRPGShieldLightningParticle", frandom(-8,-16));
            Stop;
    }
}*/

// HAET-60
class ZDRPGShieldHateHateHateDefense : PowerProtection
{
    Default
    {
        DamageFactor "Melee", 0.01;
        Powerup.Duration -60;
    }
}

// IKU-N7
class ZDRPGShieldStaticParticle : ZDRPGShieldLightningParticle
{
    Default
    {
        Scale 0.05;
    }

    States
    {
        Spawn:
            TNT1 A 0 NoDelay 
            {
                user_parttime = 20;
            }
            // TNT1 A 0 A_ChangeVelocity(FRandom(-0.33, 0.33),FRandom(-0.33, 0.33),FRandom(-0.33, 0.33))
        DecayLoop:
            SLGT A 1 Bright;
            TNT1 A 0 
            {
                A_ChangeVelocity(0,0,-0.025);
                A_SetScale(0.05 - (0.05 * Cos(user_parttime * 90.0 / 20.0)));
                user_parttime--;
                A_JumpIf(user_parttime <= 0, "Death");
            }
            Loop;
    }
}

class ZDRPGStaticChargeShieldExplosion : Actor
{
    Default
    {
        Projectile;
        DamageType "Electric";
        Radius 8;
        Height 8;
        +FORCEPAIN;
        Speed 0;
        ReactionTime 6;
        SeeSound "shield/lightning";
    }
    
    States
    {
    Spawn:
        TNT1 A 3 A_Explode(3, 128, 0, true, 128);
        TNT1 A 0 
        {
            A_SpawnItemEx("ZDRPGShieldStaticParticle", Random(-64,64), Random(-64,64), Random(-64,64), 0, 0, 0, 0);
            A_SpawnItemEx("ZDRPGShieldStaticParticle", Random(-64,64), Random(-64,64), Random(-64,64), 0, 0, 0, 0);
            A_SpawnItemEx("ZDRPGShieldStaticParticle", Random(-64,64), Random(-64,64), Random(-64,64), 0, 0, 0, 0);
        }
        TNT1 A 0 A_CountDown;
        Loop;
    Death:
        TNT1 A 1;
        Stop;
    }
}

class ZDRPGStaticChargeShieldLargeExplosion : ZDRPGStaticChargeShieldExplosion
{
    Default
    {
        ReactionTime 12;
    }
    
    States
    {
        Spawn:
            TNT1 A 3 A_Explode(6, 256, 0, true, 256);
            TNT1 A 0 A_SpawnItemEx("ZDRPGShieldStaticParticle", Random(-128,128), Random(-128,128), Random(-128,128), 0, 0, 0, 0);
            TNT1 A 0 A_SpawnItemEx("ZDRPGShieldStaticParticle", Random(-128,128), Random(-128,128), Random(-128,128), 0, 0, 0, 0);
            TNT1 A 0 A_SpawnItemEx("ZDRPGShieldStaticParticle", Random(-128,128), Random(-128,128), Random(-128,128), 0, 0, 0, 0);
            TNT1 A 0 A_CountDown;
            Loop;
    }
}
