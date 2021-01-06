program exus;
{$IF Defined(FPC)}{$MODE Delphi}{$ENDIF}
{$APPTYPE Console}

uses ubgi;

var
  gd, gm: Integer;
  info: String;

begin
  gd := DETECT; gm := VGAHi;

  InitGraph(gd, gm, '');
  SetColor(BLUE);
  SetBkColor(WHITE);

  info := 'SDL_bgi & Object Pascal';
  SetTextStyle(SimplexFont, HorizDir, 0);
  OutText(info);
  ReadKey();

  CloseGraph();
end.