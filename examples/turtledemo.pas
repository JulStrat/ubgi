(* turtledemo.pas   -*- Object Pascal -*-
 * 
 * turtledemo.c written by Guido Gonzato <guido.gonzato at gmail.com>
 * July 2017
 * 
 * turtledemo.pas written by Ioulianos Kakoulidis
 * January 2021
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 * 
 *)
program turtledemo;
{$IF Defined(FPC)}{$MODE Delphi}{$ENDIF}

uses turtle, ubgi, SysUtils, Math;

procedure pause ();
var
  stop: Integer;
begin
  // pause and exit if right click
  stop := 0;

  hideturtle ();
  setcolor (YELLOW);
  outtextxy (0, 10,
    '=== Left click to continue, right click to exit ===');
  refresh ();
  
  while stop = 0 do
  begin
    if ismouseclick (WM_LBUTTONDOWN) <> 0 then
      stop := 1;
    if ismouseclick (WM_RBUTTONDOWN) <> 0 then 
    begin
      closegraph ();
      Halt (1);
    end;
  end;
  
  while ismouseclick (WM_LBUTTONDOWN) <> 0 do
    ;
end;

procedure turtle_hello ();
var
  len, c, angle: Integer;
begin
  len := 20;
  c := 0;
  angle := 0;
  
  cleardevice ();
  setcolor (GREEN);
  outtextxy (0, 0,
    'Hello, I''m the turtle! Arrow keys to move around, ESC to stop.');
  refresh ();
  
  home ();
  wrap ();
  setheading (angle);
  turtlesize (40);
  showturtle ();
  refresh ();
  
  repeat
    c := getch ();
    
    if c = KEY_UP then 
      forwd (len)
    else
      if c = KEY_LEFT then 
        turnleft (5)
      else
        if c = KEY_RIGHT then
          turnright (5);
    
    refresh ();
    
  until (c = KEY_ESC);
  
  hideturtle ();
  nowrap ();
  refresh ();
end;

procedure koch (len, level: Integer);
var
  newlen: Integer;
begin
  if 0 = level then
    forwd (len)
  else 
  begin
    newlen := Trunc (ceil (len / 3.0));
    koch (newlen, level - 1);
    turnleft (60);
    koch (newlen, level - 1);
    turnright (120);
    koch (newlen, level - 1);
    turnleft (60);
    koch (newlen, level - 1);
  end;
end;

procedure tree (len, level: Integer);
begin
  if 0 <> level then
  begin
    setcolor (level);
    forwd (len);
    turnleft (45);
    tree (len * 6 div 10, level - 1);
    turnleft (90);
    tree (len * 3 div 4, level - 1);
    turnleft (45);
    penup ();
    forwd (len);
    pendown ();
  end;
end;

procedure sq_koch (len, level: Integer);
begin
  if 0 = level then
    forwd (len)
  else 
  begin
    sq_koch (len div 4, level - 1);
    turnleft (90);
    sq_koch (len div 4, level - 1);
    turnright (90);
    sq_koch (len div 4, level - 1);
    turnright (90);
    sq_koch (len div 4, level - 1);
    sq_koch (len div 4, level - 1);
    turnleft (90);
    sq_koch (len div 4, level - 1);
    turnleft (90);
    sq_koch (len div 4, level - 1);
    turnright (90);
    sq_koch (len div 4, level - 1);
  end;
end;

procedure star (len: Integer);
var
  i: Integer;
begin
  for i := 0 to 4 do
  begin
    forwd (len);
    turnright (144);
  end;
end;

procedure star_6 (len: Integer);
var
  i: Integer;
begin
  for i := 0 to 5 do
  begin
    forwd (len);
    turnright (120);
    forwd (len);
    turnleft (60);
  end;
end;

procedure star_20 (len: Integer);
var
  i: Integer;
begin
  for i := 0 to 19 do 
  begin
    forwd (len);
    turnright (162);
  end;
end;

procedure hilbert_left (len, level: Integer); forward;
procedure hilbert_right (len, level: Integer); forward;

procedure hilbert_left (len, level: Integer);
var
  bearing: Integer;
begin
  if level > 0 then
  begin
    bearing := heading ();
    turnleft (90);
    hilbert_right (len, level - 1);
    
    setheading (bearing);
    forwd (len);
    
    bearing := heading ();
    hilbert_left (len, level - 1);
    
    setheading (bearing);
    turnleft (90);
    forwd (len);
    
    bearing := heading ();
    turnright (90);
    hilbert_left (len, level - 1);
    
    setheading (bearing);
    turnleft (90);
    forwd (len);
    
    bearing := heading ();
    turnleft (90);
    hilbert_right (len, level - 1);
    setheading (bearing);
  end;
end;

procedure hilbert_right (len, level: Integer);
var
  bearing: Integer;
begin
  if level > 0 then
  begin    
    bearing := heading ();
    turnright (90);
    hilbert_left (len, level - 1);
    
    setheading (bearing);
    forwd (len);
    
    bearing := heading ();
    hilbert_right (len, level - 1);
    
    setheading (bearing);
    turnright (90);
    forwd (len);
    
    bearing := heading ();
    turnleft (90);
    hilbert_right (len, level - 1);
    
    setheading (bearing);
    turnright (90);
    forwd (len);
    
    bearing := heading ();
    turnright (90);
    hilbert_left (len, level - 1);
    setheading (bearing);
  end;
end;

function powerof2 (ex: Integer): Integer;
var
  i: Integer;
begin
  Result := 1;
  for i := 0 to ex - 1 do
    Result := 2 * Result;
end;

var
  i, l, x, y, xc, stop: Integer;

begin
  stop := 0;

  initwindow (1024, 768);
  setbkcolor (BLACK);
  setcolor (GREEN);

  turtle_hello ();
  pause ();
  
  // Koch
  for i := 0 to 5 do
  begin
    cleardevice ();
    setcolor (GREEN);
    outtextxy (0, 0, 'Standard Koch curve:');
    setposition (0, getmaxy () div 2);
    setheading (T_EAST);
    setcolor (i + 1);
    koch (getmaxx () + 1, i);
    refresh ();
    delay (200);
  end;
  pause ();

  // fractal tree
  for i := 0 to 13 do 
  begin
    cleardevice ();
    setcolor (GREEN);
    outtextxy (0, 0, 'Fractal tree:');
    setposition (getmaxx () * 4 div 10, getmaxy ());
    setheading (T_NORTH);
    tree (getmaxy () div 3, i);
    refresh ();
    delay (100);
  end;
  pause ();

  // square Koch
  for i := 0 to 5 do
  begin
    cleardevice ();
    setcolor (GREEN);
    outtextxy (0, 0, 'Square Koch curve:');
    setposition (0, getmaxy () div 2);
    setheading (T_EAST);
    setcolor (i + 1);
    sq_koch (getmaxx () + 1, i);
    refresh ();
    delay (200);
  end;
  pause ();

  // rotating square
  cleardevice ();
  setcolor (GREEN);
  outtextxy (0, 0, 'Rotating square:');
  home ();
  setheading (0);
  
  l := getmaxx () div 2;
  
  for i := 1 to l - 1 do
  begin
    setcolor (1 + (i mod 15));
    forwd (i);
    turnright (89);
    refresh ();
    delay (5);
    if kbhit () <> 0 then
      break;
  end;
  hideturtle ();
  pause ();
  
  // Hilbert
  cleardevice ();
  xc := getmaxx () div 2;
  x := xc;
  setcolor (GREEN);
  
  for i := 1 to 7 do
  begin
    cleardevice ();
    l := getmaxy () div powerof2 (i);
    Inc(x, l div 2);
    y := l div 2;
    setposition (x, y);
    setheading (T_WEST);
    hilbert_left (l, i);
    refresh ();
    outtextxy (0, 0, Format('Hilbert curve at level %d', [i]));
    refresh ();
    delay (200);
  end;
  hideturtle ();
  pause ();

  cleardevice ();
  outtextxy (0, 0, 'PRESS A KEY TO EXIT:');
  refresh ();
  
  stop := 0;
  // stars
  while stop = 0 do
  begin
    setposition (random (getmaxx ()), random (getmaxy ()));
    setheading (random (360));
    setcolor (1 + random (15));
    star (random (80));
    star_6 (random (20));
    star_20 (random (40));
    refresh ();
    delay (50);
    if xkbhit () <> 0 then 
      stop := 1;
  end;
  
  closegraph ();  
end.
