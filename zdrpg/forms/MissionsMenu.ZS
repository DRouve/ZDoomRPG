/*
 * SimpleMenu.ZS:
 * This example shows how to make a simple menu with a background, a text label,
 * and a single-texture button.
 * Clicking the button changes the colour of the text label's text to a random
 * colour.
*/

// The menu's command handler.
// This is needed so we can make our menu interactable.
class ZDRPG_ZF_MissionsMenuHandler : ZDRPG_ZF_Handler
{
    // The menu this command handler belongs to.
    // We need this to be able to do anything with our menu.
    ZDRPG_ZF_MissionsMenu link;
    ZDRPGPlayerHandler playerHandler; 

    override void buttonClickCommand (ZDRPG_ZF_Button caller, Name command)
    {
        string commandString = command;
        Array <String> commandSplit;
        commandString.split(commandSplit, ":");
        if(commandSplit[0] ~== "addMission" && commandSplit.Size() > 1)
        {
            playerHandler.SendNetworkEvent(commandString);
        }

        if(commandSplit[0] ~== "getPage" && commandSplit.Size() > 1)
        {
            for(int i = 0; i < link.framesList.Size(); i++)
            {
                link.framesList[i].hide();
            }
            link.framesList[commandSplit[1].ToInt()].show();
        }
    }
}

class ZDRPG_ZF_MissionsMenu : ZDRPG_ZF_GenericMenu
{
    // The menu's command handler.
    // We need a command handler so we can make our menu interactable.
    ZDRPG_ZF_MissionsMenuHandler handler;

    // A font to use for text.
    Font smallFont;

    // A background image.
    ZDRPG_ZF_Image background;
    // A simple single-texture button.
    ZDRPG_ZF_Button aButton;
    // A text label.
    ZDRPG_ZF_Label aLabel;

    array <ZDRPG_ZF_Frame> framesList;

    override void Init (Menu parent)
    {
        Vector2 baseRes = (1920, 1080);

        // Call GenericMenu's 'Init' function to do some required initialization.
        Super.Init (parent);
        menuactive = Menu.On;
        // Set our base resolution to 320x200.
        SetBaseResolution (baseRes);

        // Get GZDoom's new options menu smallfont.
        smallFont = OptionFont ();

        // Create an instance of the handler.
        handler = new ('ZDRPG_ZF_MissionsMenuHandler');
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

        array <int> blocksCount;
        array <int> rowsCount;

        let Stats = ZDRPGStats(players [consoleplayer].mo.FindInventory("ZDRPGStats")); 

        let eHandler = ZDRPGMissionHandler(EventHandler.Find("ZDRPGMissionHandler"));
        let staticHandler = ZDRPGStaticHandler(StaticEventHandler.Find("ZDRPGStaticHandler"));

        if(eHandler.Missions.Size() > 0)
        {
            for(int j = 0; j < staticHandler.missionDifficulties.Size(); j++)
            {
                let frame = ZDRPG_ZF_Frame.create(
                    (0, 0),
                    baseRes
                );
                console.printf(frame.GetClassName());
                frame.pack(mainFrame);

                for(int i=0; i<eHandler.Missions.Size(); i++)
                {
                    let mission = eHandler.Missions[i];
                    if(mission.Difficulty == j)
                    {
                        let encodedMission = "Difficulty="..mission.Difficulty.."&Type="..mission.Type.."&Item="..mission.Item.."&Amount="..mission.Amount.."&RewardXP="..mission.RewardXP.."&RewardRank="..mission.RewardRank.."&RewardCredits="..mission.RewardCredits.."&RewardModules="..mission.RewardModules.."&RewardItem="..mission.RewardItem;
                        let monsterDefaults = GetDefaultByType((class<Actor>)(mission.Item));
                        CreateStatBox(monsterDefaults.GetTag()..":"..monsterDefaults.SpawnHealth(), "addMission:"..encodedMission, baseRes, blocksCount, rowsCount, frame);
                    }
                }

                let buttonIdle = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonIdle.png", true);
                let buttonHover = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonHovered.png", false);
                let buttonClick = ZDRPG_ZF_BoxTextures.CreateSingleTexture ("graphics/ZFormsExamples/SmallButtonClicked.png", false);

                if(j+1 < staticHandler.missionDifficulties.Size())
                {
                    // Add a button.
                    aButton = ZDRPG_ZF_Button.Create
                    (
                        // Position
                        //((baseRes.X - 18.) / 2, (baseRes.Y - 18.) / 2),
                        (1880, 20),
                        // Size
                        (18, 18),
                        // Our command handler
                        cmdHandler: handler,
                        // A command string for the button
                        command: "getPage:"..j+1,
                        // The button's textures
                        inactive: buttonIdle,
                        hover: buttonHover,
                        click: buttonClick
                    );
                    // Add the button element into the main frame.
                    aButton.Pack (frame);
                }
                
                if(j-1 >= 0)
                {
                    // Add a button.
                    aButton = ZDRPG_ZF_Button.Create
                    (
                        // Position
                        //((baseRes.X - 18.) / 2, (baseRes.Y - 18.) / 2),
                        (20, 20),
                        // Size
                        (18, 18),
                        // Our command handler
                        cmdHandler: handler,
                        // A command string for the button
                        command: "getPage:"..j-1,
                        // The button's textures
                        inactive: buttonIdle,
                        hover: buttonHover,
                        click: buttonClick
                    );
                    
                    // Add the button element into the main frame.
                    aButton.Pack (frame);
                }

                // Add a label.
                aLabel = ZDRPG_ZF_Label.Create
                (
                    // Position
                    (950, 20),
                    // Size.
                    (0, smallFont.GetHeight ()),
                    // The label's text
                    text: staticHandler.missionDifficulties[j],
                    // The font to use
                    fnt: smallFont,
                    // Whether to automatically wrap the text or not
                    wrap: false,
                    // Whether to automatically resize the element based on the text width
                    autoSize: true,
                    // The text's colour
                    textColor: Font.CR_WHITE
                );
                // Add the label element to the main frame.
                aLabel.Pack (frame);

                blocksCount.Clear();
                rowsCount.Clear();
                frame.hide();
                
                framesList.Push(frame);
                
            }

            framesList[3].show();
        }
    }

    void CreateStatBox(string labelText, string commandName, Vector2 baseRes, out array <int> blocksCount, out array <int> rowsCount, ZDRPG_ZF_Frame frame) 
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
        let boxSize = (128, 128);
        if((50 + boxSize.X) * blocksCount.Size() > baseRes.X)
        {
            blocksCount.Clear();
            rowsCount.Push(1);
        }
        let boxOffset = offsetY + boxSize.X * blocksCount.Size();
        let boxInnerOffset = blocksCount.Size() * 32;

        

        let aBoxImage = ZDRPG_ZF_BoxImage.Create
        (
            // Position
            
            //((baseRes.X - boxSize.X) / testDouble, (baseRes.Y - boxSize.Y) / testDouble),
            (boxOffset + boxInnerOffset, offsetY + (rowsCount.Size() * (boxSize.X + 32))),
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
        let buttonPosX = boxOffset + boxInnerOffset + aBoxImage.GetWidth() / 2 - buttonSideSize / 2;
        let buttonPosY = offsetY + (rowsCount.Size() * (boxSize.X + 32)) + aBoxImage.GetHeight() / 2 - buttonSideSize / 2;

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
        aButton.Pack (frame);

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
        aLabel.Pack (frame);

        blocksCount.Push(1);
    }
}
