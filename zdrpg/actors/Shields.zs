class ZDRPGShield : Inventory
{
    bool Active;
    int Charge;

    int MaxCharge;
    int ChargeRate;
    double Delay;

    double DelayCounter;

    ZDRPGShieldPart Body;
    ZDRPGShieldPart Capacitor;
    ZDRPGShieldPart Battery;
    ZDRPGShieldPart Accessory; 
      
    Default
    {
        Inventory.Amount 1;
        Inventory.MaxAmount 1;
        +Inventory.Undroppable;
        +Inventory.Untossable;
        +Inventory.PersistentPower;
    }

    override void DoEffect()
    {
        if(!IsAssembled())
        {
            Active = false;
            Charge = 0;
        }

        if(Active)
        {
            if(DelayCounter > 0)
                DelayCounter--;

            if(Charge < MaxCharge)
                RegenerateShield();
        }
    }

    override void AttachToOwner (Actor other) 
    {
        Super.AttachToOwner(other);
        Active = false;
        Delay = 5;
        Charge = 0;
    }

    override void AbsorbDamage (int damage, Name damageType, out int newdamage, Actor inflictor, Actor source, int flags)
    {
        if(Active)
        {
            if(damage >= Charge)
            {
                let remainderDamage = damage - Charge; 
                Charge = 0;
                newdamage = remainderDamage;
            }
            else
            {
                Charge -= damage;
                newdamage = 0;
            }
            DelayCounter = Delay * 35;
        }
    }

    bool IsAssembled()
    {
        if(Body && Capacitor && Battery)
            return true;
        return false;
    }

    void ToggleShield()
    {
        if(IsAssembled())
        {
            Active = !Active;
            Charge = 0;
            DelayCounter = Delay * 35;
        }
        else
            console.printf("Shield is incomplete");
    }

    void CalculateShieldStats()
    {
        int BodyCapacity = 0;
        double BodyChargeRate = 0;
        double BodyDelay = 0;

        int BatteryCapacity = 0;
        double BatteryChargeRate = 0;
        double BatteryDelay = 0;

        int CapacitorCapacity = 0;
        double CapacitorChargeRate = 0;
        double CapacitorDelay = 0;

        if(Body)
        {
            BodyCapacity = Body.Capacity;
            BodyChargeRate = Body.ChargeRate;
            BodyDelay = Body.Delay;
        }
        if(Battery)
        {
            BatteryCapacity = Battery.Capacity;
            BatteryChargeRate = Battery.ChargeRate;
            BatteryDelay = Battery.Delay;
        }
        if(Capacitor)
        {
            CapacitorCapacity = Capacitor.Capacity;
            CapacitorChargeRate = Capacitor.ChargeRate;
            CapacitorDelay = Capacitor.Delay;
        }

        MaxCharge = BodyCapacity + BatteryCapacity + CapacitorCapacity;
        ChargeRate = BodyChargeRate + BatteryChargeRate + CapacitorChargeRate;

        if(BodyDelay + BatteryDelay + CapacitorDelay != 0)
            Delay = 5 + BodyDelay + BatteryDelay + CapacitorDelay;

        if(Delay < 1)
            Delay = 1;

        if(ChargeRate < 1)
            ChargeRate = 0;
    }

    void RegenerateShield()
    {
        if(GameTic % 35 == 0 && DelayCounter == 0)
        {
            if(Charge + ChargeRate > MaxCharge) {
                Charge = MaxCharge;
            } else {
                Charge += ChargeRate;
            }
        }
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
    int Capacity;
    int ChargeRate;
    double Delay;

    property Capacity   : Capacity;
    property ChargeRate : ChargeRate;
    property Delay      : Delay;

    Default
    {
        Scale 0.5;
    
        Inventory.MaxAmount 100;
        Inventory.InterHubAmount 100;
        Inventory.PickupMessage "Got a Shield Part!";
        Inventory.PickupSound "shield/pickup";

        ZDRPGShieldPart.Capacity   0;
        ZDRPGShieldPart.ChargeRate 0;
        ZDRPGShieldPart.Delay      0;
    }
    
    States
    {
        Spawn:
            SHCA A -1 Bright;
            Stop;
        Pickup:
            SHCA A 0;
            Stop;
    }
}

class ZDRPGShieldBody      : ZDRPGShieldPart {}
class ZDRPGShieldBattery   : ZDRPGShieldPart {}
class ZDRPGShieldCapacitor : ZDRPGShieldPart {}
class ZDRPGShieldAccessory : ZDRPGShieldPart 
{
    ZDRPGShield Shield;
    override void AttachToOwner (Actor other) 
    {
        Super.AttachToOwner(other);
        Shield = ZDRPGShield(owner.FindInventory("ZDRPGShield"));
    }

    override void DoEffect()
    {
        if(Shield.IsAssembled() && Shield.Active && Shield.Accessory && Shield.Accessory.GetClassName() == self.GetClassName())
            ApplyAccessoryEffect();
    }

    virtual void ApplyAccessoryEffect() {}
}

// BODIES
// --------------------------------------------------

class ZDRPGShieldBody1 : ZDRPGShieldBody
{
    Default
    {
        Tag "UAC";
        ZDRPGShieldPart.Capacity 25;
    }
    States
    {
        Spawn:
            SHBO A -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody2 : ZDRPGShieldBody
{
    Default
    {
        Tag "Xtron";
        ZDRPGShieldPart.Capacity 50;
    }
    States
    {
        Spawn:
            SHBO B -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody3 : ZDRPGShieldBody
{
    Default
    {
        Tag "Black Mesa";
        ZDRPGShieldPart.Capacity 150;
        ZDRPGShieldPart.Delay 2;
    }
    States
    {
        Spawn:
            SHBO C -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody4 : ZDRPGShieldBody
{
    Default
    {
        Tag "EDF";
        ZDRPGShieldPart.Capacity 100;
    }
    States
    {
        Spawn:
            SHBO D -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody5 : ZDRPGShieldBody
{
    Default
    {
        Tag "Cyberdyne Systems";
        ZDRPGShieldPart.Capacity 80;
        ZDRPGShieldPart.ChargeRate 2;
    }
    States
    {
        Spawn:
            SHBO E -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody6 : ZDRPGShieldBody
{
    Default
    {
        Tag "Misfit Tech";
        ZDRPGShieldPart.Capacity 150;
    }
    States
    {
        Spawn:
            SHBO F -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody7 : ZDRPGShieldBody
{
    Default
    {
        Tag "Shadaloo";
        Inventory.PickupSound "shield/bisonpickup";
        ZDRPGShieldPart.Capacity 400;
        ZDRPGShieldPart.ChargeRate -1;
        ZDRPGShieldPart.Delay 4;
    }
    
    States
    {
        Spawn:
            SHBO G -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody8 : ZDRPGShieldBody
{
    Default
    {
        Tag "Arkai";
        ZDRPGShieldPart.Capacity 250;
    }
    States
    {
        Spawn:
            SHBO H -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody9 : ZDRPGShieldBody
{
    Default
    {
        Tag "Ironclad Inc.";
        ZDRPGShieldPart.Capacity 150;
        ZDRPGShieldPart.Delay -2;
    }
    States
    {
        Spawn:
            SHBO I -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody10 : ZDRPGShieldBody
{
    Default
    {
        Tag "Yholl";
        ZDRPGShieldPart.Capacity 50;
        ZDRPGShieldPart.ChargeRate 5;
        ZDRPGShieldPart.Delay -3;
    }
    States
    {
        Spawn:
            SHBO J -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody11 : ZDRPGShieldBody
{
    Default
    {
        Tag "Hyperix";
        ZDRPGShieldPart.Capacity 200;
        ZDRPGShieldPart.ChargeRate 1;
        ZDRPGShieldPart.Delay -1;
    }
    States
    {
        Spawn:
            SHBO K -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody12 : ZDRPGShieldBody
{
    Default
    {
        Tag "Xaser";
        ZDRPGShieldPart.Capacity 500;
        ZDRPGShieldPart.Delay 2.5;
    }
    States
    {
        Spawn:
            SHBO L -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody13 : ZDRPGShieldBody
{
    Default
    {
        Tag "Datadyne";
        ZDRPGShieldPart.Capacity 250;
        ZDRPGShieldPart.ChargeRate 3;
        ZDRPGShieldPart.Delay -1;
    }

    States
    {
        Spawn:
            SHBO M -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody14 : ZDRPGShieldBody
{
    Default
    {
        Tag "Starbright";
        ZDRPGShieldPart.Capacity 400;
        ZDRPGShieldPart.ChargeRate 2;
        ZDRPGShieldPart.Delay -1;
    }
    States
    {
        Spawn:
            SHBO N -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody15 : ZDRPGShieldBody
{
    Default
    {
        Tag "Hellsing";
        ZDRPGShieldPart.Capacity 666;
        ZDRPGShieldPart.ChargeRate -1;
    }
    States
    {
        Spawn:
            SHBO O -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody16 : ZDRPGShieldBody
{
    Default
    {
        Tag "S.H.I.E.L.D.";
        ZDRPGShieldPart.Capacity 500;
    }
    States
    {
        Spawn:
            SHBO P -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody17 : ZDRPGShieldBody
{
    Default
    {
        Tag "UAC Elite";
        ZDRPGShieldPart.Capacity 400;
        ZDRPGShieldPart.ChargeRate 1;
        ZDRPGShieldPart.Delay -3;
    }
    States
    {
        Spawn:
            SHBO Q -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody18 : ZDRPGShieldBody
{
    Default
    {
        Tag "Stark Industries";
        ZDRPGShieldPart.Capacity 550;
        ZDRPGShieldPart.ChargeRate 1;
        ZDRPGShieldPart.Delay -1;
    }
    States
    {
        Spawn:
            SHBO R -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody19 : ZDRPGShieldBody
{
    Default
    {
        Tag "Weyland-Yutani";
        ZDRPGShieldPart.Capacity 100;
        ZDRPGShieldPart.ChargeRate 7;
    }
    States
    {
        Spawn:
            SHBO S -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody20 : ZDRPGShieldBody
{
    Default
    {
        Tag "Megalith";
        ZDRPGShieldPart.Capacity 750;
        ZDRPGShieldPart.Delay 5;
    }
    States
    {
        Spawn:
            SHBO T -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody21 : ZDRPGShieldBody
{
    Default
    {
        Tag "Reaper Industries";
        ZDRPGShieldPart.Capacity 444;
        ZDRPGShieldPart.ChargeRate 4;
        ZDRPGShieldPart.Delay -4;
    }
    States
    {
        Spawn:
            SHBO U -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBody22 : ZDRPGShieldBody
{
    Default
    {
        Tag "Eternity Systems";
        ZDRPGShieldPart.Capacity 2000;
        ZDRPGShieldPart.Delay 15;
    }
    States
    {
        Spawn:
            SHBO V -1 Bright;
            Stop;
    }
}

// BATTERIES
// --------------------------------------------------

class ZDRPGShieldBattery1 : ZDRPGShieldBattery
{
    Default
    {
        Tag "Crappy";
        ZDRPGShieldPart.Capacity 25;
    }

    States
    {
        Spawn:
            SHBA A -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery2 : ZDRPGShieldBattery
{
    Default
    {
        Tag "Bullet";
        ZDRPGShieldPart.Capacity 50;
        ZDRPGShieldPart.ChargeRate 1;
    }
    States
    {
        Spawn:
            SHBA B -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery3 : ZDRPGShieldBattery
{
    Default
    {
        Tag "Elegant";
        ZDRPGShieldPart.Capacity 20;
        ZDRPGShieldPart.Delay -3;
    }
    States
    {
        Spawn:
            SHBA C -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery4 : ZDRPGShieldBattery
{
    Default
    {
        Tag "Spiked";
        ZDRPGShieldPart.Capacity 100;
        ZDRPGShieldPart.ChargeRate 1;
    }
    States
    {
        Spawn:
            SHBA D -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery5 : ZDRPGShieldBattery
{
    Default
    {
        Tag "Stubborn";
        ZDRPGShieldPart.Capacity 250;
    }
    States
    {
        Spawn:
            SHBA E -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery6 : ZDRPGShieldBattery
{
    Default
    {
        Tag "Mirrored";
        ZDRPGShieldPart.Capacity 150;
        ZDRPGShieldPart.ChargeRate 2;
    }
    States
    {
        Spawn:
            SHBA F -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery7 : ZDRPGShieldBattery
{
    Default
    {
        Tag "Refined";
        ZDRPGShieldPart.Capacity 100;
        ZDRPGShieldPart.ChargeRate 2;
        ZDRPGShieldPart.Delay -1;
    }
    States
    {
        Spawn:
            SHBA G -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery8 : ZDRPGShieldBattery
{
    Default
    {
        Tag "Clustered";
        ZDRPGShieldPart.Capacity 200;
        ZDRPGShieldPart.ChargeRate 3;
    }
    States
    {
        Spawn:
            SHBA H -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery9 : ZDRPGShieldBattery
{
    Default
    {
        Tag "Winged";
        ZDRPGShieldPart.Capacity 250;
        ZDRPGShieldPart.ChargeRate 4;
    }
    States
    {
        Spawn:
            SHBA I -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery10 : ZDRPGShieldBattery
{
    Default
    {
        Tag "Overcharged";
        ZDRPGShieldPart.Capacity 10;
        ZDRPGShieldPart.ChargeRate 5;
        ZDRPGShieldPart.Delay -2;
    }
    States
    {
        Spawn:
            SHBA J -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery11 : ZDRPGShieldBattery
{
    Default
    {
        Tag "Superb";
        ZDRPGShieldPart.Capacity 425;
        ZDRPGShieldPart.ChargeRate 1;
    }
    States
    {
        Spawn:
            SHBA K -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery12 : ZDRPGShieldBattery
{
    Default
    {
        Tag "Redundant";
        ZDRPGShieldPart.Capacity 50;
        ZDRPGShieldPart.ChargeRate 30;
        ZDRPGShieldPart.Delay 15;
    }
    States
    {
        Spawn:
            SHBA L -1 Bright;
            Stop;
    }
}

class ZDRPGShieldBattery13 : ZDRPGShieldBattery
{
    Default
    {
        Tag "Reinforced";
        ZDRPGShieldPart.Capacity 1000;
        ZDRPGShieldPart.ChargeRate 2;
        ZDRPGShieldPart.Delay 2.5;
    }
    States
    {
        Spawn:
            SHBA M -1 Bright;
            Stop;
    }
}

// CAPACITORS
// --------------------------------------------------

class ZDRPGShieldCapacitor1 : ZDRPGShieldCapacitor
{
    Default
    {   Tag "Standard";
        ZDRPGShieldPart.ChargeRate 1;
    }

    States
    {
        Spawn:
            SHCA A -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor2 : ZDRPGShieldCapacitor
{
    Default
    {
        Tag "Outdated";
        ZDRPGShieldPart.ChargeRate 3;
        ZDRPGShieldPart.Delay 2;
    }

    States
    {
        Spawn:
            SHCA B -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor3 : ZDRPGShieldCapacitor
{
    Default
    {
        Tag "Cooled";
        ZDRPGShieldPart.ChargeRate 2;
    }
    States
    {
        Spawn:
            SHCA C -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor4 : ZDRPGShieldCapacitor
{
    Default
    {
        Tag "Warm";
        ZDRPGShieldPart.Capacity 25;
        ZDRPGShieldPart.ChargeRate 1;
    }
    States
    {
        Spawn:
            SHCA D -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor5 : ZDRPGShieldCapacitor
{
    Default
    {
        Tag "Inefficient";
        ZDRPGShieldPart.ChargeRate 6;
        ZDRPGShieldPart.Delay 5;
    }
    States
    {
        Spawn:
            SHCA E -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor6 : ZDRPGShieldCapacitor
{
    Default
    {
        Tag "Energized";
        ZDRPGShieldPart.ChargeRate 3;
    }
    States
    {
        Spawn:
            SHCA F -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor7 : ZDRPGShieldCapacitor
{
    Default
    {
        Tag "Infused";
        ZDRPGShieldPart.ChargeRate 4;
    }
    States
    {
        Spawn:
            SHCA G -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor8 : ZDRPGShieldCapacitor
{
    Default
    {
        Tag "Plasmatic";
        ZDRPGShieldPart.Capacity 100;
        ZDRPGShieldPart.ChargeRate 3;
    }
    States
    {
        Spawn:
            SHCA H -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor9 : ZDRPGShieldCapacitor
{
    Default
    {
        Tag "Burning";
        ZDRPGShieldPart.ChargeRate 5;
    }
    States
    {
        Spawn:
            SHCA I -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor10 : ZDRPGShieldCapacitor
{
    Default
    {
        Tag "Pulsating";
        ZDRPGShieldPart.ChargeRate 1;
        ZDRPGShieldPart.Delay -5;
    }
    States
    {
        Spawn:
            SHCA J -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor11 : ZDRPGShieldCapacitor
{
    Default
    {
        Tag "Fiery";
        ZDRPGShieldPart.ChargeRate 5;
        ZDRPGShieldPart.Delay -1;
    }
    States
    {
        Spawn:
            SHCA K -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor12 : ZDRPGShieldCapacitor
{
    Default
    {
        Tag "Eternal";
        ZDRPGShieldPart.Capacity 500;
        ZDRPGShieldPart.ChargeRate 1;
        ZDRPGShieldPart.Delay 3;
    }
    States
    {
        Spawn:
            SHCA L -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor13 : ZDRPGShieldCapacitor
{
    Default
    {
        Tag "Overloaded";
        ZDRPGShieldPart.ChargeRate 10;
        ZDRPGShieldPart.Delay 1;
    }
    States
    {
        Spawn:
            SHCA M -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor14 : ZDRPGShieldCapacitor
{
    Default
    {
        Tag "Dark";
        ZDRPGShieldPart.Capacity 1000;
        ZDRPGShieldPart.ChargeRate -1;
        ZDRPGShieldPart.Delay 15;
    }
    States
    {
        Spawn:
            SHCA N -1 Bright;
            Stop;
    }
}

class ZDRPGShieldCapacitor15 : ZDRPGShieldCapacitor
{
    Default
    {
        Tag "Chaotic";
        ZDRPGShieldPart.ChargeRate 7;
        ZDRPGShieldPart.Delay -7;
    }
    States
    {
        Spawn:
            SHCA O -1 Bright;
            Stop;
    }
}

// ACCESSORIES
// --------------------------------------------------

class ZDRPGShieldAccessory1 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "X-7";
    }
    States
    {
        Spawn:
            SHAC A -1 Bright;
            Stop; 
    }

    override void ApplyAccessoryEffect()
    {
        console.printf("123a");
    }
}

class ZDRPGShieldAccessory2 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "SGENX-5B";
    }
    States
    {
        Spawn:
            SHAC B -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory3 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "AMP-3000";
    }
    States
    {
        Spawn:
            SHAC C -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory4 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "HRY-VP80";
    }
    States
    {
        Spawn:
            SHAC D -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory5 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "DEF-2";
    }
    States
    {
        Spawn:
            SHAC E -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory6 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "B1-ZUT3";
    }
    States
    {
        Spawn:
            SHAC F -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory7 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "CNV-RT99";
    }
    States
    {
        Spawn:
            SHAC G -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory8 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "REK-T50";
    }
    States
    {
        Spawn:
            SHAC H -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory9 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "VW-OT";
    }
    States
    {
        Spawn:
            SHAC I -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory10 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "CV-256";
    }
    States
    {
        Spawn:
            SHAC J -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory11 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "TX-BGONN";
    }
    States
    {
        Spawn:
            SHAC K -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory12 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "WRP30-LITE";
    }
    States
    {
        Spawn:
            SHAC L -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory13 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "NOV-A2";
    }
    States
    {
        Spawn:
            SHAC M -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory14 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "LZ-Y200";
    }
    States
    {
        Spawn:
            SHAC N -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory15 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "BST-700";
    }
    States
    {
        Spawn:
            SHAC O -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory16 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "PH-D88";
    }
    States
    {
        Spawn:
            SHAC P -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory17 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "BATT-B";
    }
    States
    {
        Spawn:
            SHAC Q -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory18 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "SHVR-Z7";
    }
    States
    {
        Spawn:
            SHAC R -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory19 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "MM-12";
    }
    States
    {
        Spawn:
            SHAC S -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory20 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "MRTE-KRAR";
    }
    States
    {
        Spawn:
            SHAC T -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory21 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "SP-00K";
    }
    States
    {
        Spawn:
            SHAC U -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory22 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "RR-GO";
    }
    States
    {
        Spawn:
            SHAC V -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory23 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "E1N-T31";
    }
    States
    {
        Spawn:
            SHAC W -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory24 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "PATR-0T";
    }
    States
    {
        Spawn:
            SHAC X -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory25 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "RNJSUS-2";
    }
    States
    {
        Spawn:
            SHAC Y -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory26 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "PWAA-9001";
    }
    States
    {
        Spawn:
            SHAC Z -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory27 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "AW-G01";
    }
    States
    {
        Spawn:
            SHA2 A -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory28 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "SCL-AR53";
    }
    States
    {
        Spawn:
            SHA2 B -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory29 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "RF-CT";
    }
    States
    {
        Spawn:
            SHA2 C -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory30 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "TEW-11";
    }
    States
    {
        Spawn:
            SHA2 D -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory31 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "NU-YU5";
    }
    States
    {
        Spawn:
            SHA2 E -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory32 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "RUS-ROU1";
    }
    States
    {
        Spawn:
            SHA2 F -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory33 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "TENS-H11";
    }
    States
    {
        Spawn:
            SHA2 G -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory34 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "TEEM-AU5";
    }
    States
    {
        Spawn:
            SHA2 H -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory35 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "VENG-R";
    }
    States
    {
        Spawn:
            SHA2 I -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory36 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "SANIC-S88";
    }
    States
    {
        Spawn:
            SHA2 J -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory37 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "NAKD-NOW";
    }
    States
    {
        Spawn:
            SHA2 K -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory38 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "HA3-L1N";
    }
    States
    {
        Spawn:
            SHA2 L -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory39 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "HAET-60";
    }
    States
    {
        Spawn:
            SHA2 M -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory40 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "PHA-LX2";
    }
    States
    {
        Spawn:
            SHA2 N -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory41 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "IKV-N7";
    }
    States
    {
        Spawn:
            SHA2 O -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory42 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "REGN-ERB";
    }
    States
    {
        Spawn:
            SHA2 P -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory43 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "COUN-TR20";
    }
    States
    {
        Spawn:
            SHA2 Q -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory44 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "PRO-100";
    }
    States
    {
        Spawn:
            SHA2 R -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory45 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "ADPT-V15";
    }
    States
    {
        Spawn:
            SHA2 S -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory46 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "OCD-MX90";
    }
    States
    {
        Spawn:
            SHA2 T -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory47 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "MASTA-R4";
    }
    States
    {
        Spawn:
            SHA2 U -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory48 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "HOW-EV3N";
    }
    States
    {
        Spawn:
            SHA2 V -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory49 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "K00-LAYD";
    }
    States
    {
        Spawn:
            SHA2 W -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory50 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "SKR00-G3";
    }
    States
    {
        Spawn:
            SHA2 X -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory51 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "INFI-NT1";
    }
    States
    {
        Spawn:
            SHA2 Y -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory52 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "REMI-500";
    }
    States
    {
        Spawn:
            SHA2 Z -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory53 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "FLAN-495";
    }
    States
    {
        Spawn:
            SHA2 "[" -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory54 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "TOJ1-K0";
    }
    States
    {
        Spawn:
            SHA2 \ -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory55 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "TRANS-EB252";
    }
    States
    {
        Spawn:
            SHA2 "]" -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory56 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "LIL-ZZ8";
    }
    States
    {
        Spawn:
            SHA3 A -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory57 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "MURD-BURD";
    }
    States
    {
        Spawn:
            SHA3 B -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory58 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "LKY-BSTRD4";
    }
    States
    {
        Spawn:
            SHA3 C -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory59 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "HEL-FY20";
    }
    States
    {
        Spawn:
            SHA3 D -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory60 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "MUN3-MAG";
    }
    States
    {
        Spawn:
            SHA3 E -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory61 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "EFF-C13";
    }
    States
    {
        Spawn:
            SHA3 F -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory62 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "SYN-C3P";
    }
    States
    {
        Spawn:
            SHA3 G -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory63 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "TUFF-MAG3";
    }
    States
    {
        Spawn:
            SHA3 H -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory64 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "UBR-MANZ5";
    }
    States
    {
        Spawn:
            SHA3 I -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory65 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "HORD-3RR";
    }
    States
    {
        Spawn:
            SHA3 J -1 Bright;
            Stop; 
    }
}

class ZDRPGShieldAccessory66 : ZDRPGShieldAccessory
{
    Default
    {
        Tag "S-SP4G3TT";
    }
    States
    {
        Spawn:
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
