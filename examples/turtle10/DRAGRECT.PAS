{------------------------------------------------------------------------}
{ PROJECT   : Turtle graphics using BGI                                  }
{ MODULE    : DRAGRECT.PAS                                               }
{------------------------------------------------------------------------}
{ GOAL      : Demo program: Draw the Clover leaf dragon                  }
{ VERSION   : 1.0                                                        }
{------------------------------------------------------------------------}
{ REVISIONS :                                                            }
{------------------------------------------------------------------------}
{ AUTHOR    : P.Pollet INSA  16/06/91                                    }
{------------------------------------------------------------------------}

program DragonCarre;

uses Turtle,Graph,crt;
{..$DEFINE SVGA}      { turn on for SVGA driver }

{$IFDEF SVGA}
   {$I SVGA.INI}
{$ENDIF}


procedure DrR1(N,L:integer);
begin
  If N<1 then
       Forwd(L)
  else
    begin
      DrR1(N-1,L div 3);
      TurnRight(90);
      DrR1(N-1,L div 3);
      TurnLeft(90);
      DrR1(N-1,L div 3);
      TurnLeft(90);
      DrR1(N-1,L div 3);
      TurnRight(90);
      DrR1(N-1,L div 3);
    end
end;

procedure DrR2(N,L:integer);
begin
  (*Readln;*)
  If N<1 then
       Forwd(L)
  else
    begin
      DrR2(N-1,L div 3);
      TurnRight(90);
      DrR2(N-1,L div 3);
      TurnLeft(90);
      DrR2(N-1,L div 3);
      TurnLeft(90);
      DrR2(N-1,L div 3);
      DrR2(N-1,L Div 3);
      TurnLeft(90);
      DrR2(N-1,L div 3);
      TurnLeft(90);
      DrR2(N-1,L div 3);
      PenUp;
      TurnLeft(90);
      Forwd (L div 3);
      PenDown;
      DrR2(N-1,L div 3);
    end
end;


Procedure Dragon(N,L:Integer);
{ apply the generator to a square }
begin
  ClearScreen;
  Home;
  PenUp;
  Back(150);
  PenDown;
  DrR1(N,L);
  TurnRight(90);
  DrR1(N,L);
  TurnRight(90);
  DrR1(N,L);
  TurnRight(90);
  DrR1(N,L);
end;

var N,L:integer;
begin
   {$IFDEF SVGA}
    Initialize;
    InitTurtle;
  {$ELSE}
    graphon(VGA,VGAHI,'');
  {$ENDIF}
 Wrap;
 Repeat
  OutTextXY(8,8,' N ,L ? ');
  Readln(N); Readln(L);
  ShowTurtle;
  If N >1 Then
    begin
     Dragon(N,L);
     write(^G,^G)
    end;
  HideTurtle;
Until N <1;
graphoff
end.


