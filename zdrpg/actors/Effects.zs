// --------------------------------------------------
// Aura FX
//

class ZDRPGAura : Actor
{
    int user_radius;
    int user_height;
    Default
    {
        +NoTimeFreeze;
        +NoInteraction;
        +NotOnAutomap;
        RenderStyle "None";
    }
}

class ZDRPGAuraParticle : Actor
{
    Default
    {
        +NoTimeFreeze;
        +NoInteraction;
        +NotOnAutomap;
        RenderStyle "Add";
    }
}

// Red Aura - Strength
class ZDRPGRedAura : ZDRPGAura
{
    States
    {
        Spawn:
            TNT1 A 2 NoDelay A_SpawnItemEx ("ZDRPGRedAuraParticle", 0,0,0, FRandom (0.1, 1.5 + (user_radius / 10)),0,FRandom (-2.5, 1.25), Random (0, 360));
            Stop;
    }
}

class ZDRPGRedAuraParticle : ZDRPGAuraParticle
{
    Default
    {
        Alpha 0.5;
        Scale 0.08;
    }
    States
    {
        Spawn:
            AUEF A 1 Bright;
            TNT1 A 0 
            {
                A_FadeOut (0.5 / 35.0);
                A_ScaleVelocity (0.97);
                A_ChangeVelocity (0, 0, 0.125);
            }
            Loop;
    }
}

// White Aura - XP
class ZDRPGWhiteAura : ZDRPGAura
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_JumpIf (CallACS ("GetTimer") % 4, "DoNothing");
            TNT1 A 0 A_SpawnItemEx ("ZDRPGWhiteAuraParticle",
                Cos ((-CallACS ("GetTimer") / 60.0) * 360.0 + 180.0) * (user_radius * 2.0),
                Sin ((-CallACS ("GetTimer") / 60.0) * 360.0 + 180.0) * (user_radius * 2.0),
                Sin ((-CallACS ("GetTimer") / 50.0) * 360.0 + 180.0) * (user_height / 4),
                0,0,0, 0);
            TNT1 A 2 A_SpawnItemEx ("ZDRPGWhiteAuraParticle",
                Cos ((CallACS ("GetTimer") / 50.0) * 360.0) * (user_radius * 2.0),
                Sin ((CallACS ("GetTimer") / 50.0) * 360.0) * (user_radius * 2.0),
                Sin ((CallACS ("GetTimer") / 60.0) * 360.0) * (user_height / 4),
                0,0,0, 0);
            Stop;
        DoNothing:
            TNT1 A 2;
            Stop;
    }
}

class ZDRPGWhiteAuraParticle : ZDRPGAuraParticle
{
    Default
    {
        Alpha 1.0;
        Scale 0.075;
    }
    States
    {
        Spawn:
            AUEF B 1 Bright;
            TNT1 A 0 
            {
                A_FadeOut (1.0 / 35.0);
                A_SetScale (ScaleX - 0.0021);
            }
            Loop;
    }
}

// Purple Aura - Regeneration
class ZDRPGPurpleAura : ZDRPGAura
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_JumpIf (CallACS ("GetTimer") % 6, "DoNothing");
            TNT1 A 2 A_SpawnItemEx ("ZDRPGPurpleAuraParticle",
                Random (-user_radius,user_radius),
                Random (-user_radius,user_radius),
                Random (-(user_height/2),user_height/2),
                0,0,1.0, 0);
            Stop;
        DoNothing:
            TNT1 A 2;
            Stop;
        }
}

// Same effect as Purple Aura but without the light
class ZDRPGRegenSphereEffect : ZDRPGPurpleAura {}

class ZDRPGPurpleAuraParticle : ZDRPGAuraParticle
{
    Default
    {
        Alpha 1.0;
        Scale 0.0375;
    }

    States
    {
        Spawn:
            AUEF C 1 Bright;
            TNT1 A 0 
            {
                A_FadeOut (1.0 / 35.0);
                A_SetScale (Scale.X - 0.001, Scale.Y + 0.001);
            }
            Loop;
    }
}

// Different version used for monsters' Purple Aura healing
class ZDRPGMonsterHealParticle : ZDRPGPurpleAuraParticle
{
    Default
    {
        ReactionTime 35;
    }
    
    States
    {
        Spawn:
            AUEF C 1 Bright A_CountDown;
            TNT1 A 0 
            {
                A_ScaleVelocity (0.95);
                A_ChangeVelocity (0, 0, 0.1, 0);
            }
            Loop;
        Death:
            AUEF C 1 Bright;
            TNT1 A 0 
            {
                A_ScaleVelocity (0.95);
                A_ChangeVelocity (0, 0, 0.1, 0);
                A_FadeOut (1.0 / 35.0);
                A_SetScale (Scale.X - 0.001, Scale.Y + 0.001);
            }
            Loop;
    }
}


// Orange Aura - Agility
class ZDRPGOrangeAura : ZDRPGAura
{
    States
    {
        Spawn:
            TNT1 A 2 NoDelay A_SpawnItemEx ("ZDRPGOrangeAuraParticle", -8,0,0, 0,0,0, 0);
            Stop;
    }
}

class ZDRPGOrangeAuraParticle : ZDRPGAuraParticle
{
    Default
    {
        Alpha 0.01;
        Scale 0.2;
    }
    States
    {
        Spawn:
            AUEF DDDDDDDDDDDDDDD 1 NoDelay Bright A_FadeIn (0.1 / 15.0);
            AUEF D 1 Bright A_FadeOut (0.1 / 15.0);
            Wait;
    }
}

// Green Aura - Defense
class ZDRPGGreenAura : ZDRPGAura
{
    int user_cycle;
    States
    {
        Spawn:
            TNT1 A 0 
            {
                A_JumpIf (user_cycle >= 360, "Done");
                A_SpawnItemEx (
                    "ZDRPGGreenAuraParticle",
                    Cos (user_cycle) * (user_radius * 2),
                    Sin (user_cycle) * (user_radius * 2),
                    Sin (CallACS ("GetTimer") * 3 + user_cycle) * (user_height / 4),
                    0,0,0, 0
                );
                user_cycle += 20;
            }
            Loop;
        Done:
            TNT1 A 2;
            Stop;
    }
}

class ZDRPGGreenAuraParticle : ZDRPGAuraParticle
{
    Default
    {
        Alpha 1.0;
        Scale 0.025;
    }
    States
    {
        Spawn:
            AUEF E 1 Bright;
            TNT1 A 0 A_FadeOut (1.0 / 4.0);
            Loop;
    }
}

// Pink Aura - Vitality
class ZDRPGPinkAura : ZDRPGAura
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_JumpIf (CallACS ("GetTimer") % 8, "DoNothing");
            TNT1 A 2 A_SpawnItemEx ("ZDRPGPinkAuraParticle",
                Random (-user_radius,user_radius),
                Random (-user_radius,user_radius),
                Random (-(user_height/2),user_height/2),
                0,0,1.0, 0);
            Stop;
        DoNothing:
            TNT1 A 2;
            Stop;
    }
}

class ZDRPGPinkAuraParticle : ZDRPGAuraParticle
{
    Default
    {
        Alpha 1.0;
        Scale 0.0375;
    }
    
    States
    {
        Spawn:
            AUEF F 1 Bright;
            TNT1 A 0
            {
                A_FadeOut (1.0 / 35.0);
                A_SetScale (Scale.X - 0.001);
            } 
            Loop;
    }
}

// Blue Aura - Energy
class ZDRPGCyanAura : ZDRPGAura
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_JumpIf (CallACS ("GetTimer") % 8, "DoNothing");
            TNT1 A 2 A_SpawnItemEx ("ZDRPGCyanAuraParticle",
                Random (-user_radius,user_radius),
                Random (-user_radius,user_radius),
                Random (-(user_height/2),user_height/2),
                0,0,0, 0);
            Stop;
        DoNothing:
            TNT1 A 2;
            Stop;
    }
}

class ZDRPGCyanAuraParticle : ZDRPGAuraParticle
{
    Default
    {
        Alpha 0.66;
        Scale 0.025;
    }

    States
    {
        Spawn:
            AUEF G 1 Bright;
            TNT1 A 0 
            {
                A_FadeOut (0.66 / 35.0);
                A_SetScale (Scale.X + 0.001);
            }
            Loop;
    }
}

// Dark Blue Aura - Capacity
class ZDRPGBlueAura : ZDRPGAura
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_JumpIf (CallACS ("GetTimer") % 20, "DoNothing");
            TNT1 A 2 A_SpawnItemEx ("ZDRPGBlueAuraParticle", 8,0,0, 0,0,0, 0);
            Stop;
        DoNothing:
            TNT1 A 2;
            Stop;
    }
}

class ZDRPGBlueAuraParticle : ZDRPGAuraParticle
{
    Default
    {
        Alpha 0.33;
        Scale 0.15;
    }
    
    States
    {
        Spawn:
            AUEF H 1 Bright;
            TNT1 A 0 A_FadeOut (0.33 / 35.0);
            TNT1 A 0 A_SetScale (Scale.X + 0.0014);
            Loop;
    }
}

// Yellow Aura - Luck
class ZDRPGYellowAura : ZDRPGAura
{
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_JumpIf (CallACS ("GetTimer") % 8, "DoNothing");
            TNT1 A 2 A_SpawnItemEx ("ZDRPGYellowAuraParticle",
                Random (-user_radius,user_radius),
                Random (-user_radius,user_radius),
                Random (-(user_height/2),user_height/2),
                0,0,0, 0);
            TNT1 A 0 A_JumpIf (!(CallACS ("GetTimer") % 35) && !Random (0, 2), "DropCoin");
            Stop;
        DropCoin:
            TNT1 A 0 A_SpawnItemEx ("ZDRPGLuckAuraCoin", 0,0,0, FRandom (-3,3),FRandom (-3,3),FRandom (-3,3), 0);
        DoNothing:
            TNT1 A 2;
            Stop;
    }
}

class ZDRPGYellowAuraParticle : ZDRPGAuraParticle
{
    Default
    {
        Alpha 1.0;
        Scale 0.075;
    }

    States
    {
        Spawn:
            AUEF I 1 Bright;
            TNT1 A 0 
            {
                A_FadeOut (1.0 / 35.0);
                A_SetScale (Scale.X - 0.0021);
            }
            Loop;
    }
}

class ZDRPGLuckAuraCoin : Actor
{
    Default
    {
        Projectile;
        +ThruActors;
        -NoGravity;
        +NotOnAutomap;
        Gravity 0.33;
        Damage 0;
        Speed 4;
        BounceCount 2;
        BounceType "Doom";
        BounceSound "skills/coinbounce";
        DeathSound "skills/coinbounce";
    }
    
    States
    {
        Spawn:
            AUEF J -1 Bright;
            Stop;
        Death:
            AUEF J 70 Bright;
            AUEF J 1 Bright A_FadeOut (1.0 / 20.0);
            Wait;
    }
}

// Black Aura - Miniboss
class ZDRPGBlackAura : ZDRPGAura
{
    States
    {
    Spawn:
        TNT1 A 0 NoDelay
        {
            A_JumpIf (CallACS ("GetTimer") % 6 > 0, 1);
            A_SpawnItemEx (
                "ZDRPGBlackAuraFloorFire",
                Random (-user_radius,user_radius),
                Random (-user_radius,user_radius),
                -(user_height / 2) + 8, 
                0,0,0, 0
            );
            A_JumpIf (CallACS ("GetTimer") % 8 > 0, 2);
        } 
        TNT1 AA 0
        {
            A_SpawnItemEx (
                "ZDRPGBlackAuraDarkPuff1",
                0,
                Random (user_radius,user_radius * 2),
                Random (-(user_height / 2),(user_height / 2)),
                1.0,0,0, Random (0, 360), 0, 128
            );
            A_SpawnItemEx (
                "ZDRPGBlackAuraDarkPuff2",
                0,
                Random (user_radius,user_radius * 2),
                Random (-(user_height / 2),(user_height / 2)),
                1.0,0,0, Random (0, 360), 0, 128
            );
        } 
        TNT1 A 2;
        Stop;
    }
}

class ZDRPGBlackAuraFloorFire : Actor
{
    Default
    {
        +NoTimeFreeze;
        +NoInteraction;
        +NotOnAutomap;
        RenderStyle "Translucent";
    }
    
    
    States
    {
        Spawn:
            MBAU A 2 Bright;
            TNT1 A 0 
            {
                A_FadeOut (0.05);
                A_SetScale (Scale.X - 0.05);
            }
            MBAU B 2 Bright;
            TNT1 A 0 
            {
                A_FadeOut (0.05);
                A_SetScale (Scale.X - 0.05);
            }
            MBAU C 2 Bright;
            TNT1 A 0 
            {
                A_FadeOut (0.05);
                A_SetScale (Scale.X - 0.05);
            }
            MBAU D 2 Bright;
            TNT1 A 0 
            {
                A_FadeOut (0.05);
                A_SetScale (Scale.X - 0.05);
            }
            MBAU E 2 Bright;
            TNT1 A 0 
            {
                A_FadeOut (0.05);
                A_SetScale (Scale.X - 0.05);
            }
            MBAU F 2 Bright;
            TNT1 A 0 
            {
                A_FadeOut (0.05);
                A_SetScale (Scale.X - 0.05);
            }
            MBAU G 2 Bright;
            TNT1 A 0 
            {
                A_FadeOut (0.05);
                A_SetScale (Scale.X - 0.05);
            }
            MBAU H 2 Bright;
            TNT1 A 0 
            {
                A_FadeOut (0.05);
                A_SetScale (Scale.X - 0.05);
            }
            MBAU I 2 Bright;
            TNT1 A 0 
            {
                A_FadeOut (0.05);
                A_SetScale (Scale.X - 0.05);
            }
            MBAU J 2 Bright;
            TNT1 A 0 
            {
                A_FadeOut (0.05);
                A_SetScale (Scale.X - 0.05);
            }
            MBAU K 2 Bright;
            TNT1 A 0 
            {
                A_FadeOut (0.05);
                A_SetScale (Scale.X - 0.05);
            }
            MBAU L 2 Bright;
            TNT1 A 0 
            {
                A_FadeOut (0.05);
                A_SetScale (Scale.X - 0.05);
            }
            MBAU M 2 Bright;
            TNT1 A 0 
            {
                A_FadeOut (0.05);
                A_SetScale (Scale.X - 0.05);
            }
            Loop;
    }
}

class ZDRPGBlackAuraDarkPuff1 : Actor
{
    Default
    {
        +NoTimeFreeze;
        +NoInteraction;
        +NotOnAutomap;
        RenderStyle "Translucent";
    }
    
    States
    {
        Spawn:
            MBAU NNNOOOPPPQQQRRR 2 Bright A_FadeOut (0.05);
            Loop;
    }
}

class ZDRPGBlackAuraDarkPuff2 : ZDRPGBlackAuraDarkPuff1
{
    Default
    {
        StencilColor "00 00 00";
    }
}

// Simple sprite versions
class ZDRPGSimpleAuraSprite : Actor
{
    Default
    {
        +NoTimeFreeze;
        +NoInteraction;
        +NotOnAutomap;
        +Synchronized;
        RenderStyle "Translucent";
        Alpha 0.5;
        Scale 0.66;
    }
    
    States
    {
        Spawn:
            TNT1 A 2;
            Stop;
    }
}

class ZDRPGRedAuraIndicator : ZDRPGSimpleAuraSprite
{
    States
    {
        Spawn:
            SAUR A 2 Bright;
            Stop;
    }
}

class ZDRPGGreenAuraIndicator : ZDRPGSimpleAuraSprite
{
    States
    {
        Spawn:
            SAUR B 2 Bright;
            Stop;
    }
}

class ZDRPGWhiteAuraIndicator : ZDRPGSimpleAuraSprite
{
    States
    {
        Spawn:
            SAUR J 2 Bright;
            Stop;
    }
}

class ZDRPGPinkAuraIndicator : ZDRPGSimpleAuraSprite
{
    States
    {
        Spawn:
            SAUR C 2 Bright;
            Stop;
    }
}

class ZDRPGCyanAuraIndicator : ZDRPGSimpleAuraSprite
{
    States
    {
        Spawn:
            SAUR D 2 Bright;
            Stop;
    }
}

class ZDRPGPurpleAuraIndicator : ZDRPGSimpleAuraSprite
{
    States
    {
        Spawn:
            SAUR E 2 Bright;
            Stop;
    }
}

class ZDRPGOrangeAuraIndicator : ZDRPGSimpleAuraSprite
{
    States
    {
        Spawn:
            SAUR F 2 Bright;
            Stop;
    }
}

class ZDRPGBlueAuraIndicator : ZDRPGSimpleAuraSprite
{
    States
    {
        Spawn:
            SAUR G 2 Bright;
            Stop;
    }
}

class ZDRPGYellowAuraIndicator : ZDRPGSimpleAuraSprite
{
    States
    {
        Spawn:
            SAUR H 2 Bright;
            Stop;
    }
}

class ZDRPGBlackAuraIndicator : ZDRPGSimpleAuraSprite
{
    States
    {
        Spawn:
            SAUR I 2 Bright;
            Stop;
    }
}

// Friendly Aura - Applied to friendly summons/monsters
class ZDRPGFriendlyAura : Actor
{
    Default
    {
        +NoTimeFreeze;
        +NoInteraction;
        +NotOnAutomap;
        RenderStyle "None";
    }
    
    States
    {
        Spawn:
            TNT1 A 2 NoDelay;
            Stop;
    }
}

class ZDRPGFriendlyIndicator : Actor
{
    Default
    {
        +NoTimeFreeze;
        +NoInteraction;
        +NotOnAutomap;
        Scale 0.05;
    }
    
    States
    {
        Spawn:
            GHRT A 1 Bright A_FadeOut (0.25);
            Wait;
    }
}

// --------------------------------------------------
// Radiation FX
//

class ZDRPGRadiationGlow : Actor
{
    Default
    {
        +NoTimeFreeze;
        +NoInteraction;
        +NotOnAutomap;
        
        Scale 0.05;
    }
    
    States
    {
        Spawn:
            TNT1 A 2 NoDelay A_SpawnItemEx("ZDRPGRadiationParticle", FRandom(-32, 32), FRandom(-32, 32), FRandom(-32, 32), 0, 0, 0, 0, 0, 250);
            Stop;
    }
}

class ZDRPGRadiationGlow2 : ZDRPGRadiationGlow
{
    int user_dissipation;
    
    States
    {
        Spawn:
            TNT1 AAAAAAAAAA 0;
        Idle:
            TNT1 A 0 A_StartSound("misc/radiation", CHAN_AUTO, 1.0, true, ATTN_NORM);
            TNT1 AAAAAAAAAAAAAAAAAA 4 A_SpawnItemEx("ZDRPGRadiationParticle", FRandom(-32, 32), FRandom(-32, 32), FRandom(-32, 32), 0, 0, 0, 0, 0, 128);
            TNT1 A 0
            {
                user_dissipation += (8 * Random(1, 2));
                A_Jump(256 - user_dissipation, "Idle");
            }
        Death:
            TNT1 A 0;
            Stop;
    }
}

class ZDRPGRadiationParticle : Actor
{
    Default
    {
        +NoInteraction;
        +NotOnAutomap;
        RenderStyle "Add";
        Scale 0.025;
    }
    
    States
    {
        Spawn:
            PTCL E 1 Bright NoDelay A_CheckSight("Death");
            PTCL E 0
            {
                A_ChangeVelocity(FRandom(-0.25,0.25),FRandom(-0.25,0.25),FRandom(-0.25,0.25));
                A_FadeOut(0.019);
                A_SetScale(Scale.X - 0.0005);
            }
            Loop;
        Death:
            TNT1 A 0;
            Stop;
    }
}

// --------------------------------------------------
// Generic FX
//

// Generic blingy particle
class ZDRPGBlingParticle : Actor
{
    Default
    {
        +NOTIMEFREEZE;
        +NOINTERACTION;
        +NOTONAUTOMAP;
        
        Scale 0.025;
        
        RenderStyle "Add";
    }
    
    States
    {
    Spawn:
        AUEF B 1 Bright;
        TNT1 A 0 A_FadeOut(0.05);
        Loop;
    }
}

// EP Focus
class ZDRPGEPFocusAura : Actor
{
    Default
    {
        +NOTIMEFREEZE;
        +NOINTERACTION;
        +NOTONAUTOMAP;
        
        XScale 2.0;
        YScale 1.0;
        
        Alpha 0.5;
        RenderStyle "Add";
        Translation "0 : 255 = %[0.0, 0.0, 0.0] : [0.0, 0.25, 0.5]";
    }
    
    States
    {
        Spawn:
            PBEA A 1 Bright;
            TNT1 A 0 A_FadeOut(0.025);
            Loop;
    }
}

// --------------------------------------------------
// Transport particles and FX
//

class ZDRPGTransportEffect : Actor
{
    int user_loop;
    int user_angle;
    int user_height;
    int user_direction;
    int user_iterations;

    Default
    {
        +NOTIMEFREEZE;
        +NOINTERACTION;
        +NOTONAUTOMAP;
    }
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay 
        {
            user_direction = 1;
        }
    Spawn2:
        TNT1 A 0 
        {
            A_SpawnItemEx(
                "ZDRPGTransportEffectParticle",
                Cos(user_angle) * 32,
                Sin(user_angle) * 32,
                user_height, 
                0, 0, 0, 0, SXF_NOCHECKPOSITION
            );
            A_Quake(9, 2, 0, 64, "");
            user_angle += 11.25;
            A_JumpIf(user_loop >= 8, "ReLoop");
            A_JumpIf(user_Angle >= 360 && user_direction == 1, "MoveUp");
            A_JumpIf(user_Angle >= 360 && user_direction == -1, "MoveDown");
        }
        Loop;
    MoveUp:
        TNT1 A 0 
        {
            user_loop += 1;
            user_angle = 0;
        }
        TNT1 A 2 
        {
            user_height += 8;
        }
        Goto Spawn2;
    MoveDown:
        TNT1 A 0
        {
            user_loop += 1;
            user_angle = 0;
        }
        TNT1 A 2 
        {
            user_height -= 8;
        }
        Goto Spawn2;
    ReLoop:
        TNT1 A 0 
        {
            user_loop = 0;
            user_direction = !user_direction;
            user_iterations += 1;
            A_JumpIf(user_iterations >= 4, "Done");
            A_JumpIf(user_direction == 1, "SetDown");
            A_JumpIf(user_direction == -1, "SetUp");
        }
        Stop;
    SetUp:
        TNT1 A 0
        {
            user_height = 7*8;
        }
        Goto Spawn2;
    SetDown:
        TNT1 A 0
        {
            user_height = 0;
        }
        Goto Spawn2;
    Done:
        TNT1 A 0;
        Stop;
    }
}

class ZDRPGTransportEffectParticle : Actor
{
    Default
    {
        +NOTIMEFREEZE;
        +NOINTERACTION;
        +NOTONAUTOMAP;
        
        YScale 0.125;
        
        Alpha 0.5;
        RenderStyle "AddStencil";
        
        StencilColor "0096FF";
        
        Translation "0 : 255 = %[0.0, 0.0, 0.0] : [0.0, 0.25, 0.0]";
    }
    
    States
    {
        Spawn:
            PBEA A 1 Bright;
            TNT1 A 0 A_FadeOut(0.025);
            Loop;
    }
}

class ZDRPGTransportSetNonShootable : Inventory
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
                bSOLID = false;
                bSHOOTABLE = false;
                bNONSHOOTABLE = true;
            }
            Stop;
    }
}

class ZDRPGTransportUnsetNonShootable : Inventory
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
                bSOLID = true;
                bSHOOTABLE = true;
                bNONSHOOTABLE = false;
            }
            Stop;
    }
}

// --------------------------------------------------
// Immunity Crystal beams and FX
//

class ZDRPGImmunityCrystalPulse : Actor
{
    Default
    {
        +NOGRAVITY;
        +NOTIMEFREEZE;
        +NOINTERACTION;
        +NOTONAUTOMAP;
        
        RenderStyle "Add";
        Alpha 0.5;
    }

    States
    {
        Spawn:
            TNT1 A 0 
            {
                A_FadeOut(0.1, true);
                A_SetScale(Scale.X + 0.1, Scale.Y + 0.1);
            }
            Loop;
    }
    
}

class ZDRPGImmunityCrystalPulseMelee : ZDRPGImmunityCrystalPulse
{
    States
    {
        Spawn:
            CRYS A 1 Bright;
            goto super::Spawn;
    }
}

class ZDRPGImmunityCrystalPulseBullet : ZDRPGImmunityCrystalPulse
{
    States
    {
        Spawn:
            CRYS B 1 Bright;
            goto super::Spawn;
    }
}

class ZDRPGImmunityCrystalPulseFire : ZDRPGImmunityCrystalPulse
{
    States
    {
        Spawn:
            CRYS C 1 Bright;
            goto super::Spawn;
    }
}

class ZDRPGImmunityCrystalPulsePlasma : ZDRPGImmunityCrystalPulse
{
    States
    {
        Spawn:
            CRYS D 1 Bright;
            goto super::Spawn;
    }
}

class ZDRPGImmunityCrystalPulseLightning : ZDRPGImmunityCrystalPulse
{
    States
    {
        Spawn:
            CRYS E 1 Bright;
            goto super::Spawn;
    }
}

class ZDRPGImmunityCrystalPulseToxic : ZDRPGImmunityCrystalPulse
{
    States
    {
        Spawn:
            CRYS F 1 Bright;
            goto super::Spawn;
        }
}

class ZDRPGImmunityCrystalPulseRadiation : ZDRPGImmunityCrystalPulse
{
    States
    {
        Spawn:
            CRYS G 1 Bright;
            goto super::Spawn;
        }
}

class ZDRPGImmunityCrystalBeam : Actor
{
    Default
    {
        +NOTIMEFREEZE;
        +NOINTERACTION;
        +NOTONAUTOMAP;
        
        Scale 4.0;
        
        Alpha 0.5;
        RenderStyle "Add";
    }
    
    States
    {
        Spawn:
            PBEA A 1 Bright;
            TNT1 A 0 A_FadeOut(0.005);
            Loop;
    }
}

class ZDRPGImmunityCrystalBeamMelee : ZDRPGImmunityCrystalBeam
{
    Default
    {
        Translation "0 : 255 = %[0.0, 0.0, 0.0] : [0.25, 0.33, 0.25]";
    }
    
}

class ZDRPGImmunityCrystalBeamBullet : ZDRPGImmunityCrystalBeam
{
    Default
    {
        Translation "0 : 255 = %[0.0, 0.0, 0.0] : [1.0, 1.0, 1.0]";
    }
}

class ZDRPGImmunityCrystalBeamFire : ZDRPGImmunityCrystalBeam
{
    Default
    {
        Translation "0 : 255 = %[0.0, 0.0, 0.0] : [0.5, 0.0, 0.0]";
    }
}

class ZDRPGImmunityCrystalBeamPlasma : ZDRPGImmunityCrystalBeam
{
    Default
    {
        Translation "0 : 255 = %[0.0, 0.0, 0.0] : [0.0, 0.0, 0.5]";   
    }
}

class ZDRPGImmunityCrystalBeamLightning : ZDRPGImmunityCrystalBeam
{
    Default
    {
        Translation "0 : 255 = %[0.0, 0.0, 0.0] : [0.0, 0.0, 1.0]";
    }
}

class ZDRPGImmunityCrystalBeamToxic : ZDRPGImmunityCrystalBeam
{
    Default
    {
        Translation "0 : 255 = %[0.0, 0.0, 0.0] : [0.0, 0.5, 0.0]";
    }
}

class ZDRPGImmunityCrystalBeamRadiation : ZDRPGImmunityCrystalBeam
{
    Default
    {
        Translation "0 : 255 = %[0.0, 0.0, 0.0] : [0.0, 1.0, 0.0]";
    }
}

class ZDRPGImmunityCrystalDebris : Actor
{
    Default
    {
        RenderStyle "Add";
        Gravity 0.5;
        BounceType "Classic";
        BounceFactor 1.0;
        WallBounceFactor 1.0;
        BounceCount 0x7FFFFFFF;
        
        +BOUNCEONWALLS;
        +BOUNCEONFLOORS;
        +BOUNCEONCEILINGS;
    }
    
    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_StartSound("powerups/crystalpulse", CHAN_6, 1.0, true, 0.5);
            CRYS H 1;
            TNT1 A 0 
            {
                A_FadeOut(0.0001, true);
                A_Explode(10, 1);
            }
            Goto Spawn+1;
    }
}


// --------------------------------------------------
// Turret Particles and FX
//

class ZDRPGTurretTeleport : Actor
{
    int user_loop;
    int user_angle;
    int user_height;

    Default
    {
        +NOTIMEFREEZE;
        +NOINTERACTION;
        +NOTONAUTOMAP;
    }    
    
    States
    {
        Spawn:
            TNT1 A 0 
            {
                A_SpawnItemEx(
                    "ZDRPGTurretTeleportParticle",
                    Cos(user_angle) * 32,
                    Sin(user_angle) * 32,
                    user_height, 
                    0, 0, 0, 0, SXF_NOCHECKPOSITION
                );
                user_angle += 11.25;
                A_JumpIf(user_loop >= 8, "Done");
                A_JumpIf(user_Angle >= 360, "MoveUp");
            }
            Loop;
        MoveUp:
            TNT1 A 0 
            {
                user_loop += 1;
                user_angle = 0;
                user_height += 8;
            }
            Goto Spawn;
        Done:
            TNT1 A 0;
            Stop;
    }
}

class ZDRPGTurretTeleportParticle : ZDRPGTransportEffectParticle
{
    Default
    {
        Alpha 0.25;
    }
    
    States
    {
        Spawn:
            PBEA A 1 Bright;
            TNT1 A 0 
            {
                A_FadeOut(0.005);
                ThrustThingZ(0, 4, 0, 0);
                A_SetScale(Scale.X + 0.001, Scale.Y + 0.001);
            }
            Loop;
    }
}