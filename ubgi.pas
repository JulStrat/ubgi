(*
  ubgi - Object Pascal bindings for SDL_bgi library.@br
  Copyright (C) 2020 I. Kakoulidis, <ioulianos.kakoulidis@hotmail.com>@br
  https://github.com/JulStrat/ubgi

  SDL_bgi - Borland Graphics Library implementation based on SDL2.@br
  Copyright (C) 2014-2021 Guido Gonzato, PhD <guido.gonzato@gmail.com>@br
  http://libxbgi.sourceforge.net/

  This file is distributed under the ZLib License.
*)

(*
This software is provided 'as-is', without any express or implied
warranty.  In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.
2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribution.
*)

unit ubgi;
{$IF Defined(FPC)}
{$MODE Delphi}
{$PACKRECORDS C}
{$ENDIF}

interface

{$IF Defined(MSWINDOWS) or Defined(Linux)}
const
  LIB_UBGI = 'SDL_bgi';
  LIB_FNPFX = '';
{$ELSE}
  {$MESSAGE Error 'Unsupported platform'}
{$ENDIF}

const
  NOPE = 0;
  YEAH = 1;

const
  SDL_BGI_VERSION = '2.4.3';
  UBGI_VERSION = '0.3.1';

  BGI_WINTITLE_LEN = 512;
  (* number of concurrent windows that can be created *)
  NUM_BGI_WIN = 16;
  (* available visual pages *)
  VPAGES = 4;
  PALETTE_SIZE = 4096;

(* mouse handling *)
const
  SDL_BUTTON_LEFT = 1;
  SDL_BUTTON_MIDDLE = 2;
  SDL_BUTTON_RIGHT = 3;
  SDL_MOUSEMOTION = $400;
  SDL_MOUSEWHEEL = SDL_MOUSEMOTION + 3;
  SDL_USEREVENT = $8000;

const
  WM_LBUTTONDOWN = SDL_BUTTON_LEFT;
  WM_MBUTTONDOWN = SDL_BUTTON_MIDDLE;
  WM_RBUTTONDOWN = SDL_BUTTON_RIGHT;
  WM_WHEEL = SDL_MOUSEWHEEL;
  WM_WHEELUP = SDL_USEREVENT;
  WM_WHEELDOWN = SDL_USEREVENT + 1;
  WM_MOUSEMOVE = SDL_MOUSEMOTION;

(* keyboard handling *)
const
  SDLK_HOME = $4000004A;
  SDLK_LEFT = $40000050;
  SDLK_UP = $40000052;
  SDLK_RIGHT = $4000004F;
  SDLK_DOWN = $40000051;
  SDLK_PAGEUP = $4000004B;
  SDLK_PAGEDOWN = $4000004E;
  SDLK_END = $4000004D;
  SDLK_INSERT = $40000049;
  SDLK_DELETE = $7F;

  SDLK_KP_MINUS = 1073741910;
  SDLK_KP_PLUS = 1073741911;

  SDLK_F1 = $4000003A;
  SDLK_F2 = $4000003B;
  SDLK_F3 = $4000003C;
  SDLK_F4 = $4000003D;
  SDLK_F5 = $4000003E;
  SDLK_F6 = $4000003F;
  SDLK_F7 = $40000040;
  SDLK_F8 = $40000041;
  SDLK_F9 = $40000042;
  SDLK_F10 = $40000043;
  SDLK_F11 = $40000044;
  SDLK_F12 = $40000045;

  SDLK_CAPSLOCK = $40000039;
  SDLK_LCTRL = $400000E0;
  SDLK_RCTRL = $400000E4;
  SDLK_LSHIFT = $400000E1;
  SDLK_RSHIFT = $400000E5;
  SDLK_LALT = $400000E2;
  SDLK_RALT = $400000E6;
  SDLK_MODE =  $40000101;
  SDLK_LGUI = $400000E3;
  SDLK_RGUI = $400000E7;
  SDLK_MENU = $40000076;
  SDLK_TAB = $09;
  SDLK_BACKSPACE = $08;
  SDLK_RETURN = $0D;
  SDLK_PAUSE = $40000048;
  SDLK_SCROLLLOCK = $40000047;
  SDLK_ESCAPE = $1B;
  SDL_QUIT = $100;

const
  KEY_HOME = SDLK_HOME;
  KEY_LEFT = SDLK_LEFT;
  KEY_UP = SDLK_UP;
  KEY_RIGHT = SDLK_RIGHT;
  KEY_DOWN = SDLK_DOWN;
  KEY_PGUP = SDLK_PAGEUP;
  KEY_PGDN = SDLK_PAGEDOWN;
  KEY_END = SDLK_END;
  KEY_INSERT = SDLK_INSERT;
  KEY_DELETE = SDLK_DELETE;

  KEY_KP_MINUS = SDLK_KP_MINUS;
  KEY_KP_PLUS = SDLK_KP_PLUS;

  KEY_F1 = SDLK_F1;
  KEY_F2 = SDLK_F2;
  KEY_F3 = SDLK_F3;
  KEY_F4 = SDLK_F4;
  KEY_F5 = SDLK_F5;
  KEY_F6 = SDLK_F6;
  KEY_F7 = SDLK_F7;
  KEY_F8 = SDLK_F8;
  KEY_F9 = SDLK_F9;
  KEY_F10 = SDLK_F10;
  KEY_F11 = SDLK_F11;
  KEY_F12 = SDLK_F12;

  KEY_CAPSLOCK = SDLK_CAPSLOCK;
  KEY_LEFT_CTRL = SDLK_LCTRL;
  KEY_RIGHT_CTRL = SDLK_RCTRL;
  KEY_LEFT_SHIFT = SDLK_LSHIFT;
  KEY_RIGHT_SHIFT = SDLK_RSHIFT;
  KEY_LEFT_ALT = SDLK_LALT;
  KEY_RIGHT_ALT = SDLK_RALT;
  KEY_ALT_GR = SDLK_MODE;
  KEY_LGUI = SDLK_LGUI;
  KEY_RGUI = SDLK_RGUI;
  KEY_MENU = SDLK_MENU;
  KEY_TAB = SDLK_TAB;
  KEY_BS = SDLK_BACKSPACE;
  KEY_RET = SDLK_RETURN;
  KEY_PAUSE = SDLK_PAUSE;
  KEY_SCR_LOCK = SDLK_SCROLLLOCK;
  KEY_ESC = SDLK_ESCAPE;
  QUIT = SDL_QUIT;

(* BGI fonts *)
const
  DefaultFont = 0;
  TriplexFont = 1;
  SmallFont = 2;
  SansSerifFont = 3;
  GothicFont = 4;
  ScriptFont = 5;
  SimplexFont = 6;
  TriplexScrFont = 7;
  ComplexFont = 8;
  EuropeanFont = 9;
  BoldFont = 10;
  LastSpecFont = 11;

const
  HorizDir = 0;
  VertDir = 1;

const
  UserCharSize = 0;

const
  LeftText = 0;
  CenterText = 1;
  RightText = 2;

  BottomText = 0;
  TopText = 2;

(* BGI colours *)
const
  Black = 0;
  Blue = 1;
  Green = 2;
  Cyan = 3;
  Red = 4;
  Magenta = 5;
  Brown = 6;
  LightGray = 7;
  DarkGray = 8;
  LightBlue = 9;
  LightGreen = 10;
  LightCyan = 11;
  LightRed = 12;
  LightMagenta = 13;
  Yellow = 14;
  White = 15;
  MaxColors = 15;
  (* Blink = 128; *)

(* ARGB colours, set by COLOR () *)
const
  ARGB_FG_COL = 16;
  ARGB_BG_COL = 17;
  ARGB_FILL_COL = 18;
  ARGB_TMP_COL = 19;
  TMP_COLORS = 4;

(* line style, thickness, and drawing mode *)
const
  NormWidth = 1;
  ThickWidth = 3;

  SolidLn = 0;
  DottedLn = 1;
  CenterLn = 2;
  DashedLn = 3;
  UserBitLn = 4;

  CopyPut = 0;
  XorPut = 1;
  OrPut = 2;
  AndPut = 3;
  NotPut = 4;

(* fill styles *)
const
  EmptyFill = 0;
  SolidFill = 1;
  LineFill = 2;
  LtSlashFill = 3;
  SlashFill = 4;
  BkSlashFill = 5;
  LtBkSlashFill = 6;
  HatchFill = 7;
  XHatchFill = 8;
  InterleaveFill = 9;
  WideDotFill = 10;
  CloseDotFill = 11;
  UserFill = 12;

(* graphics modes. Expanded from the original GRAPHICS.H *)
const
  DETECT = -1;
  SDL = 0;
  (* all modes @ 320x200 *)
  SDL_320x200 = 1; SDL_CGALO = 1; CGA = 1; CGAC0 = 1; CGAC1 = 1;
  CGAC2 = 1; CGAC3 = 1; MCGAC0 = 1; MCGAC1 = 1; MCGAC2 = 1;
  MCGAC3 = 1; ATT400C0 = 1; ATT400C1 = 1; ATT400C2 = 1; ATT400C3 = 1;
  (* all modes @ 640x200 *)
  SDL_640x200 = 2; SDL_CGAHI = 2; CGAHI = 2; MCGAMED = 2;
  EGALO = 2; EGA64LO = 2;
  (* all modes @ 640x350 *)
  SDL_640x350 = 3; SDL_EGA = 3; EGA = 3; EGAHI = 3;
  EGA64HI = 3; EGAMONOHI = 3;
  (* all modes @ 640x480 *)
  SDL_640x480 = 4; SDL_VGA = 4; VGA = 4; MCGAHI = 4; VGAHI = 4;
  IBM8514LO = 4;
  (* all modes @ 720x348 *)
  SDL_720x348 = 5; SDL_HERC = 5;
  (* all modes @ 720x350 *)
  SDL_720x350 = 6; SDL_PC3270 = 6; HERCMONOHI = 6;
  (* all modes @ 800x600 *)
  SDL_800x600 = 7; SDL_SVGALO = 7; SVGA = 7;
  (* all modes @ 1024x768 *)
  SDL_1024x768 = 8; SDL_SVGAMED1 = 8;
  (* all modes @ 1152x900 *)
  SDL_1152x900 = 9; SDL_SVGAMED2 = 9;
  (* all modes @ 1280x1024 *)
  SDL_1280x1024 = 10; SDL_SVGAHI = 10;
  (* all modes @ 1366x768 *)
  SDL_1366x768 = 11; SDL_WXGA = 11;
  (* SDL_1920x1080 = XX, other *)
  SDL_USER = 12; SDL_FULLSCREEN = 13;

(* BGI error constants *)
const
  (* No error. *)
  grOk = 0;
  (* (BGI) graphics not installed (use InitGraph). *)
  grNoInitGraph = -1;
  (* Graphics hardware not detected. *)
  grNotDetected = -2;
  (* Device driver file not found. *)
  grFileNotFound = -3;
  (* Invalid device driver file. *)
  grInvalidDriver = -4;
  (* Not enough memory to load driver. *)
  grNoLoadMem = -5;
  (* Out of memory in scan fill. *)
  grNoScanMem = -6;
  (* Out of memory in flood fill. *)
  grNoFloodMem = -7;
  (* Font file not found. *)
  grFontNotFound = -8;
  (* Not enough memory to load font. *)
  grNoFontMem = -9;
  (* Invalid graphics mode for selected driver. *)
  grInvalidMode = -10;
  (* Graphics error (generic error); there is no room in
     the font table to register another font. (The font
     table holds up to 10 fonts, and only 4 are
     provided, so this error should not occur.)
  *)
  grError = -11;
  (* Graphics I/O error. *)
  grIOerror = -12;
  (* Invalid font file; the font header isn't recognized. *)
  grInvalidFont = -13;
  (* Invalid font number; the font number in the font
     header is not recognized
  *)
  grInvalidFontNum = -14;
  grInvalidVersion = -18;

(*
// libXbgi compatibility
const
  X11_CGALO = SDL_CGALO;
  X11_CGAHI = SDL_CGAHI;
  X11_EGA = SDL_EGA;
  X11 = SDL;
  X11_VGA = SDL_VGA;
  X11_640x480 = SDL_640x480;
  X11_HERC = SDL_HERC;
  X11_PC3270 = SDL_PC3270;
  X11_SVGALO = SDL_SVGALO;
  X11_800x600 = SDL_800x600;
  X11_SVGAMED1 = SDL_SVGAMED1;
  X11_1024x768 = SDL_1024x768;
  X11_SVGAMED2 = SDL_SVGAMED2;
  X11_1152x900 = SDL_1152x900;
  X11_SVGAHI = SDL_SVGAHI;
  X11_1280x1024 = SDL_1280x1024;
  X11_WXGA = SDL_WXGA;
  X11_1366x768 = SDL_1366x768;
  X11_USER = SDL_USER;
  X11_FULLSCREEN = SDL_FULLSCREEN;
*)

(* Bar constants *)
const
  TopOn = True;
  TopOff = False;

(* Clipping constants *)
const
  ClipOn = True;
  ClipOff = False;

type
  (* Forward declarations *)
  PPointType = ^PointType;
  PArcCoordsType = ^ArcCoordsType;
  PDate = ^Date;
  PFillSettingsType = ^FillSettingsType;
  PLineSettingsType = ^LineSettingsType;
  PPaletteType = ^PaletteType;
  PTextSettingsType = ^TextSettingsType;
  PViewPortType = ^ViewPortType;

  PointType = record
    x, y: Integer;
  end;

  ArcCoordsType = record
    x, y: Integer;
    xStart, yStart: Integer;
    xEnd, yEnd: Integer;
  end;

  Date = record
    da_year: Integer;
    da_day: Integer;
    da_mon: Integer;
  end;

  FillSettingsType = record
    pattern: Integer;
    color: Integer;
  end;

  (* TP 7 *)
  FillPatternType = array [1..8] of Byte;

  LineSettingsType = record
    lineStyle: Integer;
    uPattern: Cardinal;
    thickness: Integer;
  end;

  PaletteType = record
    size: Byte;
    colors: array [0..15] of ShortInt;
  end;

  TextSettingsType = record
    font: Integer;
    direction: Integer;
    charSize: Integer;
    horiz, vert: Integer;
  end;

  ViewPortType = record
    left, top: Integer;
    right, bottom: Integer;
    clip: Integer;
  end;

(* TP7 declaration: procedure Arc (X, Y: Integer; StAngle, EndAngle, Radius: Word); *)
procedure Arc(
  x, y: Integer;
  stAngle, endAngle: Integer;
  radius: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'arc';

(* TP7 declaration: procedure Bar (Xl, Yl, X2, Y2: Integer); *)
procedure Bar(
  left, top: Integer;
  right, bottom: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'bar';

(* TP7 declaration: procedure Bar3D (X1, Yl, X2, Y2: Integer; Depth: Word; Top: Boolean); *)
procedure Bar3D(
  left, top: Integer;
  right, bottom: Integer;
  depth: Integer;
  topFlag: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'bar3d';

(* TP7 declaration: procedure Circle (X, Y: Integer i Radius: Word); *)
procedure Circle(
  x, y: Integer;
  radius: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'circle';

(* TP7 declaration: procedure ClearDevice; *)
procedure ClearDevice();
  cdecl; external LIB_UBGI name LIB_FNPFX + 'cleardevice';

(* TP7 declaration: procedure ClearViewPort; *)
procedure ClearViewPort();
  cdecl; external LIB_UBGI name LIB_FNPFX + 'clearviewport';

(* TP7 declaration: procedure CloseGraph; *)
procedure CloseGraph();
  cdecl; external LIB_UBGI name LIB_FNPFX + 'closegraph';

(* TP7 declaration: procedure DetectGraph (var GraphDriver, GraphMode: Integer); *)
procedure DetectGraph(
  var graphDriver: Integer;
  var graphMode: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'detectgraph';

(* TP7 declaration: procedure DrawPoly (NumPoints: Word; var PolyPoints); *)
procedure DrawPoly(
  numPoints: Integer;
  polyPoints: PInteger);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'drawpoly';

(* TP7 declaration: procedure Ellipse (X, Y: Integer; StAngle, EndAngle: Word;
  YRadius, YRadius: Word); *)
procedure Ellipse(
  x, y: Integer;
  stAngle, endAngle: Integer;
  xRadius, yRadius: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'ellipse';

(* TP7 declaration: procedure FillEllipse (X, Y: Integer; XRadius, YRadius: Word); *)
procedure FillEllipse(
  x, y: Integer;
  xRadius, yRadius: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'fillellipse';

(* TP7 declaration: procedure FillPoly (NumPoints: Word; var PolyPoints); *)
procedure FillPoly(
  numPoints: Integer;
  polyPoints: PInteger);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'fillpoly';

(* TP7 declaration: procedure FloodFill (X, Y: Integer; Border: Word); *)
procedure FloodFill(
  x, y: Integer;
  border: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'floodfill';

(* N/A TP7 *)
function GetActivePage(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getactivepage';

(* TP7 declaration: procedure GetArcCoords (var ArcCoords: ArcCoordsType); *)
procedure GetArcCoords(
  var arcCoords: ArcCoordsType);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getarccoords';

(* TP7 declaration: procedure GetAspectRatio (var Xasp, Yasp: Word); *)
procedure GetAspectRatio(
  var xAsp: Integer;
  var yAsp: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getaspectratio';

(* TP7 declaration: function GetBkColor: Word; *)
function GetBkColor(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getbkcolor';

(* TP7 declaration: function GetColor: Word; *)
function GetColor(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getcolor';

(* TP7 declaration: function GetDefaultPalette (var Palette: PaletteType): PaletteType; *)
function GetDefaultPalette(): PPaletteType;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getdefaultpalette';

(* TP7 declaration: function GetDriverName: String; *)
function GetDriverName(): PAnsiChar;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getdrivername';

(* TP7 declaration: procedure GetFillPattern (var FillPattern: FillPatternType); *)
procedure GetFillPattern(
  pattern: PAnsiChar);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getfillpattern';

(* TP7 declaration: procedure GetFillSettings (var Filllnfo: FillSettingsType); *)
procedure GetFillSettings(
  var fillInfo: FillSettingsType);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getfillsettings';

(* TP7 declaration: function GetGraphMode: Integer; *)
function GetGraphMode(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getgraphmode';

(* TP7 declaration: procedure GetImage (Xl, Yl, X2, Y2: Integer; var BitMap); *)
procedure GetImage(
  left, top: Integer;
  right, bottom: Integer;
  bitmap: Pointer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getimage';

(* TP7 declaration: procedure GetLineSettings (var LineInfo: LineSettingsType); *)
procedure GetLineSettings(
  var lineInfo: LineSettingsType);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getlinesettings';

(* TP7 declaration: function GetMaxColor: Word; *)
function GetMaxColor(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getmaxcolor';

(* TP7 declaration: function GetMaxMode: Word; *)
function GetMaxMode(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getmaxmode';

(* TP7 declaration: function GetMaxX: Integer; *)
function GetMaxX(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getmaxx';

(* TP7 declaration: function GetMaxY: Integer; *)
function GetMaxY(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getmaxy';

(* TP7 declaration: function GetModeName( ModeNumber: Integer): String; *)
function GetModeName(
  modeNumber: Integer): PAnsiChar;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getmodename';

(* TP7 declaration: procedure GetModeRange (GraphDriver: Integer; var LoMode, HiMode: Integer); *)
procedure GetModeRange(
  graphDriver: Integer;
  var loMode, hiMode: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getmoderange';

(* TP7 declaration: procedure GetPalette (var Palette: PaletteType); *)
procedure GetPalette(
  var palette: PaletteType);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getpalette';

(* TP7 declaration: function GetPaletteSize: Integer; *)
function GetPaletteSize(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getpalettesize';

(* TP7 declaration: function GetPixel (X, Y: Integer): Word; *)
function GetPixel(
  x, y: Integer): Cardinal;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getpixel';

(* TP7 declaration: procedure GetTextSettings (var TextInfo: TextSettingsType); *)
procedure GetTextSettings(
  var texttypeinfo: TextSettingsType);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'gettextsettings';

(* TP7 declaration: procedure GetViewSettings (var ViewPort: ViewPortType); *)
procedure GetViewSettings(
  var viewPort: ViewPortType);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getviewsettings';

(* N/A TP7 *)
function GetVisualPage(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getvisualpage';

(* TP7 declaration: function GetX: Integer; *)
function GetX(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getx';

(* TP7 declaration: function GetY: Integer; *)
function GetY(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'gety';

(* TP7 declaration: procedure GraphDefaults *)
procedure GraphDefaults();
  cdecl; external LIB_UBGI name LIB_FNPFX + 'graphdefaults';

(* TP7 declaration: function GraphErrorMsg (ErrorCode: Integer): String; *)
function GraphErrorMsg(
  errorCode: Integer): PAnsiChar;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'grapherrormsg';

(*
var GraphFreeMemPtr: Pointer;
var GraphGetMemPtr: Pointer;
*)

(* TP7 declaration: function GraphResult: Integer; *)
function GraphResult(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'graphresult';

(* TP7 declaration: function ImageSize (Xl, Yl, X2, Y2: Integer): Word; *)
function ImageSize(
  left, top: Integer;
  right, bottom: Integer): Cardinal;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'imagesize';

(* TP7 declaration: procedure InitGraph (var GraphDriver: Integer; var GraphMode: Integer;
  PathToDriver: string); *)
procedure InitGraph(
  var graphDriver: Integer;
  var graphMode: Integer;
  pathToDriver: PAnsiChar);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'initgraph';

type
  UserDriverDetect = function(): Integer; cdecl;

(* TP7 declaration: InstallUserDriver (Name: String; AutoDetectptr: Pointer): Integer; *)
function InstallUserDriver(
  name: PAnsiChar;
  detect: UserDriverDetect): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'installuserdriver';

(* TP7 declaration: function InstallUserFont (FontFileName: String): Integer; *)
function InstallUserFont(fontFileName: PAnsiChar): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'installuserfont';

(* TP7 declaration: procedure Line (Xl, Yl, X2, Y2: Integer); *)
procedure Line(
  x1, y1: Integer;
  x2, y2: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'line';

(* TP7 declaration: procedure LineRel (Dx, Dy: Integer); *)
procedure LineRel(
  dx, dy: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'linerel';

(* TP7 declaration: procedure LineTo (X, Y: Integer); *)
procedure LineTo(
  x, y: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'lineto';

(* TP7 declaration: procedure MoveRel (Dx, Dy: Integer); *)
procedure MoveRel(
  dx, dy: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'moverel';

(* TP7 declaration: procedure MoveTo (X, Y: Integer); *)
procedure MoveTo(
  x, y: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'moveto';

(* TP7 declaration: procedure OutText (TextString: String); *)
procedure OutText(
  textString: AnsiString); overload;

procedure OutText(
  textString: PAnsiChar); overload;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'outtext';

(* TP7 declaration: procedure OutTextXY (X, Y: Integer; TextString: String); *)
procedure OutTextXY(
  x, y: Integer;
  textString: AnsiString); overload;

procedure OutTextXY(
  x, y: Integer;
  textString: PAnsiChar); overload;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'outtextxy';

(* TP7 declaration: procedure PieSlice (X, Y: Integer; StAngle, EndAngle, Radius: Word) *)
procedure PieSlice(
  x, y: Integer;
  stAngle, endAngle: Integer;
  radius: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'pieslice';

(* TP7 declaration: procedure PutImage (X, Y: Integer; var BitMap; BitBlt: Word); *)
procedure PutImage(
  left, top: Integer;
  bitmap: Pointer;
  op: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'putimage';

(* TP7 declaration: procedure Putpixel (X, Y: Integer; Pixel: Word); *)
procedure PutPixel(
  x, y: Integer;
  color: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'putpixel';

(* TP7 declaration: procedure Rectangle (Xl, Y1, X2, Y2: Integer); *)
procedure Rectangle(
  left, top: Integer;
  right, bottom: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'rectangle';

type
  RegisterDriverProc = procedure(); cdecl;

(* TP7 declaration: function RegisterBGIdriver (Driver: Pointer): Integer; *)
function RegisterBgiDriver(
  driver: RegisterDriverProc): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'registerbgidriver';

type
  RegisterFontProc = procedure(); cdecl;

(* TP7 declaration: function RegisterBGIfont (Font: Pointer): Integer; *)
function RegisterBgiFont(
  font: RegisterFontProc): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'registerbgifont';

(* TP7 declaration: procedure RestoreCrtMode; *)
procedure RestoreCrtMode();
  cdecl; external LIB_UBGI name LIB_FNPFX + 'restorecrtmode';

(* TP7 declaration: procedure Sector (X, Y: Integer; StAngle, EndAngle, XRadius, YRadius: Word); *)
procedure Sector(
  x, y: Integer;
  stAngle, endAngle: Integer;
  xRadius, yRadius: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'sector';

(* TP7 declaration: procedure SetActivePage (Page: Word); *)
procedure SetActivePage(
  page: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setactivepage';

(* TP7 declaration: procedure SetAllPalette (var Palette); *)
procedure SetAllPalette(
  var palette: PaletteType);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setallpalette';

(* TP7 declaration: procedure SetAspectRatio (Xasp, Yasp: Word): Word; *)
procedure SetAspectRatio(
  xAsp, yAsp: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setaspectratio';

(* TP7 declaration: procedure SetBkColor (ColorNum: Word); *)
procedure SetBkColor(
  color: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setbkcolor';

(* TP7 declaration: procedure SetColor (Color: Word); *)
procedure SetColor(
  color: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setcolor';

(* TP7 declaration: procedure SetFillPattern (Pattern: FillPatternType; Color: Word); *)
procedure SetFillPattern(
  uPattern: PAnsiChar;
  color: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setfillpattern';

(* TP7 declaration: procedure SetFillStyle (Pattern: Word; Color: Word); *)
procedure SetFillStyle(
  pattern: Integer;
  color: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setfillstyle';

(* TP7 declaration: procedure SetGraphBufSize (BufSize: Word); *)
function SetGraphBufSize(
  bufSize: Cardinal): Cardinal;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setgraphbufsize';

(* TP7 declaration: procedure SetGraphMode (Mode: Integer); *)
procedure SetGraphMode(
  mode: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setgraphmode';

(* TP7 declaration: procedure SetLineStyle (LineStyle: Word; Pattern: Word; Thickness: Word); *)
procedure SetLineStyle(
  lineStyle: Integer;
  upattern: Cardinal;
  thickness: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setlinestyle';

(* TP7 declaration: procedure SetPalette (ColorNum: Word; Color: Shortint); *)
procedure SetPalette(
  colorNum: Integer;
  color: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setpalette';

(* SDL extensions ?*)
procedure SetRGBPalette(
  colorNum, redValue, greenValue, blueValue: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setrgbpalette';

(* TP7 declaration: procedure SetTextJustify (Horiz, Vert: Word); *)
procedure SetTextJustify(
  horiz: Integer;
  vert: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'settextjustify';

(* TP7 declaration: procedure SetTextStyle (Font: Word; Direction: Word; CharSize: Word); *)
procedure SetTextStyle(
  font: Integer;
  direction: Integer;
  charSize: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'settextstyle';

(* TP7 declaration: procedure SetuserCharSize (MultX, Divx, MultY, DivY: Word); *)
procedure SetUserCharSize(
  multX, divX: Integer;
  multY, divY: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setusercharsize';

(* TP7 declaration: procedure SetViewPort (X1, Y1, X2, Y2: Integer; Clip: Boolean); *)
procedure SetViewPort(
  left, top: Integer;
  right, bottom: Integer;
  clip: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setviewport';

(* TP7 declaration: procedure SetVisualPage (Page: Word); *)
procedure SetVisualPage(
  page: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setvisualpage';

(* TP7 declaration: procedure SetWriteMode (WriteMode: Integer); *)
procedure SetWriteMode(
  mode: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setwritemode';

(* TP7 declaration: function TextHeight (TextString: String): Word; *)
function TextHeight(
  textString: AnsiString): Integer; overload;

function TextHeight(
  textString: PAnsiChar): Integer; overload;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'textheight';

(* TP7 declaration: function TextWidth (TextString: String): Word; *)
function TextWidth(
  textString: AnsiString): Integer; overload;

function TextWidth(
  textString: PAnsiChar): Integer; overload;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'textwidth';

(******************)
(* SDL extensions *)
(******************)

(*
  Returns the alpha (transparency) component of an ARGB colour
  in the ARGB palette.
*)
function ALPHA_VALUE(
  color: Integer): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'ALPHA_VALUE';

(* Returns the blue component of an ARGB colour in the ARGB palette. *)
function BLUE_VALUE(
  color: Integer): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'BLUE_VALUE';

(*
  Can be used as an argument for setcolor(), setbkcolor(),
  setfillpattern() and setfillstyle() to set a colour specifying
  its ARGB components. The colour is stored in ARGB_TMP_COL,
  and it is also copied in one of the following: ARGB_FG_COL,
  ARGB_BG_COL, ARGB_FILL_COL.

  Functions ALPHA_VALUE, BLUE_VALUE, GREEN_VALUE and RED_VALUE
  do not work on temporary colours.
*)
function COLOR(
  red, green, blue: Integer): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'COLOR';

(*
  Can be used as an argument for setcolor(), setbkcolor(),
  setfillpattern() and setfillstyle() to set a colour as ARGB integer.
  The colour is stored in ARGB_TMP_COL, and it is also copied
  in one of the following: ARGB_FG_COL, ARGB_BG_COL, ARGB_FILL_COL.

  Functions ALPHA_VALUE, BLUE_VALUE, GREEN_VALUE and RED_VALUE
  do not work on temporary colours.
*)
function COLOR32(
  color: UInt32): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'COLOR32';

(*
  Can be used to compose a 32 bit colour with r g b components;
  the alpha value is set to 0xFF. This macro is typically used
  to set values in memory buffers.
*)
function colorRGB(
  red, green, blue: Integer): UInt32; inline;

(* Returns the green component of an ARGB colour in the ARGB palette. *)
function GREEN_VALUE(
  color: Integer): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'GREEN_VALUE';

(*
  Returns 1 if the current drawing colour is a standard BGI colour
  (that is, not ARGB).
*)
function IS_BGI_COLOR(
  color: Integer): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'IS_BGI_COLOR';

(*
  Returns 1 if the current drawing colour is ARGB.
  The color argument is actually redundant.
*)
function IS_RGB_COLOR(
  color: Integer): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'IS_RGB_COLOR';

(* Returns the red component of an ARGB colour in the ARGB palette. *)
function RED_VALUE(
  color: Integer): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'RED_VALUE';

(*
  Plots a point at (x,y) using the current drawing colour.
  This function may be faster than putpixel().
*)
procedure _PutPixel(
  x, y: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + '_putpixel';

(* Closes the window whose identifier is id. *)
procedure CloseWindow(
  id: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'closewindow';

(*
  Waits for 'millisec' milliseconds. In 'slow mode', a screen refresh
  is performed. If an event occurs during the delay, this function
  returns 1, otherwise 0. Use eventtype to get the last event.
*)
procedure EDelay(
  milliSec: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'edelay';

(*
  Returns 1 if an event (mouse click, key press, or QUIT) has occurred.
*)
function Event(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'event';

(*
  Returns the type of the last event;
  either SDL KEYPRESS or SDL MOUSEBUTTONDOWN.
*)
function EventType(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'eventtype';

(*
  Copies the contents of the active window to buffer,
  which must be a getmaxy()+1 x getmaxx()+1 array of Uint32
  in ARGB format.
*)
procedure GetBuffer(
  buffer: PUint32);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getbuffer';

(*
  Returns the integer id of the current window.
*)
procedure GetCurrentWindow();
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getcurrentwindow';

(*
  Waits for a keypress, mouse click, or SDL QUIT event,
  and returns the code of the key, mouse button, or QUIT.
*)
function GetEvent(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getevent';

(*
  Waits for the left mouse button to be clicked and released.
*)
procedure GetLeftClick();
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getleftclick';

(*
  Copies the y-th screen line to linebuffer,
  which must be a getmaxx()+1 array of Uint32 in ARGB format.
*)
procedure GetLineBuffer(
  y: Integer;
  linebuffer: PUInt32);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getlinebuffer';

(*
  Waits for the middle mouse button to be clicked and released.
*)
procedure GetMiddleClick();
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getmiddleclick';

(*
  Returns the maximum possible height for a new window
  (actual screen height in pixels).
*)
function GetMaxHeight(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getmaxheight';

(*
  Returns the maximum possible width for a new window
  (actual screen width in pixels).
*)
function GetMaxWidth(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'getmaxwidth';

(*
  Returns the code of the mouse button that was clicked,
  or 0 if none was clicked.
*)
function MouseClick(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'mouseclick';

(*
  Returns the X coordinate of the last mouse click.
*)
function MouseX(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'mousex';

(*
  Returns the Y coordinate of the last mouse click.
*)
function MouseY(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'mousey';

(*
  Copies buffer to the current window.
  Buffer must be a getmaxy()+1 x getmaxx()+1 array of Uint32
  in ARGB format. This function is faster than direct pixel
  manipulation.
*)
procedure PutBuffer(
  buffer: PUint32);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'putbuffer';

(*
  Copies linebuffer to the 'y' coordinate in the current window.
  linebuffer must be a getmaxx()+1 array of Uint32 in ARGB format.
  This function is faster than direct pixel manipulation.
*)
procedure PutLineBuffer(
  y: Integer;
  buffer: PUint32);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'putlinebuffer';

(*
  Reads a .bmp file and displays it immediately at (x1, y1).
  If (x2, y2) are not 0, the bitmap is stretched to fit
  the rectangle x1, y1 - x2, y2; otherwise, the bitmap is
  clipped as necessary.
*)
procedure ReadImageFile(
  fileName: PAnsiChar;
  left, top: Integer;
  right, bottom: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'readimagefile';

(*
  Updates the screen contents, i.e. displays all graphics.
*)
procedure Refresh();
  cdecl; external LIB_UBGI name LIB_FNPFX + 'refresh';

(*
  Resets the window title title and position to (x, y)
  of an existing window identified by id.
  x and y can be set to SDL_WINDOWPOS_CENTERED or SDL_WINDOWPOS_UNDEFINED.
  If either x or y is -1, the position parameters are ignored.
*)
procedure ResetWinOptions (
  id: Integer;
  title: PAnsiChar;
  x, y: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'resetwinoptions';
(*
  Initialises the palette to the standard 16 colours.
  If the environment variable SDL_BGI_PALETTE equals BGI,
  the first 16 colours will use the same RGB values as Turbo C 2.01;
  otherwise, a brighter palette will be used.
*)
procedure InitPalette ();
  cdecl; external LIB_UBGI name LIB_FNPFX + 'initpalette';

(*
  Initializes the graphics system, opening a widthxheight window.
  If either width or height is 0, then SDL_FULLSCREEN will be used.
  Multiple windows can be created, unless a fullscreen window
  is already present.

  The user must update the screen as needed using refresh(),
  or use sdlbgiauto().
*)
procedure InitWindow(
  width, height: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'initwindow';

(* Returns 1 if the 'kind' mouse button was clicked. *)
function IsMouseClick(
  kind: Integer): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'ismouseclick';

(*
  Resizes the ARGB palette to 'newSize';
  returns - 0 if successful, 1 otherwise.
  The initial size of the ARGB palette is 4096.
*)
function ResizePalette (
  newSize: Uint32): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'resizepalette';

(*
NOT IMPLEMENTED
procedure SetWinTitle(
  id: Integer;
  title: PAnsiChar);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setwintitle';
*)

(*
  Triggers automatic screen refresh.
  Note: it may not work on some graphics cards.
*)
procedure SdlBgiAuto();
  cdecl; external LIB_UBGI name LIB_FNPFX + 'sdlbgiauto';

(*
  Triggers “fast mode” even if the graphics system was opened
  with initgraph().
  Calling refresh() is needed to display graphics.
*)
procedure SdlBgiFast();
  cdecl; external LIB_UBGI name LIB_FNPFX + 'sdlbgifast';

(*
  Triggers “slow mode” even if the graphics system was opened with initwindow().
  Calling refresh() is not needed.
*)
procedure SdlBgiSlow();
  cdecl; external LIB_UBGI name LIB_FNPFX + 'sdlbgislow';

(*
  Sets alpha transparency for colour col to alpha (0-255);
  0 means full transparecy, 255 full opacity.
  setalpha() works with colours in both palettes.
*)
procedure SetAlpha(
  col: Integer;
  alpha: Byte);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setalpha';

(*
  Sets the current background colour using the n-th colour entry
  in the ARGB palette.
*)
procedure SetBkRGBcolor(
  n: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setbkrgbcolor';

(*
  Sets the blend mode to be used with screen refresh.
  'blendMode' can be SDL_BLENDMODE_NONE (default in 'slow mode')
  or SDL_BLENDMODE_BLEND. The latter enables alpha blending.
*)
procedure SetBlendMode(
  blendMode: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setblendmode';

(* Sets the current active window to 'id'. *)
procedure SetCurrentWindow(
  id: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setcurrentwindow';

(*
 Sets the current drawing colour using the n-th colour entry
 in the ARGB palette.
*)
procedure SetRGBcolor(
  n: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setrgbcolor';

(*
  Sets the window title 'title', the initial position to (x, y), and SDL2
  flags OR'ed together. x and y can be set to SDL_WINDOWPOS_CENTERED or
  SDL_WINDOWPOS_UNDEFINED. If title is an empty string, the window title
  is set to the default value SDL_bgi.
  If either x or y is -1, the position parameters are ignored.
  If flags is -1, the parameter is ignored; otherwise, only the values
  SDL_WINDOW_FULLSCREEN, SDL_WINDOW_FULLSCREEN_DESKTOP,
  SDL_WINDOW_SHOWN, SDL_WINDOW_HIDDEN, SDL_WINDOW_BORDERLESS,
  and SDL_WINDOW_MINIMIZED can be applied.
*)
procedure SetWinOptions(
  title: PAnsiChar;
  x, y: Integer;
  flags: Int32);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'setwinoptions';

(*
  Opens an error message box with the specified message.
  The message box waits for the user to click on the OK button.
*)
procedure ShowErrorBox(
  msg: PAnsiChar);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'showerrorbox';

(*
  Opens an information message box with the specified message.
  The message box waits for the user to click on the OK button.
*)
procedure ShowInfoBox(
  msg: PAnsiChar);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'showinfobox';

(* Swaps the current active and the current visual graphics pages. *)
function SwapBuffers(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'swapbuffers';

(*
  Writes a .bmp file from the screen rectangle
  defined by (left, top) - (right, bottom).
*)
procedure WriteImageFile(
  fileName: PAnsiChar;
  left, top: Integer;
  right, bottom: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'writeimagefile';

(* Not graphical *)
(*
  Returns 1 when a key is pressed, excluding special keys
  (Ctrl, Shift, etc.); in 'slow mode', a screen refresh is performed.
  If an SDL_QUIT event occurs, QUIT is returned.
*)
function KbHit(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'kbhit';

(*
  Returns 1 when any key is pressed, including special keys
  (Ctrl, Shift, etc.) in 'slow mode', a screen refresh is performed.
  If an SDL QUIT event occurs, QUIT is returned.
*)
function XKbHit(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'xkbhit';

(* TP7 declaration (Crt unit): function KeyPressed: Boolean; *)
function KeyPressed(): Boolean; inline;

(*
  Waits for a key and returns its ASCII code.
  In 'slow mode', a screen refresh is performed.
  If an SDL_QUIT event occurs, QUIT is returned.
*)
function GetCh(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'bgi_getch';

function ReadKey(): Integer;
  cdecl; external LIB_UBGI name LIB_FNPFX + 'bgi_getch';

(*
  Waits for msec milliseconds. In 'slow mode', a screen refresh
  is performed. Events that occur during the delay are disregarded.

  TP7 declaration (Crt unit): procedure Delay (Ms: Word);
*)
procedure Delay(
  msec: Integer);
  cdecl; external LIB_UBGI name LIB_FNPFX + 'delay';

implementation

function KeyPressed(): Boolean;
begin
  Result := KbHit() <> 0;
end;

procedure OutText(
  textString: AnsiString);
begin
  if Length(textString) > 0 then OutText(PAnsiChar(textString));
end;

procedure OutTextXY(
  x, y: Integer;
  textString: AnsiString);
begin
  if Length(textString) > 0 then OutTextXY(x, y, PAnsiChar(textString));
end;

function TextHeight(
  textString: AnsiString): Integer;
begin
  if Length(textString) > 0 then
    Result := TextHeight(PAnsiChar(textString))
  else
    Result := 0;
end;

function TextWidth(
  textString: AnsiString): Integer;
begin
  if Length(textString) > 0 then
    Result := TextWidth(PAnsiChar(textString))
  else
    Result := 0;
end;

function colorRGB(
  red, green, blue: Integer): UInt32;
begin
  Result := $ff000000 or (red shl 16) or (green shl 8) or blue;
end;

end.