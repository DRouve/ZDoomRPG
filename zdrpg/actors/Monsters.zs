actor DRPGZombieMan : Zombieman Replaces Zombieman
{
    Tag "Former Human"
    
    States
    {
    Spawn:
        POSS A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::Spawn
    See:
        POSS A 0 ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::See
    }
}

actor DRPGShotgunGuy : ShotgunGuy Replaces ShotgunGuy
{
    Tag "Former Sergeant"
    
    States
    {
    Spawn:
        SPOS A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::Spawn
    See:
        SPOS A 0 ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::See
    }
}

actor DRPGChaingunGuy : ChaingunGuy Replaces ChaingunGuy
{
    Tag "Former Commando"
    
    States
    {
    Spawn:
        CPOS A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::Spawn
    See:
        CPOS A 0 ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::See
    }
}

actor DRPGDoomImp : DoomImp Replaces DoomImp
{
    Tag "Imp"
    
    States
    {
    Spawn:
        TROO A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::Spawn
    See:
        TROO A 0 ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::See
    }
}

actor DRPGDemon : Demon Replaces Demon
{
    Tag "Demon"
    
    States
    {
    Spawn:
        SARG A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::Spawn
    See:
        SARG A 0 ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::See
    }
}

actor DRPGSpectre : Spectre Replaces Spectre
{
    Tag "Spectre"
    
    States
    {
    Spawn:
        SARG A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::Spawn
    See:
        SARG A 0 ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::See
    }
}

actor DRPGCacodemon : Cacodemon Replaces Cacodemon
{
    Tag "Cacodemon"
    
    States
    {
    Spawn:
        HEAD A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::Spawn
    See:
        HEAD A 0 ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::See
    }
}

actor DRPGHellKnight : HellKnight Replaces HellKnight
{
    Tag "Hell Knight"
    
    States
    {
    Spawn:
        BOS2 A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::Spawn
    See:
        BOS2 A 0 ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::See
    }
}

actor DRPGBaronOfHell : BaronOfHell Replaces BaronOfHell
{
    Tag "Baron of Hell"
    
    States
    {
    Spawn:
        BOSS A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::Spawn
    See:
        BOSS A 0 ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::See
    }
}

actor DRPGLostSoul : LostSoul Replaces LostSoul
{
    Tag "Lost Soul"
    
    States
    {
    Spawn:
		// ----- Lost Souls that are not map-based should not have their kills and XP taken into account due to possible spawn spam (Pain Elementals for example). ----- //
    	// Check if monster is map-based.
    	SKUL A 0 NoDelay A_JumpIf(GetLevelSpawnTime() == 0, 4)
    	// Not map-based.
    	SKUL A 0 ACS_NamedExecuteAlways("MonsterInit", 0, MF_NOXP | MF_NOAURA | MF_NODROPS)
    	SKUL A 0 A_ChangeFlag("COUNTKILL", false)
    	SKUL A 0 A_Jump(256, 2)
    	// Map-based.
    	SKUL A 0 ACS_NamedExecuteAlways("MonsterInit", 0, MF_NOAURA | MF_NODROPS)
    	TNT1 A 0
        Goto Super::Spawn
    See:
		// ----- Lost Souls that are not map-based should not have their kills and XP taken into account due to possible spawn spam (Pain Elementals for example). ----- //
    	// Check if monster is map-based.
    	SKUL A 0 A_JumpIf(GetLevelSpawnTime() == 0, 4)
    	// Not map-based.
    	SKUL A 0 ACS_NamedExecuteAlways("MonsterInit", 0, MF_NOXP | MF_NOAURA | MF_NODROPS)
    	SKUL A 0 A_ChangeFlag("COUNTKILL", false)
    	SKUL A 0 A_Jump(256, 2)
    	// Map-based.
    	SKUL A 0 ACS_NamedExecuteAlways("MonsterInit", 0, MF_NOAURA | MF_NODROPS)
    	TNT1 A 0
        Goto Super::See
    }
}

actor DRPGPainElemental : PainElemental Replaces PainElemental
{
    Tag "Pain Elemental"
    
    States
    {
    Spawn:
        PAIN A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::Spawn
    See:
        PAIN A 0 ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::See
    }
}

actor DRPGRevenant : Revenant Replaces Revenant
{
    Tag "Revenant"
    
    States
    {
    Spawn:
        SKEL A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::Spawn
    See:
        SKEL A 0 ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::See
    }
}

actor DRPGFatso : Fatso Replaces Fatso
{
    Tag "Mancubus"
    
    States
    {
    Spawn:
        FATT A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::Spawn
    See:
        FATT A 0 ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::See
    }
}

actor DRPGArachnotron : Arachnotron Replaces Arachnotron
{
    Tag "Arachnotron"
    
    States
    {
    Spawn:
        BSPI A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::Spawn
    See:
        BSPI A 0 ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::See
    }
}

actor DRPGArchvile : Archvile Replaces Archvile
{
    Tag "Archvile"
    
    States
    {
    Spawn:
        VILE A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::Spawn
    See:
        VILE A 0 ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::See
    }
}

actor DRPGWolfensteinSS : WolfensteinSS Replaces WolfensteinSS
{
    Tag "Wolfenstein SS"
    
    States
    {
    Spawn:
        SSWV A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::Spawn
    See:
        SSWV A 0 ACS_NamedExecuteAlways("MonsterInit", 0)
        Goto Super::See
    }
}

actor DRPGCyberdemon : Cyberdemon Replaces Cyberdemon
{
    Tag "Cyberdemon"
    
    States
    {
    Spawn:
        CYBR A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0, MF_BOSS)
        Goto Super::Spawn
    See:
        CYBR A 0 ACS_NamedExecuteAlways("MonsterInit", 0, MF_BOSS)
        Goto Super::See
    }
}

actor DRPGSpiderMastermind : SpiderMastermind Replaces SpiderMastermind
{
    Tag "Spider Mastermind"
    
    States
    {
    Spawn:
        SPID A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0, MF_BOSS)
        Goto Super::Spawn
    See:
        SPID A 0 ACS_NamedExecuteAlways("MonsterInit", 0, MF_BOSS)
        Goto Super::See
    }
}

// Projectiles
actor DRPGRocket : Rocket Replaces Rocket
{
    DamageType "Fire"
}

actor DRPGPlasmaBall : PlasmaBall Replaces PlasmaBall
{
    DamageType "Plasma"
}

actor DRPGBFGBall : BFGBall Replaces BFGBall
{
    DamageType "Plasma"
    +DONTREFLECT
}

actor DRPGDoomImpBall : DoomImpBall Replaces DoomImpBall
{
    DamageType "Fire"
    +THRUGHOST
}

actor DRPGCacodemonBall : CacodemonBall Replaces CacodemonBall
{
    DamageType "Electric"
    +THRUGHOST
}

actor DRPGBaronBall : BaronBall Replaces BaronBall
{
    DamageType "Plasma"
    +THRUGHOST
}

actor DRPGRevenantTracer : RevenantTracer Replaces RevenantTracer
{
    DamageType "Fire"
    +THRUGHOST
}

actor DRPGFatShot : FatShot Replaces FatShot
{
    DamageType "Fire"
    +THRUGHOST
}

actor DRPGArachnotronPlasma : ArachnotronPlasma Replaces ArachnotronPlasma
{
    DamageType "Electric"
    +THRUGHOST
}

actor DRPGArchvileFire : ArchvileFire Replaces ArchvileFire
{
    DamageType "Fire"
}

// The Boss Brain needs special handling for the exit script
actor DRPGBossBrain : BossBrain Replaces BossBrain
{
    States
    {
    Spawn:
        BBRN A 0 NoDelay ACS_NamedExecuteAlways("MonsterInit", 0, MF_NOXP | MF_NOSTATS | MF_NOAURA | MF_NOPAYKILL | MF_NODROPS | MF_NOHEALTHBAR)
        Goto Super::Spawn
    Death:
        BBRN A 0 ACS_Execute(30000, 0)
        Goto Super::Death
    }
}

// Practice Target
actor DRPGPracticeTarget 19999
{
    Radius 16
    Height 40
    Health 10000
    Mass 0x7FFFFFFF
    
    Scale 0.25
    
    +ISMONSTER
    +SHOOTABLE
    +NOGRAVITY
    +NOBLOOD
    +FORCEYBILLBOARD
    +NEVERTARGET
    -SOLID
    -COUNTKILL
    
    States
    {
    Spawn:
        TNT1 A 0 NoDelay Bright ACS_NamedExecuteAlways("MonsterInit", 0, MF_NOXP | MF_NOSTATS | MF_NOAURA | MF_NOPAYKILL | MF_NODROPS | MF_NOHEALTHBAR)
    See:
        TRGT A 1
        Loop
    Death:
        TNT1 A -1 A_SpawnItemEx("DRPGPracticeTarget", 0, 0, 0, 0, 0, 0, 0, SXF_NOCHECKPOSITION)
        Stop
    }
}

// Used by the Energy stat to tweak monsters' aggression
actor DRPGMonsterDontAttack : CustomInventory
{
    Inventory.MaxAmount 0
    +INVENTORY.AUTOACTIVATE
    States
    {
    Pickup:
        TNT1 A 0 A_ChangeFlag("JUSTHIT", false)
        TNT1 A 0 A_ChangeFlag("JUSTATTACKED", true)
        Stop
    }
}

actor DRPGMonsterAttackMore : CustomInventory
{
    Inventory.MaxAmount 0
    +INVENTORY.AUTOACTIVATE
    States
    {
    Pickup:
        TNT1 A 0 A_ChangeFlag("JUSTHIT", true)
        TNT1 A 0 A_ChangeFlag("JUSTATTACKED", false)
        Stop
    }
}

// Used to buff friendly monsters and give them the appropriate flags
actor DRPGFriendlyBooster : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_ChangeFlag("COUNTKILL", false)
        TNT1 A 0 A_ChangeFlag("ALWAYSFAST", true)
        TNT1 A 0 A_ChangeFlag("QUICKTORETALIATE", true)
        TNT1 A 0 A_ChangeFlag("MISSILEMORE", true)
        TNT1 A 0 A_ChangeFlag("NOBLOCKMONST", true)
        TNT1 A 0 A_ChangeFlag("NOTELESTOMP", true)
        TNT1 A 0 A_ChangeFlag("NOFEAR", true)
        TNT1 A 0 A_ChangeFlag("DONTDRAIN", true)
        TNT1 A 0 A_ChangeFlag("SEEINVISIBLE", true)
        TNT1 A 0 A_ChangeFlag("THRUSPECIES", true)
        Stop
    }
}

// Used to enhance the regeneration of friendly monsters (if the corresponding AUG is active)
actor DRPGSummonedRegenerationBoosterToken : Inventory {}

actor DRPGFriendlyRemover : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_ChangeFlag("COUNTKILL", true)
        TNT1 A 0 A_ChangeFlag("ALWAYSFAST", false)
        TNT1 A 0 A_ChangeFlag("QUICKTORETALIATE", false)
        TNT1 A 0 A_ChangeFlag("MISSILEMORE", false)
        TNT1 A 0 A_ChangeFlag("NOBLOCKMONST", false)
        TNT1 A 0 A_ChangeFlag("NOTELESTOMP", false)
        TNT1 A 0 A_ChangeFlag("NOFEAR", false)
        TNT1 A 0 A_ChangeFlag("DONTDRAIN", false)
        TNT1 A 0 A_ChangeFlag("SEEINVISIBLE", false)
        TNT1 A 0 A_ChangeFlag("THRUSPECIES", false)
        Stop
    }
}


// Used to change the AI of friendly monsters (and enemies in the environment)
actor DRPGMarineSummonedToken : Inventory {}

actor DRPGFriendlyAlertMonsters : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_AlertMonsters(frandom(256, 1536), AMF_TARGETEMITTER)
        TNT1 A 0 A_TakeInventory("DRPGFriendlyAlertMonsters", 0)
        Stop
    }
}

actor DRPGFriendlyClearTarget : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_Jump(256, "ForgetCheck")
    ForgetCheck:
        TNT1 A 0 A_JumpIfTargetInLOS("ForgetCancel", 0, JLOSF_DEADNOJUMP , 0)
        TNT1 A 0 A_JumpIf(GetDistance(AAPTR_TARGET) <= frandom(256, 1024), "ForgetCancel")
        TNT1 A 0 A_Jump(256, "Forget")
    Forget: 
        TNT1 A 0 A_ClearTarget
        TNT1 A 0 A_TakeInventory("DRPGFriendlyClearTarget", 0)
        Stop
    ForgetCancel: 
        TNT1 A 0 A_TakeInventory("DRPGFriendlyClearTarget", 0)
        Stop
    }
}

actor DRPGEnemyClearTarget1 : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_Jump(256, "ClassCheck")
    ClassCheck:
        TNT1 A 0 A_JumpIf(CheckClass("PlayerPawn", AAPTR_TARGET, TRUE), "ForgetCheckPlayer")
        TNT1 A 0 A_CheckFlag("FRIENDLY", "ForgetCheckFriendly", AAPTR_TARGET)
        TNT1 A 0 A_Jump(256, "ForgetCheckMonster")
    ForgetCheckPlayer:
        TNT1 A 0 A_JumpIfTargetInLOS("ForgetCancel", 0, JLOSF_DEADNOJUMP , 0)
        TNT1 A 0 A_JumpIf(GetDistance(AAPTR_TARGET) <= frandom(256, 1024), "ForgetCancel")
        TNT1 A 0 A_Jump(256, "Forget")
    ForgetCheckFriendly:     
        TNT1 A 0 A_JumpIfTargetInLOS("ForgetCancel", 0, JLOSF_DEADNOJUMP , 0)
        TNT1 A 0 A_JumpIf(GetDistance(AAPTR_TARGET) <= frandom(256, 1024), "ForgetCancel")
        TNT1 A 0 A_Jump(256, "Forget")
    ForgetCheckMonster:     
        TNT1 A 0 A_JumpIf(GetDistance(AAPTR_TARGET) <= frandom(0, 256), "ForgetCancel")
    	TNT1 A 0 {If (GetDistance(AAPTR_TARGET) <= frandom(64, 256)) {A_ChangeFlag("NOINFIGHTING", true);}}
        TNT1 A 0 A_Jump(256, "ForgetMonster")
    Forget: 
        TNT1 A 0 A_ClearTarget
        TNT1 A 0 A_TakeInventory("DRPGEnemyClearTarget1", 0)
        Stop
    ForgetMonster: 
        TNT1 A 0 A_ClearTarget
        TNT1 A 0 A_ChangeFlag("NOINFIGHTING", false)
        TNT1 A 0 A_TakeInventory("DRPGEnemyClearTarget1", 0)
        Stop
    ForgetCancel: 
        TNT1 A 0 A_TakeInventory("DRPGEnemyClearTarget1", 0)
        Stop
    }
}

actor DRPGEnemyClearTarget2 : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_Jump(256, "ClassCheck")
    ClassCheck:
        TNT1 A 0 A_JumpIf(CheckClass("PlayerPawn", AAPTR_TARGET, TRUE), "ForgetCheckPlayer")
        TNT1 A 0 A_CheckFlag("FRIENDLY", "ForgetCheckFriendly", AAPTR_TARGET)
        TNT1 A 0 A_Jump(256, "ForgetCheckMonster")
    ForgetCheckPlayer:
        TNT1 A 0 A_JumpIfTargetInLOS("ForgetCancel", 0, JLOSF_DEADNOJUMP , 0)
        TNT1 A 0 A_JumpIf(GetDistance(AAPTR_TARGET) <= 2048, "ForgetCancel")
        TNT1 A 0 A_Jump(256, "Forget")
    ForgetCheckFriendly:     
        TNT1 A 0 A_JumpIfTargetInLOS("ForgetCancel", 0, JLOSF_DEADNOJUMP , 0)
        TNT1 A 0 A_JumpIf(GetDistance(AAPTR_TARGET) <= frandom(256, 1024), "ForgetCancel")
        TNT1 A 0 A_Jump(256, "Forget")
    ForgetCheckMonster:     
        TNT1 A 0 A_JumpIf(GetDistance(AAPTR_TARGET) <= frandom(0, 256), "ForgetCancel")
    	TNT1 A 0 {If (GetDistance(AAPTR_TARGET) <= frandom(64, 256)) {A_ChangeFlag("NOINFIGHTING", true);}}
        TNT1 A 0 A_Jump(256, "ForgetMonster")
    Forget: 
        TNT1 A 0 A_ClearTarget
        TNT1 A 0 A_TakeInventory("DRPGEnemyClearTarget2", 0)
        Stop
    ForgetMonster: 
        TNT1 A 0 A_ClearTarget
        TNT1 A 0 A_ChangeFlag("NOINFIGHTING", false)
        TNT1 A 0 A_TakeInventory("DRPGEnemyClearTarget2", 0)
        Stop
    ForgetCancel: 
        TNT1 A 0 A_TakeInventory("DRPGEnemyClearTarget2", 0)
        Stop
    }
}

// Token for monsters revived by friendly Archvile
actor DRPGFriendlyReviveMonster : Inventory {}

// Red Aura Giver
actor DRPGRedAuraGiver : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_ChangeFlag("MISSILEMORE", true)
        TNT1 A 0 A_ChangeFlag("MISSILEEVENMORE", true)
        TNT1 A 0 A_ChangeFlag("NOFEAR", true)
        Stop
    }
}

actor DRPGRedAuraRemover : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_ChangeFlag("MISSILEMORE", false)
        TNT1 A 0 A_ChangeFlag("MISSILEEVENMORE", false)
        TNT1 A 0 A_ChangeFlag("NOFEAR", false)
        Stop
    }
}

// Green Aura Giver
actor DRPGGreenAuraGiver : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_ChangeFlag("REFLECTIVE", true)
        TNT1 A 0 A_ChangeFlag("SHIELDREFLECT", true)
        TNT1 A 0 A_ChangeFlag("NOPAIN", true)
        TNT1 A 0 A_ChangeFlag("NORADIUSDMG", true)
        TNT1 A 0 A_ChangeFlag("DONTBLAST", true)
        TNT1 A 0 A_ChangeFlag("DONTRIP", true)
        Stop
    }
}

actor DRPGGreenAuraRemover : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_ChangeFlag("REFLECTIVE", false)
        TNT1 A 0 A_ChangeFlag("SHIELDREFLECT", false)
        TNT1 A 0 A_ChangeFlag("NOPAIN", false)
        TNT1 A 0 A_ChangeFlag("NORADIUSDMG", false)
        TNT1 A 0 A_ChangeFlag("DONTBLAST", false)
        TNT1 A 0 A_ChangeFlag("DONTRIP", false)
        Stop
    }
}

// White Aura Giver
actor DRPGWhiteAuraGiver : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_ChangeFlag("LOOKALLAROUND", true)
        TNT1 A 0 A_ChangeFlag("NOTARGETSWITCH", true)
        TNT1 A 0 A_ChangeFlag("NOTARGET", true)
        TNT1 A 0 A_ChangeFlag("NOINFIGHTING", true)
        TNT1 A 0 A_ChangeFlag("BRIGHT", true)
        Stop
    }
}

actor DRPGWhiteAuraRemover : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_ChangeFlag("LOOKALLAROUND", false)
        TNT1 A 0 A_ChangeFlag("NOTARGETSWITCH", false)
        TNT1 A 0 A_ChangeFlag("NOTARGET", false)
        TNT1 A 0 A_ChangeFlag("NOINFIGHTING", false)
        TNT1 A 0 A_ChangeFlag("BRIGHT", false)
        Stop
    }
}

// Pink Aura Giver
actor DRPGPinkAuraGiver : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_ChangeFlag("DONTDRAIN", true)
        Stop
    }
}

actor DRPGPinkAuraRemover : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_ChangeFlag("DONTDRAIN", false)
        Stop
    }
}

// Blue Aura Giver
actor DRPGBlueAuraGiver : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_ChangeFlag("NOTIMEFREEZE", true)
        TNT1 A 0 A_ChangeFlag("SEEINVISIBLE", true)
        Stop
    }
}

actor DRPGBlueAuraRemover : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_ChangeFlag("NOTIMEFREEZE", false)
        TNT1 A 0 A_ChangeFlag("SEEINVISIBLE", false)
        Stop
    }
}

// Orange Aura Giver
actor DRPGOrangeAuraGiver : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_ChangeFlag("ALWAYSFAST", true)
        TNT1 A 0 A_ChangeFlag("QUICKTORETALIATE", true)
        TNT1 A 0 A_ChangeFlag("JUMPDOWN", true)
        TNT1 A 0 A_ChangeFlag("NOTELESTOMP", true)
        Stop
    }
}

actor DRPGOrangeAuraRemover : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_ChangeFlag("ALWAYSFAST", false)
        TNT1 A 0 A_ChangeFlag("QUICKTORETALIATE", false)
        TNT1 A 0 A_ChangeFlag("JUMPDOWN", false)
        TNT1 A 0 A_ChangeFlag("NOTELESTOMP", false)
        Stop
    }
}

// Level-up Monsters, used with White Aura
actor DRPGMonsterLevelupGiver : CustomInventory
{
    States
    {
    Pickup:
        TNT1 A 0 A_RadiusGive("DRPGMonsterLevelup", radius + 512, RGF_GIVESELF | RGF_MONSTERS | RGF_CUBE)
        Stop
    }
}

// Resurrect Monsters, used with Pink Aura
actor DRPGMonsterRadiusResurrection : CustomInventory
{
    Inventory.MaxAmount 0
    +INVENTORY.AUTOACTIVATE
    States
    {
    Pickup:
        TNT1 A 0 A_RadiusGive("DRPGMonsterResurrect", radius + 128, RGF_MONSTERS | RGF_CORPSES | RGF_CUBE)
        Stop
    }
}

actor DRPGMonsterResurrect : CustomInventory
{
    Inventory.MaxAmount 0
    +INVENTORY.AUTOACTIVATE
    States
    {
    Pickup:
        TNT1 A 0 Thing_Raise(0)
        Stop
    }
}

// Heal Monsters, used with Purple Aura
actor DRPGMonsterRadiusHealer : CustomInventory
{
    Inventory.MaxAmount 0
    +INVENTORY.AUTOACTIVATE
    States
    {
    Pickup:
        TNT1 A 0 A_RadiusGive("DRPGMonsterHeal", radius + 512, RGF_MONSTERS | RGF_CUBE)
        Stop
    }
}

actor DRPGMonsterHeal : CustomInventory
{
    Inventory.MaxAmount 0
    +INVENTORY.AUTOACTIVATE
    States
    {
    Pickup:
        TNT1 A 0 ACS_NamedExecuteWithResult("MonsterRegenHealer")
        Stop
    }
}

actor DRPGMonsterHealEffect : CustomInventory
{
    States
    {
    Pickup:
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx ("DRPGMonsterHealParticle", 0, 0, Height / 2, FRandom (0, 4), 0, FRandom (-2, 2), FRandom (0, 360))
        Stop
    }
}

// Protection from Radiation Damage
actor DRPGMonsterRadiationProtection : PowerProtection
{
    DamageFactor "Radiation", 0
    
    +INVENTORY.AUTOACTIVATE
    
    Powerup.Duration -0x7FFFFFFF
}

actor DRPGMonsterRadSuit : Inventory
{
    Inventory.MaxAmount 1
}

// Special burned corpse
ACTOR DRPGBurnedCorpse
{
    +DROPOFF
    +CORPSE
    +NOTELEPORT
    +DONTGIB
    RenderStyle "Stencil"
    StencilColor "Black"
    States
    {
    Spawn:
        Goto Corpse
    Corpse:
        POL5 A 128
        POL5 A 0 Bright A_SetScale(0.95)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.90)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.85)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.80)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.75)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.70)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.65)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.60)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.55)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.50)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.45)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.40)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.35)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.30)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.25)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.20)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.15)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.10)
        POL5 A 2 bright A_FadeOut(0.05)
        POL5 A 0 Bright A_SetScale(0.05)
        POL5 A 2 bright A_FadeOut(0.05)
        TNT1 A 0 A_Jump(256, "FadeOut")
    FadeOut:
        POL5 A 2 A_FadeOut(0.05)
        Loop
    }
}