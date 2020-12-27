(* psychedelia.pas  -*- Pascal -*-
 * 
 * Variation on 'plasma.c', as described here:
 * https://lodev.org/cgtutor/plasma.html
 * By Guido Gonzato, 2018 - 2019.
 * By I. Kakoulidis, December 2020.
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

program psychedelia;
{$IF Defined(FPC)}{$MODE Delphi}{$ENDIF}
{$APPTYPE Console}
//{$POINTERMATH On}

uses ubgi, Math, SysUtils;

const
  WIDTH = 800;
  HEIGHT = 600;

var
  col,
  i, x, y,
  r, g, b,      // colour indices
  d1, d2, d3,   // used to change the plasma parameters
  use_buffer,
  counter, stop, maxx, maxy: Integer;

  k1, k2, k3: single; // plasma parameters
  // screen buffer. NOTE: height x width!  
  buffer: array [0..HEIGHT-1, 0..WIDTH-1] of UInt32;
  time: UInt32;

function SDL_GetTicks(): UInt32;
  cdecl; external 'SDL2' name 'SDL_GetTicks';

begin
  use_buffer := 1;
  counter := 0;
  
  // parameters are allowed to range from 0 to 256

  k1 := 128.;
  k2 := 32.;
  k3 := 64.;
  d1 := -1;
  d2 := 1;
  d3 := 1;
  
  initwindow (WIDTH, HEIGHT);
  setbkcolor (BLACK);
  refresh ();
  
  // make a palette
  for i := 0 to 254 do
    setrgbpalette (i, 
           Trunc(abs((128 - 127*sin(i*PI/32)))),
           Trunc(abs((128 - 127*sin(i*PI/64)))),
           Trunc(abs((128 - 127*sin(i*PI/128)))) );
  
  stop := 0;
  
  showinfobox ('Left click to switch between'#13'putbuffer() and putpixel()');
  
  time := SDL_GetTicks ();
  
  repeat

    maxx := getmaxx ();
    maxy := getmaxy ();
    
    for y := 0 to maxy-1 do
    begin
      for x := 0 to maxx-1 do
      begin
      
        col := Trunc (
          sin (x / 50) * k1 +
          sin (y / 40) * k2 +
          sin ((x + y) / 30) * k3);
    
        while col > 255 do
          col := col - 256;
        while col < 0 do
          col := col + 256;
    
        r := RED_VALUE (col);
        g := GREEN_VALUE (col);
        b := BLUE_VALUE (col);
    
        if 1 = use_buffer then
          buffer [y][x] := colorRGB (r, g, b)
        else
          putpixel (x, y, COLOR(r, g, b));
      
      end; // for x
    end; // for y
    
    if 1 = use_buffer then
      putbuffer (@buffer[0]);
    refresh ();
    Inc(counter);
    
    if SDL_GetTicks () >= (time + 1000) then
    begin
      WriteLn(Format('%d iterations/second', [counter]));
      time := SDL_GetTicks ();
      counter := 0;
    end;

    // change the parameters
    k1 := k1 + d1;
    if (k1 < 2) or (k1 > 255) then
      d1 := -d1;
    k2 := k2 + d2;
    if (k2 < 2) or (k2 > 255) then
      d2 := -d2;
    k3 := k3 + d3;
    if (k3 < 2) or (k3 > 255) then
      d3 := -d3;
    
    if event() <> 0 then
      if SDL_QUIT = eventtype () then
        stop := 1;
    
    if 1 = mouseclick() then
    begin
      use_buffer := use_buffer xor 1;
      if use_buffer <> 0 then
        WriteLn ('Using putbuffer()')
      else
        WriteLn ('Using putpixel()');
    end;
  
  until stop <> 0;
  
  WriteLn ('Bye!');
  closegraph ();
end.

// ----- end of file psychedelia.c
