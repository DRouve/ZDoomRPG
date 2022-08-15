/*
 * SimpleMenu.ZS:
 * This example shows how to make a simple menu with a background, a text label,
 * and a single-texture button.
 * Clicking the button changes the colour of the text label's text to a random
 * colour.
*/

// The menu's command handler.
// This is needed so we can make our menu interactable.
class ZDRPG_ZF_PlayerMenuHandler : ZDRPG_ZF_Handler
{
    // The menu this command handler belongs to.
    // We need this to be able to do anything with our menu.
    ZDRPG_ZF_PlayerMenu link;
    

    override void buttonClickCommand (ZDRPG_ZF_Button caller, Name command)
    {
        Array<string> commandArray;
        string commandString = command;
        commandString.Split (commandArray, ":");

        if (commandArray.Size() > 1 && commandArray[0] ~== "menu")
        {
            link.setMenu('ZDRPG_ZF_'..commandArray[1]..'Menu');
        }
    }
}

class ZDRPG_ZF_PlayerMenu : ZDRPG_ZF_GenericMenu
{
    // The menu's command handler.
    // We need a command handler so we can make our menu interactable.
    ZDRPG_ZF_PlayerMenuHandler handler;

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
        menuactive = Menu.OnNoPause;
        // Set our base resolution to 320x200.
        SetBaseResolution (baseRes);

        // Get GZDoom's new options menu smallfont.
        smallFont = OptionFont ();

        // Create an instance of the handler.
        handler = new ('ZDRPG_ZF_PlayerMenuHandler');
        // Set the handler's "link" pointer to us.
        handler.link = self;

        // Add a background.
        background = ZDRPG_ZF_Image.Create
        (
            // Position
            (0, 0),
            // Size
            (320, 200),
            // Image path/name
            "graphics/ZFormsExamples/Panel.png",
            // Alignment options
            ZDRPG_ZF_Image.AlignType_TopLeft
        );
        // Add the image element into the main frame.
        background.Pack (mainFrame);
        /*
        // Create the box image's textures.
        let boxTexture = ZDRPG_ZF_BoxTextures.CreateTexturePixels
        (
            // The texture itself.
            "graphics/ZFormsExamples/BoxTextureRed.png",
            // The top-left corner of the middle of the box.
            (32, 32),
            // The bottom-right corner of the middle of the box.
            (64, 64),
            // Whether to scale (true) or tile (false) the sides.
            false,
            // Whether to scale (true) or tile (false) the middle.
            false
        );
        // Add a box image.
        let boxSize = (64, 128);
        let aBoxImage = ZDRPG_ZF_BoxImage.Create
        (
            // Position
            ((baseRes.X - boxSize.X) / 2., (baseRes.Y - boxSize.Y) / 2.),
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
        // Add a button.
        aButton = ZDRPG_ZF_Button.Create
        (
            // Position
            ((baseRes.X - 18.) / 2., (baseRes.Y - 18.) / 2.),
            // Size
            (18, 18),
            // Our command handler
            cmdHandler: handler,
            // A command string for the button
            command: "statsMenu",
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
            text: "Click me!",
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
        aLabel.SetPosX ((baseRes.x - smallFont.stringWidth (aLabel.GetText ())) / 2.);
        // Add the label element to the main frame.
        aLabel.Pack (mainFrame);*/

        array <int> blocksCount;
        CreateMenuBox("Stats",  "menu:Stats",  baseRes, blocksCount, Font.CR_ORANGE);
        CreateMenuBox("Augs",   "menu:Augs",   baseRes, blocksCount, Font.CR_CYAN);
        CreateMenuBox("Skills", "menu:Skills", baseRes, blocksCount, Font.CR_FIRE);
        CreateMenuBox("Shield", "menu:Shield", baseRes, blocksCount, Font.CR_SAPPHIRE);
        CreateMenuBox("Stims",  "menu:Stims",  baseRes, blocksCount, Font.CR_RED);
        CreateMenuBox("Turret", "menu:Turret", baseRes, blocksCount, Font.CR_GREEN);
        CreateMenuBox("Shop",   "menu:Shop",   baseRes, blocksCount, Font.CR_TEAL);
    }

    void CreateMenuBox(string labelText, string commandName, Vector2 baseRes, out array <int> blocksCount, int fontColor) 
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
        let boxSize = (165, 35);
        let boxOffset = offsetX + boxSize.X / 2 * blocksCount.Size();
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
        aBoxImage.Pack (mainFrame);

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
        aButton.Pack (mainFrame);

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
