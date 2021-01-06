{------------------------------------------------------------------------}
{ PROJECT   : Turtle graphics using BGI                                  }
{ MODULE    :  FOREST.PAS                                                }
{------------------------------------------------------------------------}
{ GOAL      : Demo: Draw a forest of 25 random "nice trees"              }
{ VERSION   : 1.0                                                        }
{------------------------------------------------------------------------}
{ REVISIONS :                                                            }
{------------------------------------------------------------------------}
{ AUTHOR    : P.Pollet INSA  17/06/91                                    }
{------------------------------------------------------------------------}

program Forest;
{$R-}
uses graph,Turtle,crt;

{..$DEFINE SVGA}

{$IFDEF SVGA}
   {$I SVGA.INI}
{$ENDIF}


procedure Fruit;
{ some red cherries }
var I:Byte;
begin
   If Random(2)=1  then
     begin
       SetPenColor(RED);
       For I:=1 to 8 do
         begin
           Forwd(2);TurnRight(45)
         end
     end
end;

procedure Trunk (Width, Len:integer);
begin
  If Width>0 then
    begin
       Forwd(Width div 2);
       TurnLeft(90) ;Forwd(Len);
       TurnLeft(90) ;Forwd(Width);
       TurnLeft(90) ;Forwd(Len);
       TurnLeft(90) ;Forwd(Width div 2 );
       Trunk(Width-2,Len)
     end
end;




procedure Tree (Len,Angle,N:integer;
                  Kleft,KCenter,KRight:Real;
                  Curve,
                  Delta:integer;
                  Alternate:Boolean);

begin
  If  (N>0) then
    begin
      If N > 4 then
        begin
          SetPenColor(BROWN);
          TurnRight(90);
          Trunk(N-1,Len);
          TurnLeft(90);
          Forwd(Len);
        end
     else
        begin
          SetPenColor(GREEN);
          Forwd(Len)
        end;
     TurnLeft(Angle);
     Tree(Round(Len*KLeft),Angle-Delta,N-1,KLeft,KCenter,KRight,Curve,Delta,Alternate);
     If not Alternate or odd(N) then  TurnRight(Angle+Curve)
                          else  TurnRight(Angle-Curve);
     Tree(Round(Len*KCenter),Angle-Delta,N-1,KLeft,KCenter,KRight,Curve,Delta,Alternate);
     If not Alternate or  odd(N) then  TurnRight(Angle-Curve)
                          else  TurnRight(Angle+Curve);
     Tree(Round(Len*KRight),Angle-Delta,N-1,KLeft,KCenter,KRight,Curve,Delta,Alternate);
     TurnLeft(Angle);
     If N > 4 then
        begin
          SetPenColor(BROWN);
          TurnLeft(90);
          Trunk(N-2,Len);
          TurnRight(90);
          Back(Len);
          (*If Readkey=' ' then ;*)
        end
     else
       begin
         SetPenColor(GREEN);
         Back(Len);
       end;
     If n=2 Then Fruit
   end
end;

var i,L,Na,N:integer;
    Ch:char;

begin

  Randomize;
  {$IFDEF SVGA}
    Initialize;
    InitTurtle;
  {$ELSE}
    graphon(VGA,VGAHI,'');
  {$ENDIF}
  Repeat
    ClearScreen;
    PenUp;
    Home;
    Forwd(-150);
    PenDown;
    (*ShowTurtle;*)
    Na:=25;

    For I:=1 to Na do
      begin
        L:= Random(40+i) +40;
      If L> 25 then N:=Random(2)+6
               else N:=Random(2)+5;
      SetPosition(Random(GetMaxX-L)-(GetMaxX-L) div 2,
                  -(100 div 2) div Na *I-(100 div 2) );
      Tree(L,
             Random(35)+25,
             N,
             (Random(20)+45)/100,
             (Random(20)+55)/100,
             (Random(20)+45)/100,
             Random(10)-4,
             Random(30)-15,
             Random(2)=1);
    end;
  Ch:=ReadKey;
 until (Ch=Char(27));
 GraphOff
end.
