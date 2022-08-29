class ZDRPGStaticHandler : StaticEventHandler 
{
    array <string> mapPacks;
    array <string> skillCategories;

    override void OnRegister ()
    {
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

        for (int i=0; i<allactorclasses.size(); i++) {
            if (allactorclasses[i] is 'ZDRPGSkill' && allactorclasses[i].getClassName() != 'ZDRPGSkill')
            {
                let skill = GetDefaultByType( (class<ZDRPGSkill>) (allactorclasses[i]) );
                if(!(skillCategories.Find(skill.SkillCategory..':'..skill.FontColor) != skillCategories.Size()))
                {
                    skillCategories.Push(skill.SkillCategory..':'..skill.FontColor);
                }
            }
        }
    }
}