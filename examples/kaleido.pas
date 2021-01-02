(* kaleido.pas  -*- Object Pascal -*-
 *
 * To build from command line:
 * FPC: fpc -B -Fu.. kaleido.pas
 * Delphi: dcc64 -B -U.. kaleido.pas
 *
 * kaleido.c written by Guido Gonzato, December 2018
 * kaleido.pas written by Ioulianos Kakoulidis, January 2021
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

program kaleido;
{$IF Defined(FPC)}{$MODE Delphi}{$ENDIF}
{$APPTYPE Console}

uses ubgi;

var
  xc, yc: Integer;

procedure rnd_circles (x, y, r: Integer);
begin
  fillellipse (xc + x, yc + y, r, r);
  fillellipse (xc - x, yc + y, r, r);
  fillellipse (xc - x, yc - y, r, r);
  fillellipse (xc + x, yc - y, r, r);
  fillellipse (xc + y, yc + x, r, r);
  fillellipse (xc - y, yc + x, r, r);
  fillellipse (xc - y, yc - x, r, r);
  fillellipse (xc + y, yc - x, r, r);
  (* outlines *)
  setcolor (COLOR (random (256), random (256), random (256)));
  ellipse (xc + x, yc + y, 0, 360, r, r);
  ellipse (xc - x, yc + y, 0, 360, r, r);
  ellipse (xc - x, yc - y, 0, 360, r, r);
  ellipse (xc + x, yc - y, 0, 360, r, r);
  ellipse (xc + y, yc + x, 0, 360, r, r);
  ellipse (xc - y, yc + x, 0, 360, r, r);
  ellipse (xc - y, yc - x, 0, 360, r, r);
  ellipse (xc + y, yc - x, 0, 360, r, r);
end;

procedure rnd_bars (x, y, r: Integer);
begin
  bar (xc + x - r div 2, yc + y - r div 2, xc + x + r div 2, yc + y + r div 2);
  bar (xc - x - r div 2, yc + y - r div 2, xc - x + r div 2, yc + y + r div 2);
  bar (xc - x - r div 2, yc - y - r div 2, xc - x + r div 2, yc - y + r div 2);
  bar (xc + x - r div 2, yc - y - r div 2, xc + x + r div 2, yc - y + r div 2);
  bar (xc + y - r div 2, yc + x - r div 2, xc + y + r div 2, yc + x + r div 2);
  bar (xc - y - r div 2, yc + x - r div 2, xc - y + r div 2, yc + x + r div 2);
  bar (xc - y - r div 2, yc - x - r div 2, xc - y + r div 2, yc - x + r div 2);
  bar (xc + y - r div 2, yc - x - r div 2, xc + y + r div 2, yc - x + r div 2);
  (* outlines *)
  setcolor (COLOR (random (256), random (256), random (256)));
  rectangle (xc + x - r div 2, yc + y - r div 2, xc + x + r div 2, yc + y + r div 2);
  rectangle (xc - x - r div 2, yc + y - r div 2, xc - x + r div 2, yc + y + r div 2);
  rectangle (xc - x - r div 2, yc - y - r div 2, xc - x + r div 2, yc - y + r div 2);
  rectangle (xc + x - r div 2, yc - y - r div 2, xc + x + r div 2, yc - y + r div 2);
  rectangle (xc + y - r div 2, yc + x - r div 2, xc + y + r div 2, yc + x + r div 2);
  rectangle (xc - y - r div 2, yc + x - r div 2, xc - y + r div 2, yc + x + r div 2);
  rectangle (xc - y - r div 2, yc - x - r div 2, xc - y + r div 2, yc - x + r div 2);
  rectangle (xc + y - r div 2, yc - x - r div 2, xc + y + r div 2, yc - x + r div 2);
end;

var
  x, y, r,
  n,
  stop: Integer;

begin
  stop := NOPE;

  randomize ();
  setwinoptions ('', -1, -1, -1 (* SDL_WINDOW_FULLSCREEN *));
  initwindow (1024, 768); (* fullscreen *)
  setbkcolor (BLACK);
  cleardevice ();
  refresh ();
  xc := getmaxx () div 2;
  yc := getmaxy () div 2;
  n := 0;

  while stop = 0 do
  begin
    (* define random position and radius of a circle *)
    x := random (xc);
    y := random (yc);
    r := 5 + random (25);
    setcolor (COLOR (random (256), random (256), random (256)));
    setfillstyle (USERFILL, getcolor ());
    (* draw 8 filled circles *)
    rnd_circles (x, y, r);

    (* define a random box *)
    x := random (xc);
    y := random (yc);
    r := 5 + random (25);
    setcolor (COLOR (random (256), random (256), random (256)));
    setfillstyle (USERFILL, getcolor ());
    (* draw 8 boxes *)
    rnd_bars (x, y, r);

    Inc(n);
    if 10 = n then
      refresh ();

    (* every 20 frames, fade the graphics *)
    if 20 = n then
    begin
      (* black with minimum transparency *)
      setcolor (COLOR (0, 0, 0));
      setalpha (getcolor (), 1);
      setfillstyle (SOLIDFILL, getcolor ());
      (* overlap the screen with transparent black *)
      bar (0, 0, getmaxx (), getmaxy());
      refresh ();
      n := 0;

      if event() <> 0 then
        stop := YEAH;
    end;
  end;

  closegraph ();

end.
