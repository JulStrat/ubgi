program linktest;
{$IF Defined(FPC)}{$MODE Delphi}{$ENDIF}
{$APPTYPE Console}

uses ubgi;

var
  x, y: Integer;
  p: RGBPaletteType;

begin
  WriteLn('SizeOf(PaletteType) = ', SizeOf(PaletteType));
  WriteLn('SizeOf(RGBPaletteType) = ', SizeOf(RGBPaletteType));
  if ParamCount = 0 then
    Exit;

  _PutPixel(0, 0);
  FPutPixel(0, 0);
  WriteLn(ColorName(1));
  WriteLn(RGBPALETTE(1));
  GetRGBPalette(@p, 1);
  WriteLn(GetRGBPaletteSize());
  SetAllRGBPalette(@p);
  CopySurface(nil, 0, 0, 0, 0);
  WriteLn(EDelay(1));
  WriteLn(GetCurrentWindow());
  GetRightClick();
  WriteLn(GetClick());
  WriteLn(DoubleClick());
  GetMouseClick(WM_LBUTTONDOWN, x, y);
  GetScreenSize(x, y);
  WriteLn(GetWindowWidth(), ' ', GetWindowHeight());
  WriteLn(InitWindow(10, 10));
  SetWinTitle(0, 'linktest');
  SwapBuffers();
  WriteLn(LastKey(), ' ', KDelay(1));
end.
