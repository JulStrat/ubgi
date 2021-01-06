{------------------------------------------------------------------------}
{ PROJECT   : Turtle graphics using BGI                                  }
{ MODULE    : VONKOCH.PAS                                                }
{------------------------------------------------------------------------}
{ GOAL      : Demo. draw the VonKoch snowflake using Turtle graphics     }
{ VERSION   : 1.0e                                                       }
{------------------------------------------------------------------------}
{ REVISIONS :                                                            }
{------------------------------------------------------------------------}
{ AUTHOR    : P.Pollet INSA  16/06/91                                    }
{------------------------------------------------------------------------}

program VonKoch;

uses Graph,Turtle,crt;

{$DEFINE SVGA}   { turn off for standard EGAVGA driver }


{$IFDEF SVGA}
   {$I SVGA.INI}   { specific init file for SVGA driver }
{$ENDIF}



procedure Vk(N,L:integer);
begin
  If N<1 then
       Forwd(L)
  else
    begin
      Vk(N-1,L div 3);
      TurnLeft(60);
      Vk(N-1,L div 3);
      TurnRight(120);
      Vk(N-1,L div 3);
      TurnLeft(60);
      Vk(N-1,L div 3)
    end
end;

Procedure SnowFlake(N,L:Integer);
{ apply the Vk generator to a triangle, thus draw the snowflake }
begin
  Home; Wrap; ClearScreen;
  TurnRight(90);
  PenUp;
  Back(150);
  PenDown;
  Vk(N,L);
  TurnRight(120);
  Vk(N,L);
  TurnRight(120);
  Vk(N,L);
end;

var N,L:integer;
begin
   {$IFDEF SVGA}
    Initialize;
    InitTurtle;
  {$ELSE}
    graphon(VGA,VGAHI,'');
  {$ENDIF}

 SetPenColor(WHITE);
 Repeat
  OutTextXY(8,8,' N ,L ? ');    { get number of days and initial length }
  Readln(N); Readln(L);
  ShowTurtle;
  If N >1 Then
    begin
     SnowFlake(N,L);
     write(^G,^G)
    end;
   HideTurtle;
 Until N <1;
 GraphOff
end.


