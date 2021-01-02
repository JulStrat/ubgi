(* plasma.pas  -*- Object Pascal -*-
 *
 * To build from command line:
 * FPC: fpc -B -Fu.. plasma.pas
 * Delphi: dcc64 -B -U.. plasma.pas
 *
 * Used to produce the 'plasma.bmp' file
 *
 * plasma.c written by Guido Gonzato, May 2015.
 * plasma.pas written by Ioulianos Kakoulidis, December 2020.
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

program plasma;
{$IF Defined(FPC)}{$MODE Delphi}{$ENDIF}
{$APPTYPE Console}

uses ubgi;

var
  i, x, y, r, g, b: Integer;
  cols: array [0..2, 0..254] of Integer;
  c: Double;

begin
  initwindow (600, 600);

  for  i := 0 to 254 do
  begin
    cols[0][i] := Trunc(abs( 128 - 127 * sin (i * PI / 32)));
    cols[1][i] := Trunc(abs( 128 - 127 * sin (i * PI / 64)));
    cols[2][i] := Trunc(abs( 128 - 127 * sin (i * PI / 128)));
  end;

  for y := 0 to getmaxy()-1 do
  begin
    for x := 0 to getmaxx()-1 do
    begin
      c := sin(x/35)*128 + sin(y/28)*32 + sin((x+y)/16)*64;
      if (c > 255) then c := c - 256;
      if (c < 0) then c := 256 + c;
      r := cols[0][Trunc(c)];
      if (r > 255) then r := r - 256;
      if (r < 0) then r := 256 + Trunc(c);
      g := cols[1][Trunc(c)];
      if (g > 255) then g := g - 256;
      if (g < 0) then g := 256 + Trunc(c);
      b := cols[2][Trunc(c)];
      if (b > 255) then b := b - 256;
      if (b < 0) then b := 256 + Trunc(c);
      putpixel(x, y, COLOR(r, g, b));
    end;
  end;
  refresh ();
  getch ();
  writeimagefile ('plasma.bmp', 0, 0, 599, 599);

  closegraph ();
end.
