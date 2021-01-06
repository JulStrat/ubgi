{------------------------------------------------------------------------}
{ PROJECT   : Turtle graphics using BGI                                  }
{ MODULE    :  TREEREC.PAS                                               }
{------------------------------------------------------------------------}
{ GOAL      : Demo program for drawing recursive simple trees            }
{ VERSION   : 1.0                                                        }
{------------------------------------------------------------------------}
{ REVISIONS :                                                            }
{------------------------------------------------------------------------}
{ AUTHOR    : P.Pollet INSA  14/06/91                                    }
{------------------------------------------------------------------------}

program TreeRec;

uses graph,Turtle;

var Color:integer;

procedure Tree (Ainit,A,alpha,K,N:integer);
begin
  (*readln;*)
  Color:=Color+1;
  If Color=4 then Color:=1;
  setpencolor(Color);
  If (A>0) and (N>0) then
    begin
      K:=Random(Ainit div 5)+1;
      Forwd(A);
      TurnLeft(Alpha);
      Tree(Ainit,A-K,alpha,K,N-1);
      TurnRight(2*Alpha);
      K:=Random(Ainit div 5 )+1;
      Tree(Ainit,A-K,alpha,K,N-1);
      TurnLeft(Alpha);
      ForWd(-A);
    end
 end;
 var i:integer;


begin
  graphon(VGA,VGAHI,'c:\tp\bgi');
  PenUp;
  Home;
  Forwd(-100);
  PenDown;
  Color:=0;
  ShowTurtle;
      Tree(25,55,20,18,6) ;
  readln;
  GraphOff
end.
