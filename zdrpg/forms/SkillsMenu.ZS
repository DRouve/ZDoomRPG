/*
 * SimpleMenu.ZS:
 * This example shows how to make a simple menu with a background, a text label,
 * and a single-texture button.
 * Clicking the button changes the colour of the text label's text to a random
 * colour.
*/

// The menu's command handler.
// This is needed so we can make our menu interactable.
class ZDRPG_ZF_SkillsMenuHandler : ZDRPG_ZF_Handler
{
    // The menu this command handler belongs to.
    // We need this to be able to do anything with our menu.
    ZDRPG_ZF_SkillsMenu link;
    ZDRPGPlayerHandler playerHandler; 

    override void buttonClickCommand (ZDRPG_ZF_Button caller, Name command)
    {
        string commandString = command;
        if(commandString.IndexOf("useSkill") >= 0) 
        {
            link.mParentMenu.Close();
            playerHandler.SendNetworkEvent(command);
        }

        if(commandString.IndexOf("filterSkills") >= 0) 
        {
            let skillsFrame = ZDRPG_ZF_Frame(link.mainFrame.elements[2]);
            // remove all skills
            for(int i = 0; i < skillsFrame.elements.Size(); i++)
                if(skillsFrame.elements[i])
                    skillsFrame.elements[i].destroy();

            let staticHandler = ZDRPGStaticHandler(StaticEventHandler.Find("ZDRPGStaticHandler"));

            Array <String> paramSplit;
            commandString.split(paramSplit, ":");

            link.listItems(staticHandler.skills, link.baseRes, skillsFrame, paramSplit[1]);
        }
    }
}

class ZDRPG_ZF_SkillsMenu : ZDRPG_ZF_GenericMenu
{
    // The menu's command handler.
    // We need a command handler so we can make our menu interactable.
    ZDRPG_ZF_SkillsMenuHandler handler;

    // A font to use for text.
    Font smallFont;

    // A background image.
    ZDRPG_ZF_Image background;
    // A simple single-texture button.
    ZDRPG_ZF_Button aButton;
    // A text label.
    ZDRPG_ZF_Label aLabel;

    Vector2 baseRes;

    override void Init (Menu parent)
    {
        baseRes = (1920, 1080);

        // Call GenericMenu's 'Init' function to do some required initialization.
        Super.Init (parent);
        //menuactive = Menu.On;
        // Set our base resolution to 320x200.
        SetBaseResolution (baseRes);

        // Get GZDoom's new options menu smallfont.
        smallFont = OptionFont ();

        // Create an instance of the handler.
        handler = new ('ZDRPG_ZF_SkillsMenuHandler');
        // Set the handler's "link" pointer to us.
        handler.link = self;

        // Add a background.
        /*background = ZDRPG_ZF_Image.Create
        (
            // Position
            (0, 0),
            // Size
            (1920, 1080),
            // Image path/name
            "graphics/ZFormsExamples/Panel.png",
            // Alignment options
            ZDRPG_ZF_Image.AlignType_TopLeft
        );
        // Add the image element into the main frame.
        background.Pack (mainFrame);*/

        // Create the box image's textures.

        /*array< class<ZDRPGSkill> > Skills;
        BuildSkillItemList(Skills);
        for (int i=0; i<Skills.size(); i++) {
            let Skill = ZDRPGSkill(Skills[i]);
            console.printf("skill+: %s", Skill.getClassname());
        }*/

        createDescriptionBox(baseRes);

        array <int> blocksCount;
        array <int> rowsCount;

        array <int> skillsCount;
        array <int> categoriesCount;

        let staticHandler = ZDRPGStaticHandler(StaticEventHandler.Find("ZDRPGStaticHandler"));

        let categoriesFrame = ZDRPG_ZF_Frame.create(
                (0, 0),
                baseRes
            );
        categoriesFrame.setDontBlockMouse(true);
        categoriesFrame.pack(mainFrame); // index: 1

        // add "All" category
        CreateCategoryBox("All", "filterSkills:", baseRes, categoriesCount, Font.CR_WHITE, categoriesFrame);

        for(int i = 0; i < staticHandler.skillCategories.Size(); i++)
        {
            let skillCategory = GetDefaultByType( (class<ZDRPGSkill>) (staticHandler.skillCategories[i]) );
            CreateCategoryBox(skillCategory.GetTag(), "filterSkills:"..skillCategory.GetClassName(), baseRes, categoriesCount, skillCategory.FontColor, categoriesFrame);
        }

        if(staticHandler.skills.Size() > 0)
        {
            let skillsFrame = ZDRPG_ZF_Frame.create(
                (0, 0),
                baseRes
            );
            skillsFrame.setDontBlockMouse(true);
            skillsFrame.pack(mainFrame); // index: 2

            listItems(staticHandler.skills, baseRes, skillsFrame);
        }
    }

    void listItems(array <string> itemsArray, Vector2 baseRes, ZDRPG_ZF_Frame frame, string filter = "")
    {
        array <int> blocksCount;
        array <int> rowsCount;

        for(int i=0; i < itemsArray.Size(); i++)
        {
            let itemDefaults = GetDefaultByType((class<Actor>)(itemsArray[i]));
            let skill = ZDRPGSkill(itemDefaults);

            if(filter && skill.GetParentClass().GetClassName() != filter) 
                continue;

            let itemSprite = skill.Icon;
            //console.printf(itemSprite);
            string cmd = "showDescription:"..itemsArray[i];
            
            CreateStatBox("", cmd, itemSprite, baseRes, blocksCount, rowsCount, frame);
        }
    }

    void createDescriptionBox(Vector2 baseRes)
    {
        int descriptionFrameOffset = 75;

        let descriptionFrame = ZDRPG_ZF_Frame.create(
            (descriptionFrameOffset, baseRes.y - (baseRes.y * 0.5)),
            (baseRes.x - 2*descriptionFrameOffset, baseRes.y - (baseRes.y * 0.5) - 100)
        );
        descriptionFrame.pack(mainFrame); // index: 0

        let boxTexture = ZDRPG_ZF_BoxTextures.CreateTexturePixels
        (
            // The texture itself.
            "graphics/ZFormsExamples/BoxTextureGreen.png",
            // The top-left corner of the middle of the box.
            (32, 32),
            // The bottom-right corner of the middle of the box.
            (64, 64),
            // Whether to scale (true) or tile (false) the sides.
            false,
            // Whether to scale (true) or tile (false) the middle.
            false
        );

        let aBoxImage = ZDRPG_ZF_BoxImage.Create
        (
            // Position
            
            //((baseRes.X - boxSize.X) / testDouble, (baseRes.Y - boxSize.Y) / testDouble),
            (0, 0),
            // Size
            descriptionFrame.getSize(),
            // Texture
            boxTexture,
            // Scale
            (0.25, 0.25)
        );

        aBoxImage.pack(descriptionFrame); // index: 0

        let descriptionFrameSize = descriptionFrame.getSize();

        // Add a label.
        let selectSkillLabel = ZDRPG_ZF_Label.Create
        (
            // Position
            (descriptionFrameSize.x * 0.5 - 50, descriptionFrameSize.y * 0.5 - smallFont.GetHeight()),
            // Size.
            (0, smallFont.GetHeight ()),
            // The label's text
            text: "Select skill",
            // The font to use
            fnt: smallFont,
            // Whether to automatically wrap the text or not
            wrap: false,
            // Whether to automatically resize the element based on the text width
            autoSize: true,
            // The text's colour
            textColor: Font.CR_WHITE
        );

        selectSkillLabel.pack(descriptionFrame); // index: 1

        let skillInfoBox = CreateSkillInfoBox(descriptionFrame);
        //let shieldRewardBox = CreateMissionRewardBox(descriptionFrame, missionInfoBox);

        skillInfoBox.setDontBlockMouse(true);
        //missionRewardBox.setDontBlockMouse(true);

        skillInfoBox.hide();
        //missionRewardBox.hide();

        let useSkillButton = ZDRPG_ZF_Button.Create
        (
            // Position
            //((baseRes.X - 18.) / 2, (baseRes.Y - 18.) / 2),
            (descriptionFrameSize.x * 0.5 - 172, descriptionFrameSize.y * 0.75),
            // Size
            (345, 50),
            // Our command handler
            text: "Use",
            cmdHandler: handler,
            // A command string for the button
            command: 'equipShield:0',
            fnt: bigFont,
            textScale: 2,
            textColor: Font.CR_GREEN
        );

        // Add the button element into the main frame.
        useSkillButton.Pack (descriptionFrame); // index: 3

        useSkillButton.hide();

        /*let abortMissionButton = ZDRPG_ZF_Button.Create
        (
            // Position
            //((baseRes.X - 18.) / 2, (baseRes.Y - 18.) / 2),
            (descriptionFrameSize.x * 0.5 - 275, addMissionButton.GetPosY() + bigFont.GetHeight() * 3),
            // Size
            (550, 50),
            // Our command handler
            text: "Abort current mission",
            cmdHandler: handler,
            // A command string for the button
            command: 'abortMission',
            fnt: bigFont,
            textScale: 2,
            textColor: Font.CR_RED
        );

        // Add the button element into the main frame.
        abortMissionButton.Pack (descriptionFrame); // index: 5

        abortMissionButton.hide();*/   
    }

    ZDRPG_ZF_Frame CreateSkillInfoBox(ZDRPG_ZF_Frame descriptionFrame)
    {
        int descriptionFrameOffset = 75;
        let descriptionFrameSize = descriptionFrame.getSize();

        let skillInfoFrame = ZDRPG_ZF_Frame.create(
            (40, 40),
            (descriptionFrameSize.x - (descriptionFrameSize.x * 0.5) - 60, descriptionFrameSize.y - descriptionFrameOffset - 40)
        );
        skillInfoFrame.pack(descriptionFrame); // index: 2

        let skillInfoBoxTexture = ZDRPG_ZF_BoxTextures.CreateTexturePixels
        (
            // The texture itself.
            "graphics/ZFormsExamples/BoxTextureBlue.png",
            // The top-left corner of the middle of the box.
            (32, 32),
            // The bottom-right corner of the middle of the box.
            (64, 64),
            // Whether to scale (true) or tile (false) the sides.
            false,
            // Whether to scale (true) or tile (false) the middle.
            false
        );

        let shieldInfoBox = ZDRPG_ZF_BoxImage.Create
        (
            // Position
            
            //((baseRes.X - boxSize.X) / testDouble, (baseRes.Y - boxSize.Y) / testDouble),
            (0, 0),
            // Size
            skillInfoFrame.getSize(),
            // Texture
            skillInfoBoxTexture,
            // Scale
            (0.25, 0.25)
        );

        //missionInfoBox.pack(missionInfoFrame); // index: 0

        let listFrame = ZDRPG_ZF_ListFrame.Create
        (
            (75, 75),
            (200, 200),
            smallFont.GetHeight() * 2
        );

        listFrame.pack(skillInfoFrame); // index: 0

        // Add a label.
        let skillName = ZDRPG_ZF_Label.Create
        (
            // Position
            (0, 0),
            // Size.
            (0, smallFont.GetHeight ()),
            // The label's text
            text: "",
            // The font to use
            fnt: smallFont,
            // Whether to automatically wrap the text or not
            wrap: false,
            // Whether to automatically resize the element based on the text width
            autoSize: true,
            // The text's colour
            textColor: Font.CR_WHITE
        );

        skillName.pack(listFrame); // index: 0

        // Add a label.
        let shieldCapacity = ZDRPG_ZF_Label.Create
        (
            // Position
            (0, 0), 
            // Size.
            (0, smallFont.GetHeight ()),
            // The label's text
            text: "",
            // The font to use
            fnt: smallFont,
            // Whether to automatically wrap the text or not
            wrap: false,
            // Whether to automatically resize the element based on the text width
            autoSize: true,
            // The text's colour
            textColor: Font.CR_WHITE
        );

        shieldCapacity.pack(listFrame); // index: 1

        // Add a label.
        let shieldChargeRate = ZDRPG_ZF_Label.Create
        (
            // Position
            (0,0), 
            // Size.
            (0, smallFont.GetHeight ()),
            // The label's text
            text: "",
            // The font to use
            fnt: smallFont,
            // Whether to automatically wrap the text or not
            wrap: false,
            // Whether to automatically resize the element based on the text width
            autoSize: true,
            // The text's colour
            textColor: Font.CR_WHITE
        );

        shieldChargeRate.pack(listFrame); // index: 2

        // Add a label.
        let shieldDelay = ZDRPG_ZF_Label.Create
        (
            // Position
            (0,0), 
            // Size.
            (0, smallFont.GetHeight ()),
            // The label's text
            text: "",
            // The font to use
            fnt: smallFont,
            // Whether to automatically wrap the text or not
            wrap: false,
            // Whether to automatically resize the element based on the text width
            autoSize: true,
            // The text's colour
            textColor: Font.CR_WHITE
        );

        shieldDelay.pack(listFrame); // index: 3
        //missionTarget.hide();

        return skillInfoFrame;
    }

    /*void CreateStatBox(string labelText, string commandName, Vector2 baseRes, out array <int> blocksCount) 
    {
        let boxTexture = ZDRPG_ZF_BoxTextures.CreateTexturePixels
        (
            // The texture itself.
            "graphics/ZFormsExamples/BoxTextureBlue.png",
            // The top-left corner of the middle of the box.
            (32, 32),
            // The bottom-right corner of the middle of the box.
            (64, 64),
            // Whether to scale (true) or tile (false) the sides.
            false,
            // Whether to scale (true) or tile (false) the middle.
            false
        );
        
        let offsetY = 75;
        // Add a box image.
        let boxSize = (128, 128);
        let boxOffset = offsetY + boxSize.X * blocksCount.Size();
        let boxInnerOffset = blocksCount.Size() * 32;

        let aBoxImage = ZDRPG_ZF_BoxImage.Create
        (
            // Position
            
            //((baseRes.X - boxSize.X) / testDouble, (baseRes.Y - boxSize.Y) / testDouble),
            (boxOffset + boxInnerOffset, offsetY),
            // Size
            boxSize,
            // Texture
            boxTexture,
            // Scale
            (0.25, 0.25)
        );
        // Add the box image element into the main frame.
        aBoxImage.Pack (mainFrame);

        // Create the button's textures.
        let buttonIdle = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonIdle.png", true);
        let buttonHover = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonHovered.png", false);
        let buttonClick = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonClicked.png", false);

        let buttonSideSize = 18;
        let buttonPosX = boxOffset + boxInnerOffset + aBoxImage.GetWidth() / 2 - buttonSideSize / 2;
        let buttonPosY = offsetY + aBoxImage.GetHeight() / 2 - buttonSideSize / 2;

        // Add a button.
        aButton = ZDRPG_ZF_Button.Create
        (
            // Position
            //((baseRes.X - 18.) / 2, (baseRes.Y - 18.) / 2),
            (buttonPosX, buttonPosY),
            // Size
            (buttonSideSize, buttonSideSize),
            // Our command handler
            cmdHandler: handler,
            // A command string for the button
            command: commandName,
            // The button's textures
            inactive: buttonIdle,
            hover: buttonHover,
            click: buttonClick
        );
        // Add the button element into the main frame.
        aButton.Pack (mainFrame);

        // Add a label.
        aLabel = ZDRPG_ZF_Label.Create
        (
            // Position
            (0, aButton.GetPosY () + aButton.GetHeight () + 4),
            // Size.
            (0, smallFont.GetHeight ()),
            // The label's text
            text: labelText,
            // The font to use
            fnt: smallFont,
            // Whether to automatically wrap the text or not
            wrap: false,
            // Whether to automatically resize the element based on the text width
            autoSize: true,
            // The text's colour
            textColor: Font.CR_WHITE
        );
        // Calculate the horizontal position for the label so that it's centered on the screen.
        aLabel.SetPosX (aButton.GetPosX () - smallFont.stringWidth (aLabel.GetText ()));
        // Add the label element to the main frame.
        aLabel.Pack (mainFrame);

        blocksCount.Push(1);
    }*/

    void CreateStatBox(string labelText, string commandName, string img, Vector2 baseRes, out array <int> blocksCount, out array <int> rowsCount, ZDRPG_ZF_Frame frame) 
    {
        
        let boxTexture = ZDRPG_ZF_BoxTextures.CreateTexturePixels
        (
            // The texture itself.
            "graphics/ZFormsExamples/BoxTextureGreen.png",
            // The top-left corner of the middle of the box.
            (32, 32),
            // The bottom-right corner of the middle of the box.
            (64, 64),
            // Whether to scale (true) or tile (false) the sides.
            false,
            // Whether to scale (true) or tile (false) the middle.
            false
        );

        let offsetY = 75;
        // Add a box image.
        let boxSize = (72, 72);
        if((50 + boxSize.X) * blocksCount.Size() > baseRes.X - 300)
        {
            blocksCount.Clear();
            rowsCount.Push(1);
        }
        let boxOffset = 335 + boxSize.X * blocksCount.Size();
        let boxInnerOffset = blocksCount.Size() * 32;

        let buttonFrame = ZDRPG_ZF_Frame.create(
            (boxOffset + boxInnerOffset, offsetY + (rowsCount.Size() * (boxSize.X + 32))),
            boxSize
        );

        buttonFrame.pack(frame);

        background = ZDRPG_ZF_Image.Create
        (
            // Position
            (0, 0),
            // Size
            boxSize,
            // Image path/name
            "graphics/skills/"..img,
            // Alignment options
            ZDRPG_ZF_Image.AlignType_TopLeft,
            (1, 1)
        );
        // Add the image element into the main frame.
        background.Pack (buttonFrame);

        /*let aBoxImage = ZDRPG_ZF_BoxImage.Create
        (
            // Position
            
            //((baseRes.X - boxSize.X) / testDouble, (baseRes.Y - boxSize.Y) / testDouble),
            (0, 0),
            // Size
            boxSize,
            // Texture
            boxTexture,
            // Scale
            (0.25, 0.25)
        );
        // Add the box image element into the main frame.
        aBoxImage.Pack (buttonFrame);*/

        // Create the button's textures.

        let buttonSideSize = 96;
        let buttonPosX = boxOffset + boxInnerOffset + background.GetWidth() / 2 - buttonSideSize / 2;
        let buttonPosY = offsetY + (rowsCount.Size() * (boxSize.X + 32)) + background.GetHeight() / 2 - buttonSideSize / 2;

        // Add a button.
        aButton = ZDRPG_ZF_Button.Create
        (
            // Position
            //((baseRes.X - 18.) / 2, (baseRes.Y - 18.) / 2),
            (0, 0),
            // Size
            (buttonSideSize, buttonSideSize),
            // Our command handler
            cmdHandler: handler,
            // A command string for the button
            command: commandName
            // The button's textures
            //inactive: buttonIdle,
            //hover: buttonHover,
            //click: buttonClick
        );
        // Add the button element into the main frame.
        aButton.Pack (buttonFrame);

        // Add a label.
        aLabel = ZDRPG_ZF_Label.Create
        (
            // Position
            (0, 0),
            // Size.
            (0, smallFont.GetHeight ()),
            // The label's text
            text: labelText,
            // The font to use
            fnt: smallFont,
            // Whether to automatically wrap the text or not
            wrap: false,
            // Whether to automatically resize the element based on the text width
            autoSize: true,
            // The text's colour
            textColor: Font.CR_WHITE
        );
        // Calculate the horizontal position for the label so that it's centered on the screen.
        aLabel.SetPosX (aButton.GetPosX () - smallFont.stringWidth (aLabel.GetText ()));
        // Add the label element to the main frame.
        aLabel.Pack (buttonFrame);

        blocksCount.Push(1);
    }

    override void handleBack() {
		super.handleBack();
        menuactive = Menu.OnNoPause;
	}

    void CreateCategoryBox(string labelText, string commandName, Vector2 baseRes, out array <int> blocksCount, int fontColor, ZDRPG_ZF_Frame frame) 
    {
        let boxTexture = ZDRPG_ZF_BoxTextures.CreateTexturePixels
        (
            // The texture itself.
            "",
            // The top-left corner of the middle of the box.
            (32, 32),
            // The bottom-right corner of the middle of the box.
            (64, 64),
            // Whether to scale (true) or tile (false) the sides.
            false,
            // Whether to scale (true) or tile (false) the middle.
            false
        );
        
        let offsetX = 75;
        // Add a box image.
        let boxSize = (200, 35);
        let boxOffset = offsetX + boxSize.X / 4 * blocksCount.Size();
        let boxInnerOffset = blocksCount.Size() * 10;

        let aBoxImage = ZDRPG_ZF_BoxImage.Create
        (
            // Position
            
            (offsetX, boxOffset + boxInnerOffset),
            // Size
            boxSize,
            // Texture
            boxTexture,
            // Scale
            (0.25, 0.25)
        );
        // Add the box image element into the main frame.
        aBoxImage.Pack (frame);

        // Create the button's textures.
        let buttonIdle = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonIdle.png", true);
        let buttonHover = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonHovered.png", false);
        let buttonClick = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonClicked.png", false);

        let buttonSideSize = 18;
        let buttonPosX = offsetX + aBoxImage.GetWidth() / 2 - buttonSideSize / 2;
        let buttonPosY = boxOffset + boxInnerOffset + aBoxImage.GetHeight() / 2 - buttonSideSize / 2;
        

        // Add a button.
        aButton = ZDRPG_ZF_Button.Create
        (
            // Position
            //((baseRes.X - 18.) / 2, (baseRes.Y - 18.) / 2),
            (offsetX, boxOffset + boxInnerOffset),
            // Size
            boxSize,
            text: labelText,
            // Our command handler
            cmdHandler: handler,
            // A command string for the button
            command: commandName,
            // The button's textures
            //inactive: buttonIdle,
            //hover: buttonHover,
            //click: buttonClick,
            fnt: bigFont,
            textScale: 2,
            textColor: fontColor,
            alignment: ZDRPG_ZF_Button.AlignType_CenterLeft 
        );
        // Add the button element into the main frame.
        aButton.Pack (frame);

        // Add a label.
        /*aLabel = ZDRPG_ZF_Label.Create
        (
            // Position
            (offsetX, aButton.GetPosY() - 4),
            // Size.
            (0, bigFont.GetHeight ()),
            // The label's text
            text: labelText,
            // The font to use
            fnt: bigFont,
            
            // Whether to automatically wrap the text or not
            wrap: false,
            // Whether to automatically resize the element based on the text width
            autoSize: true,
            textScale: 2,
            // The text's colour
            textColor: fontColor
        );
        // Calculate the horizontal position for the label so that it's centered on the screen.
        //aLabel.SetPosX (offsetX);
        // Add the label element to the main frame.
        aLabel.Pack (mainFrame);*/

        blocksCount.Push(1);
    }
}
