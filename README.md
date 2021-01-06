# ubgi

Object Pascal bindings for [SDL_bgi](http://libxbgi.sourceforge.net) library.

Repository structure - 
- `ubgi.pas` - Pascal API unit.
- `bin` - Dynamic Windows libraries v2.4.2.
- `examples` - Pascal port of some original examples.
- `include` - C API v2.4.2 header file.

## Usage example

```
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
```

## Building example

Embarcadero Delphi compiler - 
```
dcc64 -B -U.. exus.pas
```

Free Pascal compiler - 
```
fpc -B -Fu.. exus.pas
```

## Screenshots

fonts

<img src="https://github.com/JulStrat/ubgi/blob/master/examples/fonts.png">

plasma

<img src="https://github.com/JulStrat/ubgi/blob/master/examples/plasma.png">

psychedelia

<img src="https://github.com/JulStrat/ubgi/blob/master/examples/psychedelia.png">

kaleido

<img src="https://github.com/JulStrat/ubgi/blob/master/examples/kaleido.png">

turtledemo

<img src="https://github.com/JulStrat/ubgi/blob/master/examples/turtledemo.png">
