/*
 * SimpleMenu.ZS:
 * This example shows how to make a simple menu with a background, a text label,
 * and a single-texture button.
 * Clicking the button changes the colour of the text label's text to a random
 * colour.
*/

// The menu's command handler.
// This is needed so we can make our menu interactable.
class ZDRPG_ZF_TransportMenuHandler : ZDRPG_ZF_Handler
{
    // The menu this command handler belongs to.
    // We need this to be able to do anything with our menu.
    ZDRPG_ZF_TransportMenu link;
    ZDRPGPlayerHandler playerHandler; 

    override void buttonClickCommand (ZDRPG_ZF_Button caller, Name command)
    {
        playerHandler.SendNetworkEvent(command);
    }
}

class ZDRPG_ZF_TransportMenu : ZDRPG_ZF_GenericMenu
{
    // The menu's command handler.
    // We need a command handler so we can make our menu interactable.
    ZDRPG_ZF_TransportMenuHandler handler;

    // A font to use for text.
    Font smallFont;

    // A background image.
    ZDRPG_ZF_Image background;
    // A simple single-texture button.
    ZDRPG_ZF_Button aButton;
    // A text label.
    ZDRPG_ZF_Label aLabel;

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
        handler = new ('ZDRPG_ZF_TransportMenuHandler');
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
        
        let staticHandler = ZDRPGStaticHandler(StaticEventHandler.Find("ZDRPGStaticHandler"));

        if(staticHandler.mapPacks.Size() > 0)
        {
            for(int i=0; i<staticHandler.mapPacks.Size(); i++)
            {
                Array <String> maps;
                staticHandler.mapPacks[i].split(maps, "##");
                CreateStatBox(maps[0], "showMaps#"..maps[1], baseRes, blocksCount, rowsCount);
            }
        }
        /*else
        {
            console.printf("gggggg");
            int levelsCount = LevelInfo.GetLevelInfoCount();
            for(int i=0; i<levelsCount; i++)
            {
                let level = LevelInfo.GetLevelInfo(i);
                if(level.MapExists(level.MapName))
                {
                    if(i > 0)
                    {
                        let prevLevel = LevelInfo.GetLevelInfo(i-1);
                        if(prevLevel.MapName.Left(prevLevel.MapName.length()-2) == level.MapName.Left(level.MapName.length()-2) || level.LookupLevelName() == "UAC Outpost") 
                            continue;
                    }
                    string mapName = level.MapName.Left(level.MapName.length()-2);
                    string mapPackName = Stringtable.Localize("$C_"..mapName);
                    mapPacks.Push(mapPackName);

                    //console.printf(level.LookupLevelName());
                    //console.printf(mapPackName);
                    //console.printf("");
                    //console.printf(level.LevelName);
                    
                    CreateStatBox(mapPackName, "C_"..mapName, baseRes, blocksCount, rowsCount);
                }
            }
        }*/
        
        /*
        CreateStatBox("Turret 1",      "statUp:1", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 2",      "statUp:2", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 3",      "statUp:3", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 4",      "statUp:4", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 5",      "statUp:5", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        CreateStatBox("Turret 6",      "statUp:6", baseRes, blocksCount, rowsCount);
        */
    }

    void CreateStatBox(string labelText, string commandName, Vector2 baseRes, out array <int> blocksCount, out array <int> rowsCount) 
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
        aBoxImage.Pack (mainFrame);

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
    }

    void setMaps(string maps, out array <string> mapsList)
    {
        array <string> arr;
        maps.Split(arr, "::");
        for(int i=0; i<arr.Size(); i++)
        {
            mapsList.Push(arr[i]);
        }
    }
}
