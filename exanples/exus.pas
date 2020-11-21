program exus;
{$IF Defined(FPC)}{$MODE Delphi}{$ENDIF}
uses ubgi;

var
  gd, gm: Integer;
  info: String;

begin  
  gd := DETECT; gm := VGA;
  
  initgraph(gd, gm, '');
  setcolor(BLUE);
  setbkcolor(WHITE);
  cleardevice();

  info := 'SDL_bgi & Object Pascal';
  settextstyle(BOLDFONT, HORIZDIR, 0);
  OutText(info);
  
  getch();
  cleardevice();
  closegraph();
  
end.