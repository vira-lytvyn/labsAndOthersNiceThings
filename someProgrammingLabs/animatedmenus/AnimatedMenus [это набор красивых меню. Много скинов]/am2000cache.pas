
{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       T_AM2000_MenuItemCache Unit                     }
{       English Version                                 }
{                                                       }
{       Copyright (c) 1997-2001 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000cache;

interface

uses
  Windows, CommCtrl, Classes, Graphics;

const
  // am2000designer
  SBrowseForMenuTemplateFolder =
    'Please select a folder for Animated Menus templates.';
  SInsertMenuStart =
    'Insert ';
  SInsertMenuFinish =
    ' Menu';
  SBitmapDialogFilter =
    'Bitmaps (*.bmp)|*.bmp|All Files (*.*)|*.*';
  SSaveBitmapDialogTitle =
    'Save Bitmap As';
  SOpenBitmapDialogTitle =
    'Open Bitmap';
  SDefaultMenuItemCaption =
    'Menu Item';
  SDefaultMenuItemName =
    'MenuItem';
  SDefaultMainMenuName =
    'MainMenu2000';
  SNewMainMenuCaption =
    'New TMainMenu2000';
  SNewMainMenuPrompt =
    'Select a name for the new TMainMenu2000 component';
  SDefaultPopupMenuName =
    'PopupMenu2000';
  SNewPopupMenuCaption =
    'New TPopupMenu2000';
  SNewPopupMenuPrompt =
    'Select a name for the new TPopupMenu2000 component';
  SHiddenDoesntAffectToplevel =
    'Hidden property doesn''t affect top-level menu items.';
  SDesignerNotFound =
    'Delphi Form Designer not found. This command can be run from the IDE only.';
  SPreviewMenuBar =
    'MainMenuPrevireForm_MenuBar';

  // am2000utils
  SCountRegName =
    'Count';
  SNewRegKey =
    '\New Menu Items';
  SOptionsRegName =
    '\Options';
  sPropertyException = 'Error reading %s%s%s: %s';
  SOnlyTMenuItem2000CanBeStored = 'Only items of type TMenuItem2000 can be stored'; 
  SDesignerClassName = 'T_AM2000_MenuDesignerDlg';

var
  // am2000cache
  SShift: String = 'Shift';
  SCtrl: String = 'Ctrl';
  SAlt: String = 'Alt';
  SIns: String = 'Ins';
  SDel: String = 'Del';
  SWin: String = 'Win';
  SBackspace: String = 'Back';

const
  // am2000mainmenu
  SMenuIndexOutOfBounds =
    'Menu index is out of bounds';
  SOnlyMainMenuCanBeMerged =
    'Only main menus could be merged. Assign a TMainMenu2000 component to the menu bar';
  SMainMenuIsNotVisible =
    'The %s main menu component is not visible.';

  // am2000menuitem
  SInvalidShortCut =
    'Invalid shortcut: ''';
  SThisIsNotAButtonArray =
    ': This is not a Button Array control';
  SThisIsNotAButton =
    ': This is not a Button control';
  SThisIsNotABitmap =
    ': This is not a Bitmap control';
  SThisisNotAGif =
    ': This is not a Gif image';
  SThisIsNotAEdit =
    ': This is not an Editbox control';
  SThisIsNotACombo =
    ': This is not an Combobox control';
  SThisIsNotAList =
    ': This is not a Listbox control';
  SThisIsNotAText =
    ': This is not a Text control';
  SMenuNotFound =
    'Menu not found';
  SNoNewMenu =
    'You cannot use NewMenu function with Animated Menus.';
  SNoNewPopupMenu =
    'You cannot use NewPopupMenu function with Animated Menus.';
  SOmissionPoints =
    '...';
  SShortcutDivider =
    ';';
  SSystemClose =
    'SYSTEMCLOSE';
  SSystemMaximize =
    'SYSTEMMAXIMIZE';
  SSystemMinimize =
    'SYSTEMMINIMIZE';
  SSystemMove =
    'SYSTEMMOVE';
  SSystemRestore =
    'SYSTEMRESTORE';
  SSystemSize =
    'SYSTEMSIZE';
  SSelectControlFirst =
    'Before editing ControlOptions, please select control type in the Control property.';

  // am2000popup
  SDraggableMenuInfo =
    'Drag to make this menu float';
  SExpandCaption =
    'Expand (Ctrl+Down)';
  SEmptyCaption =
    '(Empty)';
  SMenuItemNotFound =
    'Menu item not found.';
  SNewLine =
    '\n';
  STabulator =
    '\a';
  SSeparator =
    '-';
  SDoubleSeparator =
    '=';
  SDottedSeparator =
    '.';
  SDoubleDottedSeparator =
    ':';
  sEmptySeparator =
    ' ';
  SCannotMoveItem =
    'Cannot move menu item into it''s own submenu';

  // am2000
  SWelcomeMessage = 'Hi!'#13#13+
    'Thank you for using Animated Menus Evaluation '+
    'Edition. We hope you''ll enjoy this software. Visit our website at'+
    'http://www.animatedmenus.com/ for the documentation, samples, '+
    'knwoledge base, latest software updates, and gifts for users.'#13#13+
    'Thank you!'#13#13+
    'Sincerely, Andrew Cher,'#13+
    'AnimatedMenus.com, Inc.';

  // am2000bitmap
  SValueMustBeBetween1And4 =
    'Value must be between 1 and 4.';

  // am2000editbox
  SOnlyTextMenuItemCanBeEdited =
    'Only text menu item can be edited.';

  // customize
  SResetUsageData =
    'This will delete the record of commands you''ve used in this application '+
    'and restore the default set of visible commands to the menus and toolbars. It will not undo any explicit '+
    'customizations. Are you sure you want to do this?';

  SAnimatedMenus =
    'Animated Menus';

type
  T_AM2000_MenuItemCacheItem = class
  public
    Caption     : String;
    ShortCuts   : String;
    Hint        : String;
    HasBitmap   : Boolean;
    Index       : Integer;
    DefaultIndex: Integer;
  end;

  T_AM2000_MenuItemCache = class(TStringList)
  private
    FBitmaps: TList;

    function GetItem(const Caption: String): T_AM2000_MenuItemCacheItem;
    function GetBitmapCount: Integer;

  public
    Images: HImageList;
    property BitmapCount: Integer read GetBitmapCount;
    property Items    [const Caption: String]: T_AM2000_MenuItemCacheItem read GetItem; default;

    constructor Create;
    destructor Destroy; override;
    function AddItem(ACaption, AShortCuts, AHint: String; ABitmap: Boolean): T_AM2000_MenuItemCacheItem;

    function IsDefault(Caption: String): Boolean;
    function HasBitmap(Caption: String): Boolean;
    procedure Draw(
      const Canvas: TCanvas;
      const X, Y: Integer;
      const Caption: String;
      const C1, C2, C3: TColor;
      const Enabled: Boolean;
      const AParams: Integer);

    procedure DrawIndex(
      const Canvas: TCanvas;
      const X, Y: Integer;
      const DefaultIndex: Integer;
      const C1, C2, C3: TColor;
      const Enabled: Boolean;
      const AParams: Integer);

    function GetBitmapIndex(Caption: String): Integer;
    function GetBitmapCaption(DefaultIndex: Integer): String;
    function IndexOf(const S: string): Integer; override;

  end;


var
  MenuItemCache: T_AM2000_MenuItemCache;

implementation

{$R autobitmaps.res}

uses
  SysUtils, Menus,
  am2000utils;

{ Utilities }

function GetStandardCaption(S: String): String;
var
  J: Integer;
begin
  Result:= '';
  S:= AnsiUpperCase(S);
  for J:= 1 to Length(S) do begin
    if S[J] = #9 then Exit;
    if IsCharAlpha(S[J]) then Result:= Result + S[J];
  end;
end;

function GetShiftText(Shift: TShiftState): String;
var
  S: String;
begin
  S:= ShortCutToText(ShortCut($41, Shift));
  Result:= Copy(S, 1, Pos('+', S) -1);
end;


{ T_AM2000_MenuItemCache }

constructor T_AM2000_MenuItemCache.Create;
var
  hBmp: HBitmap;
begin
  inherited;
  FBitmaps:= TList.Create;

  // initialize shortcuts
  SCtrl:= GetShiftText([ssCtrl]);
  SAlt:= GetShiftText([ssAlt]);
  SShift:= GetShiftText([ssShift]);
  SIns:= ShortCutToText(45);
  SDel:= ShortCutToText(46);
  SBackspace:= ShortCutToText(8);

  // initialize default menu items
  { About }
  AddItem('About', '', 'Displays the version number of this program and copyright, legal, and licensing notices', False);
  { Address Book }
  AddItem('Address Book', '', 'Displays the list of contacts', True);
  { Align Bottom }
  AddItem('Align Bottom', '', 'Horizontally aligns the bottom edges of selected objects', True);
  { Align Center }
  AddItem('Align Center', SCtrl+'+E', 'Centers the paragraph between the margins', True);
  { Align Justify }
  AddItem('Align Justify', SCtrl+'+J', 'Justifies the paragraph between the margins', True);
  { Align Left }
  AddItem('Align Left', SCtrl+'+L', 'Aligns the paragraph at the left margin', True);
  { Align Middle }
  AddItem('Align Middle', '', 'Horizontally aligns the middles of selected objects', True);
  { Align Right }
  AddItem('Align Right', SCtrl+'+R', 'Aligns the paragraph at the right margin', True);
  { Align Top }
  AddItem('Align Top', '', 'Horizontally aligns the top edges of selected objects', True);
  { Arrange Icons }
  AddItem('Arrange Icons', '', 'Arrange icons at the bottom of the window', False);
  { AutoFit to Contents }
  AddItem('AutoFit to Contents', '', '', True);
  { AutoFit to Window }
  AddItem('AutoFit to Window', '', '', True);
  { Auto Format }
  AddItem('Auto Format', '', '', True);
  { Auto Preview }
  AddItem('Auto Preview', '', 'Shows or hides the autopreview pane', True);
  { Auto Shapes }
  AddItem('Auto Shapes', '', '', True);
  { Auto Summarize }
  AddItem('Auto Summarize', '', '', True);
  { Auto Text }
  AddItem('Auto Text', '', '', True);
  { Back }
  AddItem('Back', '', 'Return to the previous page in the hyperlink history list', True);
  { Background }
  AddItem('Background', '', '', True);
  { Backward }
  AddItem('Backward', '', 'Return to the previous page in the hyperlink history list', True);
  { Best of the Web }
  AddItem('Best of the Web', '', '', True);
  { Bold }
  AddItem('Bold', SCtrl+'+B', 'Bold Text', True);
  { Bookmarks }
  AddItem('Bookmarks', '', 'Insert a bookmark at the cursor', True);
  { Bullets }
  AddItem('Bullets', '', 'Inserts a bullet on this line', True);
  { Bullets And Numbering }
  AddItem('Bullets And Numbering', '', '', True);
  { Cascade }
  AddItem('Cascade', '', 'Arranges the windows as overlapping tiles', True);
  { Center }
  AddItem('Center', SCtrl+'+E', 'Centers selected objects vertically', True);
  { Chart }
  AddItem('Chart', '', '', True);
  { Check Spelling }
  AddItem('Check Spelling', 'F7', 'Checks the spelling in the active document', True);
  { Clear }
  AddItem('Clear', SDel+';'+SShift+'+'+SDel, 'Erases the selection', False);
  { Clip Art }
  AddItem('Clip Art', '', '', True);
  { Columns }
  AddItem('Columns', '', '', True);
  { Columns to the Left }
  AddItem('Columns to the Left', '', '', True);
  { Columns to the Right }
  AddItem('Columns to the Right', '', '', True);
  { Comment }
  AddItem('Comment', '', '', True);
  { Comments }
  AddItem('Comments', '', '', True);
  { Contents }
  AddItem('Contents', '', 'Displays help topics', True);
  { Contents And Index }
  AddItem('Contents And Index', 'F1', 'Displays help topics', True);
  { Copy }
  AddItem('Copy', SCtrl+'+C;'+SCtrl+'+'+SIns, 'Copies the selection to the clipboard', True);
  { Create }
  AddItem('Create', '', 'Create a new document', True);
  { Create II }
  AddItem('Create II', '', 'Create a new document (second choice)', True);
  { Create New Query }
  AddItem('Create New Query', '', '', True);
  { Customize }
  AddItem('Customize', '', 'Customizes toolbar buttons, menu commands, and shortcut key assignments', False);
  { Cut }
  AddItem('Cut', SCtrl+'+X;'+SShift+'+'+SDel, 'Cuts the selection and moves it to the clipboard', True);
  { Data Range Properties }
  AddItem('Data Range Properties', '', '', True);
  { Date }
  AddItem('Date', '', 'Inserts today''s date', True);
  { Date And Time }
  AddItem('Date And Time', '', 'Inserts today''s date and/or time', True);
  { Date Time }
  AddItem('Date Time', '', 'Inserts today''s date and/or time', True);
  { Decrease Indent }
  AddItem('Decrease Indent', '', 'Decrease indent', True);
  { Delete }
  AddItem('Delete', ''+SDel+';'+SCtrl+'+'+SDel, 'Erases the selection', True);
  { Delete II }
  AddItem('Delete II', '', 'Erases the selection (second choice)', True);
  { Distribute Columns Evenly }
  AddItem('Distribute Columns Evenly', '', '', True);
  { Distribute Horizontally }
  AddItem('Distribute Horizontally', '', '', True);
  { Distribute Rows Evenly }
  AddItem('Distribute Rows Evenly', '', '', True);
  { Distribute Vertically }
  AddItem('Distribute Vertically', '', '', True);
  { Document Map }
  AddItem('Document Map', '', '', True);
  { Down }
  AddItem('Down', '', '', True);
  { Draw Table }
  AddItem('Draw Table', '', '', True);
  { Edit }
  AddItem('Edit', '', 'Contains commands for the clipboard, finding text, and editing links', False);
  { Edit Query }
  AddItem('Edit Query', '', '', True);
  { Envelopes And Labels }
  AddItem('Envelopes And Labels', '', '', True);
  { Exchange Folder }
  AddItem('Exchange Folder', '', '', True);
  { Exit }
  AddItem('Exit', '', 'Closes this program after prompting you to save all unsaved files', False);
  { Fax Recipient }
  AddItem('Fax Recipient', '', '', True);
  { File }
  AddItem('File', '', 'Contains commands for saving documents and opening saved documents', False);
  { Find }
  AddItem('Find', SCtrl+'+F;F3', 'Finds the specified text in the active document', True);
  { Find Next }
  AddItem('Find Next', SShift+'+F3', 'Repeats the last find', True);
  { Fixed Column Width }
  AddItem('Fixed Column Width', '', '', True);
  { Font }
  AddItem('Font', '', 'View or edit the character attributes of the selected text', True);
  { Font Size }
  AddItem('Font Size', '', 'View or edit the font size of the selected text', True);
  { Font Style }
  AddItem('Font Style', '', 'View or edit the font style of the selected text', True);
  { Forward }
  AddItem('Forward', '', 'Go to the next page in the hyperlink history list', True);
  { Free Stuff }
  AddItem('Free Stuff', '', '', True);
  { Frequently Asked Questions }
  AddItem('Frequently Asked Questions', '', '', True);
  { From File }
  AddItem('From File', '', '', True);
  { From Scanner or Camera }
  AddItem('From Scanner or Camera', '', '', True);
  { Full Screen }
  AddItem('Full Screen', 'F11', 'Zooms the active document to the full screen', True);
  { Function }
  AddItem('Function', '', '', True);
  { Go To }
  AddItem('Go To', SCtrl+'+G', 'Moves the cursor to the specified line', False);
  { Go To Bookmark }
  AddItem('Go To Bookmark', '', 'Moves the cursor to the specified bookmark', True);
  { Group }
  AddItem('Group', '', 'Assembles to or more selecte objects into a single object', True);
  { Height }
  AddItem('Height', '', '', True);
  { Help }
  AddItem('Help', '', 'Contains commands for solving problem situations', False);
  { Help On Help }
  AddItem('Help On Help', 'F1', 'Display instructions about how to use help', True);
  { Help Topics }
  AddItem('Help Topics', '', 'Displays help topics', True);
  { Hide Detail }
  AddItem('Hide Detail', '', '', True);
  { Hide Gridlines }
  AddItem('Hide Gridlines', '', '', True);
  { Highlight Changes }
  AddItem('Highlight Changes', '', '', True);
  { Home }
  AddItem('Home', '', 'Browses the web', True);
  { Hyperlink }
  AddItem('Hyperlink', '', 'Insert a new hyperlink', True);
  { Increase Indent }
  AddItem('Increase Indent', '', 'Increase indent', True);
  { Indent }
  AddItem('Indent', '', 'Increase Indent', True);
  { Insert Object }
  AddItem('Insert Object', '', '', True);
  { Italic }
  AddItem('Italic', SCtrl+'+I', 'Italic Text', True);
  { Justify }
  AddItem('Justify', SCtrl+'+J', 'Justifies the paragraph between the margins', True);
  { Left }
  AddItem('Left', SCtrl+'+L', '', True);
  { Macros }
  AddItem('Macros', '', '', True);
  { Mail }
  AddItem('Mail', '', '', True);
  { Mail Recipient }
  AddItem('Mail Recipient', '', '', True);
  { Mail Recipient (as Attachement) }
  AddItem('Mail Recipient (as Attachement)', '', '', True);
  { Map }
  AddItem('Map', '', '', True);
  { Mark As Read }
  AddItem('Mark As Read', '', 'Marks the selected messages as read', True);
  { Mark As Unread }
  AddItem('Mark As Unread', '', 'Marks the selected messages as unread', True);
  { Master Document }
  AddItem('Master Document', '', '', True);
  { Meet Now }
  AddItem('Meet Now', '', '', True);
  { Merge Cells }
  AddItem('Merge Cells', '', '', True);
  { Microsoft Excel Help }
  AddItem('Microsoft Excel Help', '', '', True);
  { Microsoft Home Page }
  AddItem('Microsoft Home Page', '', '', True);
  { Microsoft Office Home Page }
  AddItem('Microsoft Office Home Page', '', '', True);
  { Microsoft Script Debugger }
  AddItem('Microsoft Script Debugger', '', '', True);
  { Microsoft Word Help }
  AddItem('Microsoft Word Help', '', '', True);
  { Move Down }
  AddItem('Move Down', '', 'Moves the selection down', True);
  { Move Left }
  AddItem('Move Left', '', 'Moves the selection left', True);
  { Move Right }
  AddItem('Move Right', '', 'Moves the selection right', True);
  { Move To Folder }
  AddItem('Move To Folder', '', 'Moves selected items to another folder', True);
  { Move Up }
  AddItem('Move Up', '', 'Moves the selection up', True);
  { New }
  AddItem('New', SCtrl+'+N', 'Create a new document', True);
  { New Folder }
  AddItem('New Folder', '', 'Create a new folder', True);
  { New Folder II }
  AddItem('New Folder II', '', 'Create a new folder (second choice)', True);
  { New Mail }
  AddItem('New Mail', '', 'Create a new email message', True);
  { New Mail Message }
  AddItem('New Mail Message', '', 'Create a new email message', True);
  { New Note }
  AddItem('New Note', '', 'Create a new note', True);
  { New Task }
  AddItem('New Task', '', 'Create a new task', True);
  { New Window }
  AddItem('New Window', '', 'Open another window for the active document', False);
  { Normal }
  AddItem('Normal', '', '', True);
  { Note }
  AddItem('Note', '', 'Create a new note', True);
  { Numbering }
  AddItem('NUMBERING', '', 'Inserts a numbering on this line', True);
  { Object }
  AddItem('Object', '', '', True);
  { Online Layout }
  AddItem('Online Layout', '', '', True);
  { Online Support }
  AddItem('Online Support', '', '', True);
  { Open }
  AddItem('Open', SCtrl+'+O', 'Opens an existing document from a file', True);
  { Options }
  AddItem('Options', '', 'Modifies settings for this program such as screen appearance, printing, editing, and other options', False);
  { Organization Chart }
  AddItem('Organization Chart', '', '', True);
  { Outline }
  AddItem('Outline', '', '', True);
  { Page Break Preview }
  AddItem('Page Break Preview', '', '', True);
  { Page Layout }
  AddItem('Page Layout', '', '', True);
  { Page Setup }
  AddItem('Page Setup', '', 'Change the printing options', False);
  { Paragraph }
  AddItem('Paragraph', '', 'View or edit the paragraph attributes of the selected text', True);
  { Parameters }
  AddItem('Parameters', '', '', True);
  { Paste }
  AddItem('Paste', SCtrl+'+V;'+SShift+'+'+SIns, 'Inserts the clipboard contents at the insertion point', True);
  { Paste Link }
  AddItem('Paste Link', '', 'Insert Clipboard contents and a link to its source', False);
  { Paste Special }
  AddItem('Paste Special', '', 'Insert Clipboard contents with options', False);
  { Pivot Table Report }
  AddItem('Pivot Table Report', '', '', True);
  { Print }
  AddItem('Print', SCtrl+'+P', 'Print the active document', True);
  { Print Layout }
  AddItem('Print Layout', '', '', True);
  { Print Preview }
  AddItem('Print Preview', '', 'Display full pages', True);
  { Printer Setup }
  AddItem('Printer Setup', '', 'Change the printer and printing options', False);
  { Product News }
  AddItem('Product News', '', '', True);
  { Properties }
  AddItem('Properties', '', 'Display properties for the active document', True);
  { Record New Macro }
  AddItem('Record New Macro', '', '', True);
  { Redo }
  AddItem('Redo', SCtrl+'+'+SShift+'+Z;'+SAlt+'+'+SShift+'+'+SBackspace, 'Redoes the last action that was undone', True);
  { Refresh }
  AddItem('Refresh', '', 'Updates the display to reflect any changes', True);
  { Refresh Data }
  AddItem('Refresh Data', '', '', True);
  { Regroup }
  AddItem('Regroup', '', 'Reassembled a group of objects that have been disassembled using the Ungroup command', True);
  { Reload }
  AddItem('Reload', '', 'Reloads the content of the current page', True);
  { Remove All Arrows }
  AddItem('Remove All Arrows', '', '', True);
  { Remove Dependent Arrows }
  AddItem('Remove Dependent Arrows', '', '', True);
  { Remove Precedent Arrows }
  AddItem('Remove Precedent Arrows', '', '', True);
  { Repeat }
  AddItem('Repeat', '', 'Repeats the last action', True);
  { Replace }
  AddItem('Replace', SCtrl+'+H', 'Replaces specific text with different text', True);
  { Right }
  AddItem('Right', SCtrl+'+R', '', True);
  { Routing Recipient }
  AddItem('Routing Recipient', '', '', True);
  { Rows Above }
  AddItem('Rows Above', '', '', True);
  { Rows Below }
  AddItem('Rows Below', '', '', True);
  { Ruler }
  AddItem('Ruler', '', 'Shows or hides the ruler', True);
  { Run Database Query }
  AddItem('Run Database Query', '', '', True);
  { Run Web Query }
  AddItem('Run Web Query', '', '', True);
  { Save }
  AddItem('Save', SCtrl+'+S;'+SShift+'+F12;'+SAlt+'+'+SShift+'+F2', 'Saves the active document', True);
  { Save All }
  AddItem('Save All', '', 'Saves all opened documents', True);
  { Save As }
  AddItem('Save As', 'F12;'+SCtrl+'+'+SShift+'+S', 'Saves a copy of the document in a separate file', False);
  { Save As Web Page }
  AddItem('Save As Web Page', '', '', True);
  { Search }
  AddItem('Search', '', 'Contains commands for searching through your document', False);
  { Search the Web }
  AddItem('Search the Web', '', 'Searches the Word Wide Web for the specified resource', True);
  { Select All }
  AddItem('Select All', SCtrl+'+A', 'Select the entire document', False);
  { Send Feedback }
  AddItem('Send Feedback', '', '', True);
  { Send Mail }
  AddItem('Send Mail', '', 'Compose and send new mail message', True);
  { Service }
  AddItem('Service', '', '', False);
  { Set Bookmark }
  AddItem('Set Bookmark', '', 'Insert a bookmark at the cursor', True);
  { Set Date }
  AddItem('Set Date', '', 'Set today''s date', True);
  { Set Font }
  AddItem('Set Font', '', 'View or edit the character attributes of the selected text', True);
  { Set Language }
  AddItem('Set Language', '', '', True);
  { Set Time }
  AddItem('Set Time', '', 'Set current time', True);
  { Show Detail }
  AddItem('Show Detail', '', '', True);
  { Sort }
  AddItem('Sort', '', 'Arranges items in the window', True);
  { Spell Check }
  AddItem('Spell Check', 'F7', 'Checks the spelling in the active document', True);
  { Split Cells }
  AddItem('Split Cells', '', '', True);
  { Split Window }
  AddItem('Split Window', '', 'Splits the active document window horizontally', True);
  { System Close }
  AddItem(SSystemClose, '', 'Close the active window and prompts to save the pages', True);
  { System Maximize }
  AddItem(SSystemMaximize, '', 'Enlarge the window to full size', True);
  { System Minimize }
  AddItem(SSystemMinimize, '', 'Reduce the window to an icon', True);
  { System Move }
  AddItem(SSystemMove, '', 'Change the window position', True);
  { System Restore }
  AddItem(SSystemRestore, '', 'Restore the window to normal size', True);
  { System Size }
  AddItem(SSystemSize, '', 'Change the window size', True);
  { Table }
  AddItem('Table', '', '', False);
  { Table of Contents in Frame }
  AddItem('Table of Contents in Frame', '', '', True);
  { Task }
  AddItem('Task', '', 'Create a new task', True);
  { Text Box }
  AddItem('Text Box', '', '', True);
  { Text Directions }
  AddItem('Text Directions', '', '', True);
  { Theme }
  AddItem('Theme', '', '', True);
  { Tile }
  AddItem('Tile', '', 'Arranges the windows as nonoverlapping tiles', True);
  { Time }
  AddItem('Time', '', 'Inserts current time', True);
  { Toolbox }
  AddItem('Toolbox', '', '', True);
  { Tools }
  AddItem('Tools', '', 'Contains additional commands for working with external tools', False);
  { Trace Dependents }
  AddItem('Trace Dependents', '', '', True);
  { Trace Error }
  AddItem('Trace Error', '', '', True);
  { Trace Precedents }
  AddItem('Trace Precedents', '', '', True);
  { Underline }
  AddItem('Underline', SCtrl+'+U', 'Underlined text', True);
  { Undo }
  AddItem('Undo', SCtrl+'+Z;'+SAlt+'+'+SBackspace, 'Reverses the last action', True);
  { Ungroup }
  AddItem('Ungroup', '', 'Disassembles a grouped object into individual objects', True);
  { Unindent }
  AddItem('Unindent', '', 'Decrease indent', True);
  { Up }
  AddItem('Up', '', '', True);
  { Up One Level }
  AddItem('Up One Level', '', 'Moves the cursor up one level', True);
  { View }
  AddItem('View', '', 'Contains commands for controlling the display of your document', False);
  { Visual Basic Editor }
  AddItem('Visual Basic Editor', '', '', True);
  { Web Discussions }
  AddItem('Web Discussions', '', '', True);
  { Web Layout }
  AddItem('Web Layout', '', '', True);
  { Web Tutorial }
  AddItem('Web Tutorial', '', '', True);
  { What's This? }
  AddItem('What''s This?', SShift+'+F1', 'Shows help about the selected element', True);
  { Width }
  AddItem('Width', '', '', True);
  { Window }
  AddItem('Window', '', 'Contains commands for controlling position of windows of your application', False);
  { Word Art }
  AddItem('Word Art', '', '', True);

  // create image list
  Images:= ImageList_Create(16, 16, ILC_COLOR24 + ILC_MASK, 200, 100);
  ImageList_SetBkColor(Images, clFuchsia);

  hbmp:= LoadBitmap(HInstance, 'BMP_AM2000_MENUITEMCACHE0');
  ImageList_AddMasked(Images, hBmp, clFuchsia);
  DeleteObject(hBmp);

  hBmp:= LoadBitmap(HInstance, 'BMP_AM2000_MENUITEMCACHE1');
  ImageList_AddMasked(Images, hBmp, clFuchsia);
  DeleteObject(hBmp);
end;

destructor T_AM2000_MenuItemCache.Destroy;
var
  I: Integer;
begin
  for I:= 0 to Count -1 do
    T_AM2000_MenuItemCacheItem(Objects[I]).Free;

  // destroy image list
  ImageList_Destroy(Images);

  FBitmaps.Free;
  
  inherited;
end;

function T_AM2000_MenuItemCache.AddItem(ACaption, AShortCuts, AHint: String;
  ABitmap: Boolean): T_AM2000_MenuItemCacheItem;
var
  Index: Integer;
  S: String;
begin
  S:= GetStandardCaption(ACaption);
  if not Find(S, Index)
  then begin
    Result:= T_AM2000_MenuItemCacheItem.Create;
    AddObject(S, Result);
  end
  else
    Result:= T_AM2000_MenuItemCacheItem(Objects[Index]);

  Result.ShortCuts:= AShortCuts;
  Result.Hint:=      AHint;
  Result.HasBitmap:= ABitmap;
  Result.Index:=     Index;
  Result.Caption:=   ACaption;
  if ABitmap
  then begin
    Result.DefaultIndex:= FBitmaps.Count;
    FBitmaps.Add(Result);
  end
  else
    Result.DefaultIndex:= -1;
end;

function T_AM2000_MenuItemCache.GetItem(const Caption: String): T_AM2000_MenuItemCacheItem;
var
  Index: Integer;
  S: String;
begin
  S:= GetStandardCaption(Caption);
  if Find(S, Index)
  then Result:= T_AM2000_MenuItemCacheItem(Objects[Index])
  else Result:= nil;
end;

procedure T_AM2000_MenuItemCache.Draw(
  const Canvas: TCanvas;
  const X, Y: Integer;
  const Caption: String;
  const C1, C2, C3: TColor;
  const Enabled: Boolean;
  const AParams: Integer);
var
  Index: Integer;
begin
  if not Find(GetStandardCaption(Caption), Index)
  then Exit;

  if Enabled
  then ImgTransBlt(Canvas, X, Y, Images, Index, 16, 16, C3, AParams)
  else ImgDisabledBlt(Canvas, X, Y, Images, Index, 16, 16, C1, C2);
end;

procedure T_AM2000_MenuItemCache.DrawIndex(
  const Canvas: TCanvas;
  const X, Y: Integer;
  const DefaultIndex: Integer;
  const C1, C2, C3: TColor;
  const Enabled: Boolean;
  const AParams: Integer);
begin
  if (DefaultIndex < 0)
  or (DefaultIndex >= FBitmaps.Count)
  then Exit;

  // get the number of ImageIndex
  with T_AM2000_MenuItemCacheItem(FBitmaps[DefaultIndex])
  do
    if Enabled
    then ImgTransBlt(Canvas, X, Y, Images, Index, 16, 16, C3, AParams)
    else ImgDisabledBlt(Canvas, X, Y, Images, Index, 16, 16, C1, C2);
end;

function T_AM2000_MenuItemCache.IsDefault(Caption: String): Boolean;
var
  Index: Integer;
begin
  Result:= Find(GetStandardCaption(Caption), Index);
end;

function T_AM2000_MenuItemCache.HasBitmap(Caption: String): Boolean;
var
  Index: Integer;
begin
  Result:= Find(GetStandardCaption(Caption), Index)
    and T_AM2000_MenuItemCacheItem(Objects[Index]).HasBitmap;
end;

function T_AM2000_MenuItemCache.GetBitmapIndex(Caption: String): Integer;
var
  Index: Integer;
begin
  if Find(GetStandardCaption(Caption), Index)
  then Result:= T_AM2000_MenuItemCacheItem(Objects[Index]).DefaultIndex
  else Result:= -1;
end;

function T_AM2000_MenuItemCache.GetBitmapCount: Integer;
begin
  Result:= FBitmaps.Count;
end;

function T_AM2000_MenuItemCache.GetBitmapCaption(
  DefaultIndex: Integer): String;
begin
  if (DefaultIndex < 0)
  or (DefaultIndex >= FBitmaps.Count)
  then
    Result:= ''
  else
    Result:= T_AM2000_MenuItemCacheItem(FBitmaps[DefaultIndex]).Caption;

end;

function T_AM2000_MenuItemCache.IndexOf(const S: string): Integer;
begin
  Result:= GetBitmapIndex(S);
end;


initialization
  MenuItemCache:= T_AM2000_MenuItemCache.Create;

finalization
  MenuItemCache.Free;
  MenuItemCache:= nil;

end.
