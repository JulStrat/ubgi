# ubgi

Object Pascal bindings for [SDL_bgi](http://libxbgi.sourceforge.net) library.

Repository structure - 
- `ubgi.pas` - Pascal API unit.
- `bin` - Dynamic Windows libraries v2.4.1 .
- `examples` - Pascal port of original `fonts.c` example.
- `include` - C API v2.4.1 header file.

## Usage example

```
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
```

## Building example

Embarcadero Delphi compiler - 
```
dcc64 -B -U../ fonts.pas
```
## Screenshots

fonts

<img src="https://github.com/JulStrat/ubgi/blob/master/examples/fonts.png">

plasma

<img src="https://github.com/JulStrat/ubgi/blob/master/examples/plasma.png">

psychedelia

<img src="https://github.com/JulStrat/ubgi/blob/master/examples/psychedelia.png">