{------------------------------------------------------------------------}
{ PROJECT   : Turtle graphics using BGI                                  }
{ MODULE    : TURTLE.PAS                                                 }
{------------------------------------------------------------------------}
{ GOAL      : Source code of the main unit                               }
{ VERSION   : 1.1e (e)English comments                                   }
{------------------------------------------------------------------------}
{ REVISIONS : added fast trigo calculations                              }
{           : added TurtleBox (Color) for demo purposes                  }
{------------------------------------------------------------------------}
{ AUTHOR    : P.Pollet INSA   12/12/92                                   }
{------------------------------------------------------------------------}

UNIT TURTLE;

{$DEFINE FASTTRIGO}  { set to true for faster Trigonometric calculations}
                     { leave it on . Was used for debugging purposes    }

INTERFACE

uses Graph,  { for BGI calls }
     Crt;    { just for a call to Delay }

const
  { angles in degrees for standard headings }
  North = 0;
  East  = 90;
  South = 180;
  West  = 270;


procedure GraphOff;
  {Turn off graphic mode }

procedure GraphOn(driver,mode:integer;path:string);
 { go to graphic mode specified by Driver,Mode            }
 { works only with Std Borland drivers that can be loaded }
 { via InitGraph and not InstallUserDriver. See examples  }
 { for non standard BGI                                   }
procedure InitTurtle;
 { renitialize the turtle. Internally called by GraphOn.  }
 { MUST BE CALLED with UserInstalled BGI after swapping   }
 { to graph mode.                                         }
 {   Put the turtle center of screen.                     }
 {   Set up  turtle woindow to full screen depending of   }
 {       the maximal allowed pixels coordinates           }
 {   Set Turtle and Standard line colors to white         }
 {   Turtle is initially Hidden,no wrap, no delay         }
 {   Pen is down                                          }

procedure ClearScreen;
 { erase all the graphic screen using BGI calls }

procedure FillScreen (Color:Byte);
 { fill the turtle Window, not the screen with Color      }
 { to erase to turtle Windows use FillScreen(0)           }

procedure Back(Dist: Integer);
 { move the turtle back of Dist pixels                    }
 { to clear the Turtle Window, use FillScreen(0)          }

procedure Forwd(Dist: Integer);
 { move the turtle forward of Dist pixels }

function  Heading: Integer;
 { return the current Heading within -359 to 359 }
 { 0 = toward North. 90 =East ....               }

procedure HideTurtle;
 { hide the turtle }

procedure Home;
  { go center of turtle window, Heading=0 North}

procedure NoWrap;
  { Do not roll the drawing on the other side of the screen }
  { if the turtle goes offscreen. }

procedure PenDown;
   { From now, all moves will leaves a track behind }

procedure PenUp;
   { From now, all moves will not leaves a track behind }

procedure SetHeading(Angle: Integer);
   { Set the new heading of turtle. Internally adusted within }
   { -359..359 degrees. Redraw the turtle if visible }

procedure SetPenColor(Color: Integer);
   { change the color  of the turtle ,of its track              }
   { and the BGI standard color.                                }
   { To draw using BGI in a different color, use Graph.SetColor }

procedure SetPosition(X,Y: Integer);
   { place the turtle at position X,Y, relative to the }
   { turtle window origin.(center of the window) }

procedure ShowTurtle;
   { show the turtle }

procedure TurnLeft(Angle: Integer);
   { add Angle to the heading. redraw if visible }

procedure TurnRight(Angle: Integer);
   { subtract Angle from heading. redraw if visible }

procedure TurtleDelay(Delay: integer);
   { Set delay time in Milliseconds between every move }

procedure TurtleWindow(X,Y,W,H: Integer);
   { define the screen area where the turtle is clipped }
   { X,Y are TopLerft corner coordinates. W is horizontal Width }
   { H is vertical Height }

function  TurtleThere: Boolean;
   { Return true if Turtle is visible *AND* within Turtle window}

procedure Wrap;
  { Do roll the drawing on the other side of the screen }
  { if the turtle goes offscreen. }

function  Xcor: Integer;
  { return current X position in Turtle coordinates}

function  Ycor: Integer;
  { return current Y position in Turtle coordinates}


procedure TurtleBox (aColor:Byte);
  { draw a box in Color round the current turtle window}

{----------------------------------------------- REDEF GRAPH  }
{ to allow the use of standard graph routines,with the turtle }
{ graphics, it is capital to HIDE the turtle before any access}
{ to screen and to show it afterwards. Otherwise the XOR mode }
{ used to animate the turtle will not work properly if a non  }
{ turtle line has crossed the turtle image ...                }
{-------------------------------------------------------------}
{ we have simply redefined here the BGI calls that access the }
{ screen to hide the turtle during calls to the original      }
{ routines..                                                  }
{-------------------------------------------------------------}
{ ********** WARNING WARNING WARNING WARNING WARNING *********}
{ this works only if you include the TURTLE unit AFTER the    }
{ GRAPH unit in any USES clause                               }
{-------------------------------------------------------------}

{ *** Screen, viewport, page routines *** }
procedure ClearDevice;
procedure ClearViewPort;

{ *** point-oriented routines *** }
procedure PutPixel(X, Y : integer; Pixel : word);
function  GetPixel(X, Y : integer) : word;

{ *** line-oriented routines *** }
procedure LineTo(X, Y : integer);
procedure LineRel(Dx, Dy : integer);
procedure MoveTo(X, Y : integer);
procedure MoveRel(Dx, Dy : integer);
procedure Line(x1, y1, x2, y2 : integer);

{ *** polygon, fills and figures *** }
procedure Rectangle(x1, y1, x2, y2 : integer);
procedure Bar(x1, y1, x2, y2 : integer);
procedure Bar3D(x1, y1, x2, y2 : integer; Depth : word; Top : boolean);
procedure DrawPoly(NumPoints : word; var PolyPoints);
procedure FillPoly(NumPoints : word; var PolyPoints);
procedure FloodFill(X, Y : integer; Border : word);

{ *** arc, circle, and other curves *** }
procedure Arc(X, Y : integer; StAngle, EndAngle, Radius : word);
procedure Circle(X, Y : integer; Radius : word);
procedure Ellipse(X, Y : integer;
                  StAngle, EndAngle : word;
                  XRadius, YRadius  : word);
procedure FillEllipse(X, Y : integer;
                      XRadius, YRadius  : word);
procedure PieSlice(X, Y : integer; StAngle, EndAngle, Radius : word);
procedure Sector(X, Y : Integer;
                 StAngle, EndAngle,
                 XRadius, YRadius : word);


{ *** bit-image routines *** }
procedure GetImage(x1, y1, x2, y2 : integer; var BitMap);
procedure PutImage(X, Y : integer; var BitMap; BitBlt : word);

{ *** text routines *** }
procedure OutText(TextString : string);
procedure OutTextXY(X, Y : integer; TextString : string);

{------------------------------------------------------------------}
{ In future versions of BGI drivers, add here new screen accessing }
{ calls to be trapped .                                            }
{------------------------------------------------------------------}

IMPLEMENTATION

{----------------------------------------------------------------------}
{ PRIVATE PART OF THE UNITS. NONE OF THE CALLS BELOW ARE VISIBLE IN    }
{ THE INTERFACE.                                                       }
{----------------------------------------------------------------------}

var G_maxX,              { storage of Graph.GetMaxX.   set in InitTurtle }
    G_MaxY,              { storage of Graph.GetMaxY.   set in InitTurtle }
    G_MaxColor:integer;  { storage of Graph.GetMaxColor set in InitTurtle }

    T_Wrap     :Boolean; { flag to indicate whether we wrap or not}
    T_PenDown  :Boolean; { flag to indicate whether we draw or Move}
    T_Visible  :Boolean; { flag to indicate whether the Turtle is visible}
    T_PenColor :Byte;    { current Pen Color = Value AND G_maxColor  }
    T_Delay    :Integer; { delay in Ms after every move }
    T_Heading  :Integer; { current heading 0=North. }
    T_PosX,              { current Turtle position X,Y }
    T_PosY     :Integer; { in TURTLE Coordinates  }
    T_WinLoX,            { Bottom Left on Turtle Window }
    T_WinLoY,            {   in SCREEN coordinates      }
    T_WinHiX,            { Top Right of Turtle Window   }
    T_WinHiY   :Integer; {   in SCREEN coordinates      }
    T_WinOrgX,           { origin of the Turtle Window  }
    T_WinOrgY   :Integer;{   in SCREEN coordinates      }


{$IFDEF  FASTTRIGO}

{ table of 10000*sine of angles from 0 to 359 }

const Sinus:array[0..359] of Integer=(
     0,   175,   349,   523,   698,   872,  1045,  1219,  1392,  1564,
  1736,  1908,  2079,  2250,  2419,  2588,  2756,  2924,  3090,  3256,
  3420,  3584,  3746,  3907,  4067,  4226,  4384,  4540,  4695,  4848,
  5000,  5150,  5299,  5446,  5592,  5736,  5878,  6018,  6157,  6293,
  6428,  6561,  6691,  6820,  6947,  7071,  7193,  7314,  7431,  7547,
  7660,  7771,  7880,  7986,  8090,  8192,  8290,  8387,  8480,  8572,
  8660,  8746,  8829,  8910,  8988,  9063,  9135,  9205,  9272,  9336,
  9397,  9455,  9511,  9563,  9613,  9659,  9703,  9744,  9781,  9816,
  9848,  9877,  9903,  9925,  9945,  9962,  9976,  9986,  9994,  9998,
 10000,  9998,  9994,  9986,  9976,  9962,  9945,  9925,  9903,  9877,
  9848,  9816,  9781,  9744,  9703,  9659,  9613,  9563,  9511,  9455,
  9397,  9336,  9272,  9205,  9135,  9063,  8988,  8910,  8829,  8746,
  8660,  8572,  8480,  8387,  8290,  8192,  8090,  7986,  7880,  7771,
  7660,  7547,  7431,  7314,  7193,  7071,  6947,  6820,  6691,  6561,
  6428,  6293,  6157,  6018,  5878,  5736,  5592,  5446,  5299,  5150,
  5000,  4848,  4695,  4540,  4384,  4226,  4067,  3907,  3746,  3584,
  3420,  3256,  3090,  2924,  2756,  2588,  2419,  2250,  2079,  1908,
  1736,  1564,  1392,  1219,  1045,   872,   698,   523,   349,   175,
     0,  -175,  -349,  -523,  -698,  -872, -1045, -1219, -1392, -1564,
 -1736, -1908, -2079, -2250, -2419, -2588, -2756, -2924, -3090, -3256,
 -3420, -3584, -3746, -3907, -4067, -4226, -4384, -4540, -4695, -4848,
 -5000, -5150, -5299, -5446, -5592, -5736, -5878, -6018, -6157, -6293,
 -6428, -6561, -6691, -6820, -6947, -7071, -7193, -7314, -7431, -7547,
 -7660, -7771, -7880, -7986, -8090, -8192, -8290, -8387, -8480, -8572,
 -8660, -8746, -8829, -8910, -8988, -9063, -9135, -9205, -9272, -9336,
 -9397, -9455, -9511, -9563, -9613, -9659, -9703, -9744, -9781, -9816,
 -9848, -9877, -9903, -9925, -9945, -9962, -9976, -9986, -9994, -9998,
-10000, -9998, -9994, -9986, -9976, -9962, -9945, -9925, -9903, -9877,
 -9848, -9816, -9781, -9744, -9703, -9659, -9613, -9563, -9511, -9455,
 -9397, -9336, -9272, -9205, -9135, -9063, -8988, -8910, -8829, -8746,
 -8660, -8572, -8480, -8387, -8290, -8192, -8090, -7986, -7880, -7771,
 -7660, -7547, -7431, -7314, -7193, -7071, -6947, -6820, -6691, -6561,
 -6428, -6293, -6157, -6018, -5878, -5736, -5592, -5446, -5299, -5150,
 -5000, -4848, -4695, -4540, -4384, -4226, -4067, -3907, -3746, -3584,
 -3420, -3256, -3090, -2924, -2756, -2588, -2419, -2250, -2079, -1908,
 -1736, -1564, -1392, -1219, -1045,  -872,  -698,  -523,  -349,  -175);
 

Function FastSin (A:integer):LongInt;
{ fast table look Sinus*10000 in LongInt    }
{ Requires the Mod 360 for Runtime error in }
{ drawing the turtle with Heading < -240    }
begin
 If A>=0 then FastSin:=Sinus[A mod 360]
 else FastSin:=-Sinus[-A mod 360];
end;

Function FastCos (A:integer):LongInt;
{ nothing really great here....             }
begin
  FastCos:=FastSin(A+90)
end;

{$ELSE}
   { the formulae we used to build the Table above }
   Function FastSin(A:Integer):LongInt;
   begin
      FastSin:=Round(sin(A*pi/180)*10000);
   end;

   Function FastCos(A:Integer):LongInt;
   begin
     FastCos:=Round(Cos(A*pi/180)*10000);
   end;

{$ENDIF}

{--------------------------------------------------------}
{ Conversion of Turtle Coordinates to Screen coordinates }
{--------------------------------------------------------}
Function ToScreenX (Xt:Integer):Integer;
begin
  ToScreenX:=T_WinOrgX +Xt
end;

Function ToScreenY (Yt:Integer):Integer;
{ Turtle Y axis goes up, and Screen y axis goes down }
begin
  ToScreenY:=T_WinOrgY -Yt
end;

{--------------------------------------------------------}
{ Reset the Turtle to standard settings.....             }
{ Reset all but the turtle window                        }
{--------------------------------------------------------}
Procedure ResetTurtle;
begin
  T_PenColor:=WHITE and G_MaxColor;
  SetColor(T_PenColor);
  T_Wrap:=false;
  T_PenDown:=True;
  T_Visible:=false;
  T_Delay:=0;
  Home;
end;

{--------------------------------------------------------}
{ Draw the Turtle as a triangle in XOR mode              }
{ may be modified to change Turtle aspect                }
{--------------------------------------------------------}
Procedure DrawTurtle(OnOff:Boolean);
var Sc:Integer;

    procedure DrawTriangle (Xc,Yc,Angle:Integer);
    Const L=15;
    var Xt,Yt,X,Y:integer;
    begin
      Xt:=Xc+ (LongInt(L)*FastCos(Angle) div 10000);
      Yt:=Yc+ (LongInt(L)*FastSin(Angle) div 10000);
      Xt:=ToScreenX(Xt);
      Yt:=ToScreenY(Yt);
      { Watch out for infinite loops if Graph. is omitted   }
      { MoveTo of the unit is redefined to call _HideTurtle }
      { that will call DrawTurtle(false)......              }
      Graph.MoveTo(Xt,Yt);
      X:=Xc+ (LongInt(L)*FastCos(Angle+120) div 10000);
      Y:=Yc+ (LongInt(L)*FastSin(Angle+120) div 10000);
      Graph.LineTo(ToScreenX(X),ToScreenY(Y));
      Graph.LineTo(ToScreenX(Xc),ToScreenY(Yc));
      X:=Xc+ (LongInt(L)*FastCos(Angle-120) div 10000);
      Y:=Yc+ (LongInt(L)*FastSin(Angle-120) div 10000);
      Graph.LineTo(ToScreenX(X),ToScreenY(Y));
      Graph.LineTo(Xt,Yt);
      Graph.MoveTo(ToScreenX(Xc),ToScreenY(Yc));
    end;

begin
  SetWriteMode(XorPut);
  DrawTriangle(T_PosX,T_PosY,90-T_Heading);
  SetWriteMode(CopyPut);
end;

{--------------- helper procedures to save some time------------}

{ Hide the Turtle if not visible. Called by the redefined BGI calls}
{ and the public HideTurtle.. DO Not Modify the flag T_Visible     }
Procedure _HideTurtle;
begin
  if T_Visible then DrawTurtle(False)
end;

Procedure _ShowTurtle;
begin
  if T_Visible then DrawTurtle(True)
end;

{ Redraw the turtle if visible called at the end of all Turtle drawing }
{ procedures. Waste some time if Turtel Delay is set                   }
Procedure _ShowTurtleDelay;
begin
  if T_Visible then
    begin
      DrawTurtle(True);
      if T_Delay >0 then Delay(T_Delay)
   end
end;

{ return true in the point X,Y is within the rectangle      }
{ defined by X1,Y1 and Y1,Y2 .regardless of the coordinates }
{ system (SCREEN or TURTLE )                                }
Function PtInRect(X,Y,X1,Y1,X2,Y2:Integer):Boolean;
begin
  PtInRect:=(X>=X1) and (X<=X2) and (Y>=Y1) and (Y <=Y2)
end;


{----------------------------------------------------------------------}
{ END OF PRIVATE PART..................................................}
{----------------------------------------------------------------------}



{----------------------------------------------------------------------}
{ CODE OF THE PUBLIC PROCEDURES AND FUNCTIONS OF THIS UNIT             }
{----------------------------------------------------------------------}


procedure GraphOff;
begin
  CloseGraph;
end;

procedure GraphOn(driver,mode:integer;path:string);
var ErrorCode:Integer;
const EGApalette :PaletteType=
  (size:16;
   colors:
    (EGABLACK,EGABLUE,EGAGREEN,EGACYAN,EGARED,EGAMAGENTA,EGABROWN,
    EGALIGHTGRAY,EGADARKGRAY,EGALIGHTBLUE,EGALIGHTGREEN,EGALIGHTCYAN,
    EGALIGHTRED,EGALIGHTMAGENTA,EGAYELLOW,EGAWHITE  ));

   procedure Abort (Msg:String);
   begin
     RestoreCRTMode;
     CloseGraph;
     Writeln(Msg);
     Writeln (' press enter to leave ...');
     Readln;
     Halt(1);
   end;

begin
  InitGraph(driver,mode,Path);
  ErrorCode := GraphResult;               { error? }
  if ErrorCode <> grOk then
     Abort('Graphics error: '+ GraphErrorMsg(ErrorCode));
  G_MaxColor := GetMaxColor;  { Get the maximum allowable drawing color }
  EgaPalette.Size:=G_MaxColor;{ adjust length of standard  palette      }
  setallpalette(EGApalette);  { inform BGI                              }
  InitTurtle;                 { Set up the Turtle                       }
end;

Procedure InitTurtle;
begin
  G_MaxColor := GetMaxColor;  { Get the maximum allowable drawing color }
  G_MaxX := GetMaxX;          { Get screen resolution values }
  G_MaxY := GetMaxY;
  TurtleWindow(G_MaxX div 2,G_MaxY div 2,G_MaxX,G_MaxY);
  ResetTurtle;
end;


procedure ClearScreen;
begin
  _HideTurtle;
  Graph.ClearViewport;
  _ShowTurtle;
  Home
end;

procedure FillScreen (Color:Byte);
begin
  _HideTurtle;
  SetFillstyle(Solidfill,Color);
  Graph.Bar3d(0,0,2*T_WinHiX,2*T_WinHiY,0,false);
  _ShowTurtle;
  Home
end;

procedure Back(Dist: Integer);
begin
  Forwd(-Dist)
end;

procedure Forwd(Dist: Integer);
var NewX,NewY,NewXs,NewYs:Integer;

    procedure DoWrap(var X,Y:Integer);
    var Xs,Ys,Xn,Yn:Integer;
    begin
      Xs:=X;Ys:=Y;
      Xn:=T_PosX;Yn:=T_PosY;
      While X <T_WinLoX do begin Inc(X,-T_WinLoX+T_WinHiX); Xn:=T_WinHiX end;
      While X >T_WinHiX do begin Dec(X,-T_WinLoX+T_WinHiX); Xn:=T_WinLoX end;
      While Y <T_WinLoY do begin Inc(Y,-T_WinLoY+T_WinHiY); Yn:=T_WinHiY end;
      While Y >T_WinHiY do begin Dec(Y,-T_WinLoY+T_WinHiY); Yn:=T_WinLoY end;
      If (Xs <>X) Or (Ys <>Y) then
        begin
          Xn:=ToScreenX(Xn);Yn:=ToScreenY(Yn);
          Graph.MoveTo(Xn,Yn);
        end;
    end;

begin
  _HideTurtle;
  NewX:= T_PosX+ (LongInt(Dist)*FastCos(90-T_Heading)) div 10000;
  NewY:= T_PosY+ (LongInt(Dist)*FastSin(90-T_Heading)) div 10000;
  If T_Wrap then DoWrap (NewX,NewY);
  NewXs:=ToScreenX(NewX);NewYs:=ToScreenY(NewY);
  If T_PenDown then
     Graph.LineTo(ToScreenX(NewX),ToScreenY(NewY))
  else
     Graph.MoveTo(ToScreenX(NewX),ToScreenY(NewY));
  T_PosX:=NewX;
  T_PosY:=NewY;
  _ShowTurtleDelay
end;

function  Heading: Integer;
begin
  Heading:=T_Heading
end;

procedure HideTurtle;
begin
 If T_Visible then
   begin
     _HideTurtle;
     T_Visible:=False
   end
end;

procedure Home;
begin
  _HideTurtle;
  T_PosX:=0;
  T_PosY:=0;
  Graph.MoveTo(ToScreenX(0),ToScreenY(0));
  T_Heading:=0;
  _ShowTurtle;
end;

procedure NoWrap;
begin
  T_Wrap:=False
end;

procedure PenDown;
begin
  T_PenDown:=True
end;

procedure PenUp;
begin
  T_PenDown:=false
end;

procedure SetHeading(Angle: Integer);
begin
  _HideTurtle;
  T_Heading:=Angle mod 360;  { avoid runtime errors in fastSin calls}
  _ShowTurtleDelay
end;

procedure SetPenColor(Color: Integer);
begin
  _HideTurtle;
  T_PenColor:=Color and G_MaxColor;
  SetColor(T_PenColor);
  _ShowTurtle
end;

procedure SetPosition(X,Y: Integer);
begin
 _HideTurtle;
  T_PosX:=X;
  T_PosY:=Y;
  Graph.MoveTo(ToScreenX(X),ToScreenY(Y));
  _ShowTurtleDelay
end;

procedure ShowTurtle;
begin
  If Not T_Visible then
    begin
       T_Visible :=True;
       _ShowTurtleDelay
    end
end;

procedure TurnLeft(Angle: Integer);
begin
  SetHeading(T_Heading - Angle);
end;

procedure TurnRight(Angle: Integer);
begin
  TurnLeft(-Angle)
end;

procedure TurtleDelay(Delay: integer);
begin
  T_Delay:=Delay
end;

procedure TurtleWindow(X,Y,W,H: Integer);
begin
  T_WinOrgX:=X;
  T_WinOrgY:=Y;
  T_WinLoX:= - W div 2;
  T_WinLoY:= - H div 2;
  T_WinHiX:= + W div 2;
  T_WinHiY:= + H div 2;
end;

function  TurtleThere: Boolean;
begin
  TurtleThere:=T_Visible and PtInRect(T_PosX,T_PosY,T_WinLoX,T_WinLoY,T_WinHiX,T_WinHiY)
end;

procedure Wrap;
begin
 T_Wrap:=True
end;

function  Xcor: Integer;
begin
 XCor:=T_PosX
end;

function  Ycor: Integer;
begin
 YCor:=T_PosY
end;

procedure TurtleBox (aColor:Byte);
var Save:Integer;
begin
  Save:=GetColor;
  SetColor(aColor);
  Rectangle(ToScreenX(T_WinLoX),
            ToScreenY(T_WinHiY),
            ToScreenX(T_WinHiX),
            ToScreenY(T_WinLoY));
  SetColor(Save)
end;

{ HIDE THE TURTLE DURING STANDARD BGI CALLS }

procedure ClearDevice;
begin  _HideTurtle;Graph.ClearDevice ;_ShowTurtle end;
procedure ClearViewPort;
begin  _HideTurtle;Graph.ClearViewPort ;_ShowTurtle end;
{ *** point-oriented routines *** }
procedure PutPixel(X, Y : integer; Pixel : word);
begin  _HideTurtle;Graph.PutPixel(X,Y,Pixel) ;_ShowTurtle end;
function  GetPixel(X, Y : integer) : word;
begin  _HideTurtle;GetPixel:=Graph.GetPixel(X,Y) ;_ShowTurtle end;

procedure LineTo(X, Y : integer);
begin  _HideTurtle;Graph.LineTo(X,Y) ;_ShowTurtle end;
procedure LineRel(Dx, Dy : integer);
begin  _HideTurtle;Graph.LineRel(Dx,Dy) ;_ShowTurtle end;
procedure MoveTo(X, Y : integer);
begin  _HideTurtle;Graph.MoveTo(X,Y) ;_ShowTurtle end;
procedure MoveRel(Dx, Dy : integer);
begin  _HideTurtle;Graph.MoveRel(Dx,Dy) ;_ShowTurtle end;
procedure Line(x1, y1, x2, y2 : integer);
begin  _HideTurtle;Graph.Line(x1,y1,x2,y2) ;_ShowTurtle end;

procedure Rectangle(x1, y1, x2, y2 : integer);
begin  _HideTurtle;Graph.Rectangle(x1,y1,x2,y2) ;_ShowTurtle end;
procedure Bar(x1, y1, x2, y2 : integer);
begin  _HideTurtle;Graph.Bar(x1,y1,x2,y2) ;_ShowTurtle end;
procedure Bar3D(x1, y1, x2, y2 : integer; Depth : word; Top : boolean);
begin  _HideTurtle;Graph.Bar3D(x1,y1,x2,y2,Depth,Top) ;_ShowTurtle end;
procedure DrawPoly(NumPoints : word; var PolyPoints);
begin  _HideTurtle;Graph.DrawPoly(NumPoints,PolyPoints) ;_ShowTurtle end;
procedure FillPoly(NumPoints : word; var PolyPoints);
begin  _HideTurtle;Graph.FillPoly(NumPoints,PolyPoints) ;_ShowTurtle end;
procedure FloodFill(X, Y : integer; Border : word);
begin  _HideTurtle;Graph.FloodFill(X,Y,Border) ;_ShowTurtle end;

procedure Arc(X, Y : integer; StAngle, EndAngle, Radius : word);
begin  _HideTurtle;Graph.Arc(X,Y,StAngle,EndAngle,Radius) ;_ShowTurtle end;
procedure Circle(X, Y : integer; Radius : word);
begin  _HideTurtle;Graph.Circle(X,Y,Radius) ;_ShowTurtle end;
procedure Ellipse(X, Y : integer; StAngle, EndAngle : word; XRadius, YRadius  : word);
begin  _HideTurtle;Graph.Ellipse(X,Y,StAngle,EndAngle,XRadius,YRadius) ;_ShowTurtle end;
procedure FillEllipse(X, Y : integer;  XRadius, YRadius  : word);
begin  _HideTurtle;Graph.FillEllipse(X,Y,XRadius,YRadius) ;_ShowTurtle end;
procedure PieSlice(X, Y : integer; StAngle, EndAngle, Radius : word);
begin  _HideTurtle;Graph.PieSlice(X,Y,StAngle,EndAngle,Radius) ;_ShowTurtle end;
procedure Sector(X, Y : Integer; StAngle, EndAngle, XRadius, YRadius : word);
begin  _HideTurtle;Graph.Sector(X,Y,StAngle,EndAngle,XRadius,YRadius) ;_ShowTurtle end;

procedure GetImage(x1, y1, x2, y2 : integer; var BitMap);
begin  _HideTurtle;Graph.GetImage(X1,Y1,X2,Y2,BitMap); _ShowTurtle end;
procedure PutImage(X, Y : integer; var BitMap; BitBlt : word);
begin  _HideTurtle;Graph.PutImage(X,Y,BitMap,BitBlt); _ShowTurtle end;

procedure OutText(TextString : string);
begin  _HideTurtle;Graph.OutText(TextString); _ShowTurtle end;
procedure OutTextXY(X, Y : integer; TextString : string);
begin  _HideTurtle;Graph.OutTextXY(X,Y,TextString); _ShowTurtle end;


end.

