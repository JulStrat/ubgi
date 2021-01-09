(*
 * turtle.pas  -*- Object Pascal -*-
 *
 * turtle graphics for BGI-compatible libraries
 * Tested with SDL_bgi
 *
 * turtle.c written by Guido Gonzato <guido.gonzato at gmail.com>
 * Latest update: October 2018
 *
 * turtle.pas written by Ioulianos Kakoulidis
 * Latest update: January 2021
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

unit turtle;
{$IF Defined(FPC)}{$MODE Delphi}{$ENDIF}

interface

(*
const
  T_TRUE = 1;
  T_FALSE = 0;
*)

(* turtle shapes *)
const
  T_CIRCLE = 0;
  T_TRIANGLE = 1;

(* bearings *)
const
  T_NORTH = 0;
  T_NORTHEAST = 45;
  T_EAST = 90;
  T_SOUTHEAST = 135;
  T_SOUTH = 180;
  T_SOUTHWEST = 225;
  T_WEST = 270;
  T_NORTHWEST = 315;

  T_TWELVE = T_NORTH;
  T_THREE = T_EAST;
  T_SIX = T_SOUTH;
  T_NINE = T_WEST;

(* Move backwards *)
procedure Back (pix: Integer);

(* Move forwards *)
procedure Forwd (pix: Integer);

(* Turn the turtle left *)
procedure TurnLeft (deg: Integer);

(* Turn the turtle right *)
procedure TurnRight (deg: Integer);

(* Move the turtle to new coordinates *)
procedure SetPosition (x, y: Integer);

(* Set the X coordinate *)
procedure SetX (x: Integer);

(* Set the Y coordinate *)
procedure SetY (y: Integer);

(* Set the turtle heading *)
procedure SetHeading (deg: Integer);

(* Move the turtle to the screen centre *)
procedure Home ();

(* Returns the turtle's x coordinate. *)
function XCor (): Integer;

(* Returns the turtle's y coordinate. *)
function YCor (): Integer;

(* Return the turtle heading (angle) *)
function  Heading (): Integer;

(* Activate drawing *)
procedure PenDown ();

(* Deactivate drawing *)
procedure PenUp ();

(* Is the pen down? *)
function  IsDown (): Boolean;

(* Turtle state and visibility *)

(* hide the turtle *)
procedure HideTurtle ();

(* Show the turtle *)
procedure ShowTurtle ();

(* Set turtle shape *)
procedure TurtleShape (shape: Integer);

//procedure shape (int);

(* Set turtle size *)
procedure TurtleSize (size: Integer);

(* Is the turtle visible? *)
function  IsVisible (): Boolean;

(* Wrap around the window *)
procedure Wrap ();

(* Don't wrap around the window *)
procedure NoWrap ();

implementation

uses ubgi;

var
  (* turtle coordinates *)
  t_pos: array[0..1] of Integer;
  (* turtle heading *)
  t_heading: Integer;

  (* saved turtle coordinates *)
  t_tmp_pos: array[0..1] of Integer;
  (* saved turtle heading *)
  t_tmp_heading: Integer;

  (* draw the turtle? *)
  t_show_turtle: Boolean;
  (* draw? *)
  t_pen_down: Boolean;
  (* has the turtle been drawn? *)
  t_turtle_drawn: Boolean;
  (* wrap around the window? *)
  t_turtle_wrap: Boolean;

  t_turtle_size: Integer;
  t_turtle_shape: Integer;

(*
  sine and cosine tables for polar graphics. The angle
  starts at pi/2 and increases clockwise: -(angle-90)
*)
const
t_sin: array[0..359] of Double =
( 1.000000,  0.999848,  0.999391,  0.998630,  0.997564,
  0.996195,  0.994522,  0.992546,  0.990268,  0.987688,
  0.984808,  0.981627,  0.978148,  0.974370,  0.970296,
  0.965926,  0.961262,  0.956305,  0.951057,  0.945519,
  0.939693,  0.933580,  0.927184,  0.920505,  0.913545,
  0.906308,  0.898794,  0.891007,  0.882948,  0.874620,
  0.866025,  0.857167,  0.848048,  0.838671,  0.829038,
  0.819152,  0.809017,  0.798636,  0.788011,  0.777146,
  0.766044,  0.754710,  0.743145,  0.731354,  0.719340,
  0.707107,  0.694658,  0.681998,  0.669131,  0.656059,
  0.642788,  0.629320,  0.615661,  0.601815,  0.587785,
  0.573576,  0.559193,  0.544639,  0.529919,  0.515038,
  0.500000,  0.484810,  0.469472,  0.453990,  0.438371,
  0.422618,  0.406737,  0.390731,  0.374607,  0.358368,
  0.342020,  0.325568,  0.309017,  0.292372,  0.275637,
  0.258819,  0.241922,  0.224951,  0.207912,  0.190809,
  0.173648,  0.156434,  0.139173,  0.121869,  0.104528,
  0.087156,  0.069756,  0.052336,  0.034899,  0.017452,
  0.000000,  -0.017452,  -0.034899,  -0.052336,  -0.069756,
  -0.087156,  -0.104528,  -0.121869,  -0.139173,  -0.156434,
  -0.173648,  -0.190809,  -0.207912,  -0.224951,  -0.241922,
  -0.258819,  -0.275637,  -0.292372,  -0.309017,  -0.325568,
  -0.342020,  -0.358368,  -0.374607,  -0.390731,  -0.406737,
  -0.422618,  -0.438371,  -0.453990,  -0.469472,  -0.484810,
  -0.500000,  -0.515038,  -0.529919,  -0.544639,  -0.559193,
  -0.573576,  -0.587785,  -0.601815,  -0.615661,  -0.629320,
  -0.642788,  -0.656059,  -0.669131,  -0.681998,  -0.694658,
  -0.707107,  -0.719340,  -0.731354,  -0.743145,  -0.754710,
  -0.766044,  -0.777146,  -0.788011,  -0.798636,  -0.809017,
  -0.819152,  -0.829038,  -0.838671,  -0.848048,  -0.857167,
  -0.866025,  -0.874620,  -0.882948,  -0.891007,  -0.898794,
  -0.906308,  -0.913545,  -0.920505,  -0.927184,  -0.933580,
  -0.939693,  -0.945519,  -0.951057,  -0.956305,  -0.961262,
  -0.965926,  -0.970296,  -0.974370,  -0.978148,  -0.981627,
  -0.984808,  -0.987688,  -0.990268,  -0.992546,  -0.994522,
  -0.996195,  -0.997564,  -0.998630,  -0.999391,  -0.999848,
  -1.000000,  -0.999848,  -0.999391,  -0.998630,  -0.997564,
  -0.996195,  -0.994522,  -0.992546,  -0.990268,  -0.987688,
  -0.984808,  -0.981627,  -0.978148,  -0.974370,  -0.970296,
  -0.965926,  -0.961262,  -0.956305,  -0.951057,  -0.945519,
  -0.939693,  -0.933580,  -0.927184,  -0.920505,  -0.913545,
  -0.906308,  -0.898794,  -0.891007,  -0.882948,  -0.874620,
  -0.866025,  -0.857167,  -0.848048,  -0.838671,  -0.829038,
  -0.819152,  -0.809017,  -0.798636,  -0.788011,  -0.777146,
  -0.766044,  -0.754710,  -0.743145,  -0.731354,  -0.719340,
  -0.707107,  -0.694658,  -0.681998,  -0.669131,  -0.656059,
  -0.642788,  -0.629320,  -0.615661,  -0.601815,  -0.587785,
  -0.573576,  -0.559193,  -0.544639,  -0.529919,  -0.515038,
  -0.500000,  -0.484810,  -0.469472,  -0.453990,  -0.438371,
  -0.422618,  -0.406737,  -0.390731,  -0.374607,  -0.358368,
  -0.342020,  -0.325568,  -0.309017,  -0.292372,  -0.275637,
  -0.258819,  -0.241922,  -0.224951,  -0.207912,  -0.190809,
  -0.173648,  -0.156434,  -0.139173,  -0.121869,  -0.104528,
  -0.087156,  -0.069756,  -0.052336,  -0.034899,  -0.017452,
  -0.000000,  0.017452,  0.034899,  0.052336,  0.069756,
  0.087156,  0.104528,  0.121869,  0.139173,  0.156434,
  0.173648,  0.190809,  0.207912,  0.224951,  0.241922,
  0.258819,  0.275637,  0.292372,  0.309017,  0.325568,
  0.342020,  0.358368,  0.374607,  0.390731,  0.406737,
  0.422618,  0.438371,  0.453990,  0.469472,  0.484810,
  0.500000,  0.515038,  0.529919,  0.544639,  0.559193,
  0.573576,  0.587785,  0.601815,  0.615661,  0.629320,
  0.642788,  0.656059,  0.669131,  0.681998,  0.694658,
  0.707107,  0.719340,  0.731354,  0.743145,  0.754710,
  0.766044,  0.777146,  0.788011,  0.798636,  0.809017,
  0.819152,  0.829038,  0.838671,  0.848048,  0.857167,
  0.866025,  0.874620,  0.882948,  0.891007,  0.898794,
  0.906308,  0.913545,  0.920505,  0.927184,  0.933580,
  0.939693,  0.945519,  0.951057,  0.956305,  0.961262,
  0.965926,  0.970296,  0.974370,  0.978148,  0.981627,
  0.984808,  0.987688,  0.990268,  0.992546,  0.994522,
  0.996195,  0.997564,  0.998630,  0.999391,  0.999848 );

t_cos: array[0..359] of double =
( 0.000000,  0.017452,  0.034899,  0.052336,  0.069756,
  0.087156,  0.104528,  0.121869,  0.139173,  0.156434,
  0.173648,  0.190809,  0.207912,  0.224951,  0.241922,
  0.258819,  0.275637,  0.292372,  0.309017,  0.325568,
  0.342020,  0.358368,  0.374607,  0.390731,  0.406737,
  0.422618,  0.438371,  0.453990,  0.469472,  0.484810,
  0.500000,  0.515038,  0.529919,  0.544639,  0.559193,
  0.573576,  0.587785,  0.601815,  0.615661,  0.629320,
  0.642788,  0.656059,  0.669131,  0.681998,  0.694658,
  0.707107,  0.719340,  0.731354,  0.743145,  0.754710,
  0.766044,  0.777146,  0.788011,  0.798636,  0.809017,
  0.819152,  0.829038,  0.838671,  0.848048,  0.857167,
  0.866025,  0.874620,  0.882948,  0.891007,  0.898794,
  0.906308,  0.913545,  0.920505,  0.927184,  0.933580,
  0.939693,  0.945519,  0.951057,  0.956305,  0.961262,
  0.965926,  0.970296,  0.974370,  0.978148,  0.981627,
  0.984808,  0.987688,  0.990268,  0.992546,  0.994522,
  0.996195,  0.997564,  0.998630,  0.999391,  0.999848,
  1.000000,  0.999848,  0.999391,  0.998630,  0.997564,
  0.996195,  0.994522,  0.992546,  0.990268,  0.987688,
  0.984808,  0.981627,  0.978148,  0.974370,  0.970296,
  0.965926,  0.961262,  0.956305,  0.951057,  0.945519,
  0.939693,  0.933580,  0.927184,  0.920505,  0.913545,
  0.906308,  0.898794,  0.891007,  0.882948,  0.874620,
  0.866025,  0.857167,  0.848048,  0.838671,  0.829038,
  0.819152,  0.809017,  0.798636,  0.788011,  0.777146,
  0.766044,  0.754710,  0.743145,  0.731354,  0.719340,
  0.707107,  0.694658,  0.681998,  0.669131,  0.656059,
  0.642788,  0.629320,  0.615661,  0.601815,  0.587785,
  0.573576,  0.559193,  0.544639,  0.529919,  0.515038,
  0.500000,  0.484810,  0.469472,  0.453990,  0.438371,
  0.422618,  0.406737,  0.390731,  0.374607,  0.358368,
  0.342020,  0.325568,  0.309017,  0.292372,  0.275637,
  0.258819,  0.241922,  0.224951,  0.207912,  0.190809,
  0.173648,  0.156434,  0.139173,  0.121869,  0.104528,
  0.087156,  0.069756,  0.052336,  0.034899,  0.017452,
  0.000000,  -0.017452,  -0.034899,  -0.052336,  -0.069756,
  -0.087156,  -0.104528,  -0.121869,  -0.139173,  -0.156434,
  -0.173648,  -0.190809,  -0.207912,  -0.224951,  -0.241922,
  -0.258819,  -0.275637,  -0.292372,  -0.309017,  -0.325568,
  -0.342020,  -0.358368,  -0.374607,  -0.390731,  -0.406737,
  -0.422618,  -0.438371,  -0.453990,  -0.469472,  -0.484810,
  -0.500000,  -0.515038,  -0.529919,  -0.544639,  -0.559193,
  -0.573576,  -0.587785,  -0.601815,  -0.615661,  -0.629320,
  -0.642788,  -0.656059,  -0.669131,  -0.681998,  -0.694658,
  -0.707107,  -0.719340,  -0.731354,  -0.743145,  -0.754710,
  -0.766044,  -0.777146,  -0.788011,  -0.798636,  -0.809017,
  -0.819152,  -0.829038,  -0.838671,  -0.848048,  -0.857167,
  -0.866025,  -0.874620,  -0.882948,  -0.891007,  -0.898794,
  -0.906308,  -0.913545,  -0.920505,  -0.927184,  -0.933580,
  -0.939693,  -0.945519,  -0.951057,  -0.956305,  -0.961262,
  -0.965926,  -0.970296,  -0.974370,  -0.978148,  -0.981627,
  -0.984808,  -0.987688,  -0.990268,  -0.992546,  -0.994522,
  -0.996195,  -0.997564,  -0.998630,  -0.999391,  -0.999848,
  -1.000000,  -0.999848,  -0.999391,  -0.998630,  -0.997564,
  -0.996195,  -0.994522,  -0.992546,  -0.990268,  -0.987688,
  -0.984808,  -0.981627,  -0.978148,  -0.974370,  -0.970296,
  -0.965926,  -0.961262,  -0.956305,  -0.951057,  -0.945519,
  -0.939693,  -0.933580,  -0.927184,  -0.920505,  -0.913545,
  -0.906308,  -0.898794,  -0.891007,  -0.882948,  -0.874620,
  -0.866025,  -0.857167,  -0.848048,  -0.838671,  -0.829038,
  -0.819152,  -0.809017,  -0.798636,  -0.788011,  -0.777146,
  -0.766044,  -0.754710,  -0.743145,  -0.731354,  -0.719340,
  -0.707107,  -0.694658,  -0.681998,  -0.669131,  -0.656059,
  -0.642788,  -0.629320,  -0.615661,  -0.601815,  -0.587785,
  -0.573576,  -0.559193,  -0.544639,  -0.529919,  -0.515038,
  -0.500000,  -0.484810,  -0.469472,  -0.453990,  -0.438371,
  -0.422618,  -0.406737,  -0.390731,  -0.374607,  -0.358368,
  -0.342020,  -0.325568,  -0.309017,  -0.292372,  -0.275637,
  -0.258819,  -0.241922,  -0.224951,  -0.207912,  -0.190809,
  -0.173648,  -0.156434,  -0.139173,  -0.121869,  -0.104528,
  -0.087156,  -0.069756,  -0.052336,  -0.034899,  -0.017452);

(* Turtle drawing procedures *)
procedure draw_turtle_circle ();
var
  col: Integer;
begin
  col := GetColor ();
  if RED <> GetBkColor () then
    SetColor (RED)
  else
    SetColor (WHITE);
  Circle (t_pos[0], t_pos[1], t_turtle_size);
  SetColor (col);
end;

procedure draw_turtle_triangle ();
var
  triangle: array[0..5] of Integer;
  col: Integer;
begin
  (* draws a triangular turtle. *)
  triangle[0] := t_pos[0] +
    Trunc(t_turtle_size * t_cos[t_heading]);
  triangle[1] := t_pos[1] -
    Trunc(t_turtle_size * t_sin[t_heading]);

  Dec(t_heading, 90);
  if t_heading < 0 then
    Inc(t_heading, 360);

  triangle[2] := t_pos[0] +
    Trunc(t_turtle_size/3 * t_cos[t_heading]);
  triangle[3] := t_pos[1] -
    Trunc(t_turtle_size/3 * t_sin[t_heading]);

  Dec(t_heading, 180);
  if t_heading < 0 then
    Inc(t_heading, 360);

  triangle[4] := t_pos[0] +
    Trunc(t_turtle_size/3 * t_cos[t_heading]);
  triangle[5] := t_pos[1] -
    Trunc(t_turtle_size/3 * t_sin[t_heading]);

  // draw it
  col := GetColor ();
  if RED <> GetBkColor () then
    SetColor (RED)
  else
    SetColor (WHITE);
  Line (triangle[0], triangle[1], triangle[2], triangle[3]);
  Line (triangle[2], triangle[3], triangle[4], triangle[5]);
  Line (triangle[4], triangle[5], triangle[0], triangle[1]);
  SetColor (col);
end;

procedure draw_turtle ();
var
  tmp_heading: Integer;
begin
  tmp_heading := t_heading;
  SetWriteMode (XORPUT);

  case t_turtle_shape of
    T_CIRCLE:
      draw_turtle_circle ();
  else
    draw_turtle_triangle ();
  end;

  SetWriteMode (COPYPUT);
  t_turtle_drawn := TRUE;
  t_heading := tmp_heading;
end;

(* *)
procedure Back (pix: Integer);
begin
  TurnLeft (180);
  Forwd (pix);
  TurnLeft (180);
end;

procedure Forwd (pix: Integer);
var
  newx, newy: Integer;
begin

  newx := Trunc(pix * t_cos[t_heading]);
  newy := Trunc(pix * t_sin[t_heading]);

  if t_show_turtle then
    draw_turtle ();

  (* should we draw? *)
  if t_pen_down then
    Line (t_pos[0], t_pos[1],
      t_pos[0] + newx, t_pos[1] - newy);

  Inc(t_pos[0], newx);
  Dec(t_pos[1], newy);

  (* is wrapping active? *)
  if t_turtle_wrap then
  begin
    if t_pos[0] < 0 then
      t_pos[0] := GetMaxX () + t_pos[0];

    if t_pos[0] > GetMaxX () then
      t_pos[0] := t_pos[0] - GetMaxX ();

    if t_pos[1] < 0 then
      t_pos[1] := GetMaxY () + t_pos[1];

    if t_pos[1] > GetMaxY () then
      t_pos[1] := t_pos[1] - GetMaxY ();
  end;

  if t_show_turtle then
    draw_turtle ();

end;

procedure TurnLeft (deg: Integer);
begin
  if t_show_turtle then
    draw_turtle ();
  Dec(t_heading, deg);
  if t_heading < 0 then
    Inc(t_heading, 360);
  if t_show_turtle then
    draw_turtle ();
end;

procedure TurnRight (deg: Integer);
begin
  if t_show_turtle then
    draw_turtle ();
  Inc(t_heading, deg);
  if t_heading >= 360 then
    Dec(t_heading, 360);
  if t_show_turtle then
    draw_turtle ();
end;

procedure SetPosition (x, y: Integer);
begin
  t_pos[0] := x;
  t_pos[1] := y;
end;

procedure SetX (x: Integer);
begin
  t_pos[0] := x;
end;

procedure SetY (y: Integer);
begin
  t_pos[1] := y;
end;

procedure SetHeading (deg: Integer);
begin
  t_heading := deg mod 360; (* avoid overflows *)
end;

procedure Home ();
begin
  t_pos[0] := GetMaxX () div 2;
  t_pos[1] := GetMaxY () div 2;
  SetHeading (0);
end;

function XCor (): Integer;
begin
  Result := t_pos[0];
end;

function YCor (): Integer;
begin
  Result := t_pos[1];
end;

function Heading (): Integer;
begin
  Result := t_heading;
end;

procedure PenDown ();
begin
  t_pen_down := TRUE;
end;

procedure PenUp ();
begin
  t_pen_down := FALSE;
end;

function IsDown (): Boolean;
begin
  Result := t_pen_down;
end;

procedure TurtleShape (shape: Integer);
begin
  t_turtle_shape := shape;
end;

procedure ShowTurtle ();
begin
  draw_turtle ();
  t_show_turtle := TRUE;
end;

procedure HideTurtle ();
begin
  draw_turtle ();
  t_show_turtle := FALSE;
end;

procedure TurtleSize (size: Integer);
begin
  t_turtle_size := size;
end;

function IsVisible (): Boolean;
begin
  Result := t_show_turtle;
end;

procedure Wrap ();
begin
  t_turtle_wrap := TRUE;
end;

procedure NoWrap ();
begin
  t_turtle_wrap := FALSE;
end;

initialization
  t_heading := 0;
  t_tmp_pos[0] := -1;
  t_tmp_pos[1] := -1;
  t_tmp_heading := 0;
  t_show_turtle := FALSE;
  t_pen_down := TRUE;
  t_turtle_drawn := TRUE;
  t_turtle_wrap := FALSE;
  t_turtle_size := 21;
  t_turtle_shape := T_TRIANGLE;

end.