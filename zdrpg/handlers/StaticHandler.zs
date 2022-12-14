class ZDRPGStaticHandler : StaticEventHandler 
{
    const MAX_LEVEL        = 100;
    const MAX_MISSIONS     = 30;
    const MODULE_STAT_MULT = 25;
    
    int XPCurve;
    array <int> XPTable;

    array <string> mapPacks;
    array <string> skills;
    array <string> skillCategories;
    array <string> monsters;
    array <string> replacements;

    array <string> questItems;
    array <string> shieldBodies;
    array <string> shieldBatteries;
    array <string> shieldCapacitors;
    array <string> shieldAccessories;

    array <string> missionDifficulties;
    array <string> missionTypes;

    override void OnRegister ()
    {
        XPCurve = CVar.GetCVar("drpg_xp_curve").GetInt();
        XPTable.Push(475 + XPCurve);
        for (int i = 1; i < MAX_LEVEL; i++)
        {
            int XPAmount = ((((XPTable[i - 1] * (1.0 + i / (i * 8.0))) + ((i * XPCurve) * (1.0 + i / (101.0 - i))))) + 50) / 100;
            XPTable.Push(XPAmount * 100);
            //console.printf("%d", XPTable[i]);
        }
                
        // replacements
        replacements.PushV(
            "HealthBonus:ZDRPGHealthBonusReplacer",
            "Stimpack:ZDRPGStimpackRandomizer",
            "Medikit:ZDRPGMedikitRandomizer",
            "Soulsphere:ZDRPGSoulSphereRandomizer",

            "ArmorBonus:ZDRPGArmorBonusReplacer",
            "GreenArmor:ZDRPGGreenArmorRandomizer",
            "BlueArmor:ZDRPGBlueArmorRandomizer",

            "InvulnerabilitySphere:ZDRPGInvulnerabilitySphereRandomizer",
            "BlurSphere:ZDRPGBlurSphereRandomizer",
            
            "Backpack:ZDRPGBackpackRandomizer"            
        );

        // missions categories and types
        missionDifficulties.PushV(
            "Very Easy",
            "Easy",
            "Normal",
            "Hard",
            "Very Hard",
            "Nightmare",
            "Insane",
            "Impossible",
            "Suicide"
        );

        missionTypes.PushV(
            "Collection",
            "Kill",
            "Kill Auras",
            "Kill Reinforcements",
            "Assassination",
            "Find Secrets",
            "Find Items",
            "Achieve Combo"
        );

        // mappacks and maps array
        int levelsCount = LevelInfo.GetLevelInfoCount();
        for(int i=0; i<levelsCount; i++)
        {
            let level = LevelInfo.GetLevelInfo(i);
            if(level.MapExists(level.MapName))
            {
                string mapName = level.MapName.Left(level.MapName.length()-2);
                string mapPackName = Stringtable.Localize("$C_"..mapName);

                if(i > 0)
                {
                    let prevLevel = LevelInfo.GetLevelInfo(i-1);
                    string prevMapName = prevLevel.MapName.Left(prevLevel.MapName.length()-2);
                    string prevMapPackName = Stringtable.Localize("$C_"..prevMapName);

                    if(prevMapPackName == mapPackName || level.LookupLevelName() == "UAC Outpost")
                    {
                        mapPacks[mapPacks.Size()-1].AppendFormat("%s", "::"..level.MapName);
                        continue;
                    }     
                }
                mapPacks.Push(mapPackName .. "##" .. level.MapName);
            }
        }

        // skill categories (deprecated?)
        /*for (int i=0; i<allactorclasses.size(); i++) {
            if (allactorclasses[i] is 'ZDRPGSkill' && allactorclasses[i].getClassName() != 'ZDRPGSkill')
            {
                let skill = GetDefaultByType( (class<ZDRPGSkill>) (allactorclasses[i]) );
                if(!(skillCategories.Find(skill.SkillCategory..':'..skill.FontColor) != skillCategories.Size()))
                {
                    skillCategories.Push(skill.SkillCategory..':'..skill.FontColor);
                }
            }
        }*/
    }

    override void WorldTick()
    {
        if((GameTic % 35) == 0 && !monsters.Size())
        {
            prepareActorArrays();
        }
    }

    void prepareActorArrays()
    {
        // Doom-only monsters (+ monsterpacks)
        array <string> excludeActors;

        excludeActors.PushV(
            "ArmoredFlemoidusBipedicus",
            "BetaSkull",
            "ChexSoul",
            "CommanderKeen",
            "Flembrane",
            "FlemoidusCommonus",
            "FlemoidusBipedicus",
            "FlemoidusCycloptisCommonus",
            "MBFHelperDog",
            "WolfensteinSS"
        );
        
        for (int i=0; i<allactorclasses.size(); i++) {
            if(allactorclasses[i] is "ZDRPGLoot" && allactorclasses[i].GetClassName() != 'ZDRPGLoot')
            {
                questItems.Push(allactorclasses[i].GetClassName());
                continue;
            }    

            if(allactorclasses[i] is "ZDRPGShieldBody" && allactorclasses[i].GetClassName() != 'ZDRPGShieldBody')
            {
                shieldBodies.Push(allactorclasses[i].GetClassName());
                continue;
            }    
            if(allactorclasses[i] is "ZDRPGShieldBattery" && allactorclasses[i].GetClassName() != 'ZDRPGShieldBattery')
            {
                shieldBatteries.Push(allactorclasses[i].GetClassName());
                continue;
            }   
            if(allactorclasses[i] is "ZDRPGShieldCapacitor" && allactorclasses[i].GetClassName() != 'ZDRPGShieldCapacitor')
            {
                shieldCapacitors.Push(allactorclasses[i].GetClassName());
                continue;
            }  
            if(allactorclasses[i] is "ZDRPGShieldAccessory" && allactorclasses[i].GetClassName() != 'ZDRPGShieldAccessory')
            {
                shieldAccessories.Push(allactorclasses[i].GetClassName());
                continue;
            } 

            if(allactorclasses[i] is 'ZDRPGSkill')
            {
                if(allactorclasses[i].GetParentClass() == 'ZDRPGSkill')
                {
                    //let skill = GetDefaultByType( (class<ZDRPGSkill>) (allactorclasses[i]) );
                    //skillCategories.Push(skill.GetTag()..':'..skill.FontColor);
                    skillCategories.Push(allactorclasses[i].GetClassName());
                }
                else if(allactorclasses[i].GetClassName() != 'ZDRPGSkill')
                {
                    skills.Push(allactorclasses[i].GetClassName());
                }
            }

            let def = GetDefaultByType(allActorClasses[i]);
            if (def.bIsMonster 
            && !def.bFriendly                                                                  // ignore friendlies
            && !def.bDontHarmSpecies                                                           // ignore "splash-damage immunity to same species" enemies (DoomRPG angry marines)
            && !def.bNoDamage                                                                  // ignore undamageable enemies
            && !def.bInvulnerable                                                              // ignore invulnerable enemies
            && !def.bStealth                                                                   // ignore stealth enemies 
            && !def.bSpectral                                                                  // ignore spectral enemies - Strife
            && !def.bTeleStomp                                                                 // ignore telestomp enemies - Hexen, Heretic
            && def.bCountKill                                                                  // only kill countable
            && def.spawnState.ValidateSpriteFrame()                                            // only enemies with existing sprite frames, defined in doom2.wad
            && excludeActors.Find(allActorClasses[i].GetClassName()) == excludeActors.Size())  // exclude custom classes (mostly Chex enemies, Doom special enemies)  
                monsters.Push(allActorClasses[i].GetClassName());
        }
    }
}