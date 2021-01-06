{------------------------------------------------------------------------}
{ PROJECT   : Turtle graphics using BGI                                  }
{ MODULE    : TURTLEDM.PAS                                               }
{------------------------------------------------------------------------}
{ GOAL      : Test program. Code (C) Borland Int'l TurboPascal V3.0      }
{           : most of the code of this program, but initialisation part  }
{           : was provided as a demo in Turbopascal V3.0 package         }
{ VERSION   : 1.0                                                        }
{------------------------------------------------------------------------}
{ REVISIONS :                                                            }
{------------------------------------------------------------------------}
{ AUTHOR    : P.Pollet INSA  14/06/91                                    }
{------------------------------------------------------------------------}

program PlayTurtle;

USES GRAPH,TURTLE,CRT;
 const
   TurtleSpeed = 50;

 type
   ToggleCommands = (PenOn, WrapOn, TurtleOn);

 var
   ToggleRay    : array[PenOn..TurtleOn] of boolean;
   Magnitude,
   Color,
   CurentPalette: Integer;

 Procedure Init;
 var  Toggle: ToggleCommands;
 begin
   Magnitude := 0;
   Color     := 0;
   for Toggle := PenOn to TurtleOn do
     ToggleRay[Toggle]  := true;
 end;

 Procedure PlayWithTurtle;

 var
   InKey:     Char;
   FunctionKey:  Boolean;

   procedure NewScreen;
   begin
       ClearScreen;
       TurtleWindow(GetMaxX div 2,(GetMaxY div 2)-10, GetMaxX-100,GetMaxY-60);
       TurtleBox(Blue);
       OutTextXY(25,GetMaxY-30,'SPEED:0-9  TOGGLES:,(L)ig,(T)urtle,(C)ol.'+
                             'TURN : F1,F2, HOME : +, (E)rase');
       Showturtle;
       home;
       Wrap;
       Magnitude := 0;
   end; { NewScreen }

   Function GetKey(var FunctionKey: Boolean): char;
   var ch: char;
   begin
     Ch:=ReadKey;
     If (Ch = #0) AND KeyPressed Then  { Function key }
     begin
       Ch:=ReadKey;
       FunctionKey := true;
     end
     else FunctionKey := false;
     GetKey := Ch;
   end;


   Procedure TurtleDo(InKey : char; FunctionKey : boolean);
   const
     NorthEast = 45;
     SouthEast = 135;
     SouthWest = 225;
     NorthWest = 315;

     procedure DoFunctionCommand(FunctionKey: char);
     begin
       case FunctionKey of
         'H': SetHeading(North);      { up arrow        }
         'P': SetHeading(South);      { down arrow      }
         'M': SetHeading(East);       { left arrow      }
         'K': SetHeading(West);       { right arrow     }
         'I': SetHeading(NorthEast);  { PgUp            }
         'Q': SetHeading(SouthEast);  { PgDn            }
         'G': SetHeading(NorthWest);  { Home            }
         'O': SetHeading(SouthWest);  { End             }
         '<': SetHeading(Heading+5);  { F1              }
         ';': SetHeading(Heading-5);  { F2              }
       end
     end { Do function command };

   begin
     If FunctionKey then DoFunctionCommand(Upcase(InKey))
     else
     case upcase(InKey) of
       'P': begin
              ToggleRay[PenOn] := NOT ToggleRay[PenOn];
              case ToggleRay[PenOn] of
                true  : PenUp;
                false : PenDown;
              end; (* case *)
            end;
       'L': begin
              ToggleRay[WrapOn] := NOT ToggleRay[WrapOn];
              case ToggleRay[WrapOn] of
                true  : Wrap;
                false : NoWrap;
              end; (* case *)
            end;
       'T': begin
              ToggleRay[TurtleOn] := NOT ToggleRay[TurtleOn];
              case ToggleRay[TurtleOn] of
                true  : ShowTurtle;
                false : HideTurtle;
              end; (* case *)
            end;
       '+': Home;
       'C': begin
              Color := succ(color) Mod (GetMaxColor+1);
              SetPenColor(Color);
            end;
       'E': NewScreen;
       '0'..'9': Magnitude := Sqr(ord(inkey) - ord('0'));
     end;   { case }
   end; (* TurtleDo *)

 begin
  NewScreen;
  repeat
    TurtleDelay(TurtleSpeed);
    repeat
      if Magnitude <> 0 then forwd(Magnitude);
    until KeyPressed;
    Inkey := GetKey(FunctionKey);
    TurtleDo(InKey, FunctionKey);
  until UpCase(Inkey) in [#27, ^C];
 end;  { PlayWithTurtle }

begin
  Init;
  GraphOn(EGA,EGAHI,'');
  PlayWithTurtle;
  ClearScreen;
  GraphOff;
end.
