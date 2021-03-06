(* fonts.pas  -*- Object Pascal -*-
 *
 * To build from command line:
 * FPC: fpc -B -Fu.. fonts.pas
 * Delphi: dcc64 -B -U.. fonts.pas
 *
 * fonts.c written by Guido Gonzato, February 2020.
 * fonts.pas written by Ioulianos Kakoulidis, November 2020.
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

program fonts;
{$IF Defined(FPC)}{$MODE Delphi}{$ENDIF}
{$APPTYPE Console}

uses ubgi;

procedure message(x, y: Integer; str: PAnsiChar);
begin
  settextstyle(DEFAULTFONT, HORIZDIR, 0);
  settextjustify(LEFTTEXT, TOPTEXT);
  setusercharsize(1, 1, 2, 1);
  setcolor(RED);
  outtextxy(x, y, str);
  setcolor(BLUE);
  setusercharsize(1, 1, 1, 1);
end;

const
  str_AZC = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  str_sym = '!"#$%&''()*+,-./0123456789:;<=>?@';
  str_az  = '[\]^_`abcdefghijklmnopqrstuvwxyz{|}~';

var
  pos_y, v_skip: Integer;
  gd, gm: Integer;
  info: String;

begin
  gd := DETECT; gm := VGA;

  initgraph(gd, gm, '');
  setcolor(BLUE);
  setbkcolor(WHITE);
  cleardevice();

  (* info := 'SDL_bgi fonts demo'; *)
  settextstyle(BOLDFONT, HORIZDIR, 0);
  OutText('SDL_bgi fonts demo');
  getch();
  cleardevice();

  pos_y := 5;
  message(0, pos_y, 'TRIPLEXFONT, default size');
  settextstyle(TRIPLEXFONT, HORIZDIR, 0);
  Inc(pos_y, 20);
  v_skip := textheight('X');
  outtextxy(10, pos_y, str_sym);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_AZC);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_az);
  Inc(pos_y, v_skip + 20);

  message(0, pos_y, 'SMALLFONT, default size');
  settextstyle(SMALLFONT, HORIZDIR, 0);
  Inc(pos_y, 20);
  v_skip := textheight('X');
  outtextxy(10, pos_y, str_sym);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_AZC);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_az);
  Inc(pos_y, v_skip + 20);

  message(0, pos_y, 'SANSSERIFFONT, default size');
  settextstyle(SANSSERIFFONT, HORIZDIR, 0);
  Inc(pos_y, 20);
  v_skip := textheight('X');
  outtextxy(10, pos_y, str_sym);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_AZC);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_az);
  Inc(pos_y, v_skip + 20);

  message(0, pos_y, 'GOTHICFONT, default size');
  settextstyle(GOTHICFONT, HORIZDIR, 0);
  Inc(pos_y, 20);
  v_skip := textheight('X');
  outtextxy(10, pos_y, str_sym);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_AZC);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_az);
  //Inc(pos_y, v_skip + 15);

  getch();
  cleardevice();

  pos_y := 5;
  message(0, pos_y, 'SCRIPTFONT, default size');
  settextstyle(SCRIPTFONT, HORIZDIR, 0);
  Inc(pos_y, 20);
  v_skip := textheight('X');
  outtextxy(10, pos_y, str_sym);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_AZC);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_az);
  Inc(pos_y, v_skip + 20);

  message(0, pos_y, 'SIMPLEXFONT, default size');
  settextstyle(SIMPLEXFONT, HORIZDIR, 0);
  Inc(pos_y, 20);
  v_skip := textheight('X');
  outtextxy(10, pos_y, str_sym);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_AZC);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_az);
  Inc(pos_y, v_skip + 20);

  message(0, pos_y, 'TRIPLEXSCRFONT, default size');
  settextstyle(TRIPLEXSCRFONT, HORIZDIR, 0);
  Inc(pos_y, 20);
  v_skip := textheight('X');
  outtextxy(10, pos_y, str_sym);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_AZC);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_az);
  //Inc(pos_y, v_skip + 20);

  getch();
  cleardevice();

  pos_y := 5;
  message(0, pos_y, 'COMPLEXFONT, default size');
  settextstyle(COMPLEXFONT, HORIZDIR, 0);
  Inc(pos_y, 15);
  v_skip := textheight('X');
  outtextxy(10, pos_y, str_sym);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_AZC);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_az);
  Inc(pos_y, v_skip + 15);

  message(0, pos_y, 'EUROPEANFONT, default size');
  settextstyle(EUROPEANFONT, HORIZDIR, 0);
  Inc(pos_y, 15);
  v_skip := textheight('X');
  outtextxy(10, pos_y, str_sym);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_AZC);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_az);
  Inc(pos_y, v_skip + 15);

  message(0, pos_y, 'BOLDFONT, default size');
  settextstyle(BOLDFONT, HORIZDIR, 0);
  Inc(pos_y, 15);
  v_skip := textheight('X');
  outtextxy(10, pos_y, str_sym);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_AZC);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_az);
  //Inc(pos_y, v_skip + 25);

  getch();
  cleardevice();

  settextstyle(TRIPLEXFONT, VERTDIR, 0);
  // setusercharsize(2, 1, 2, 1);
  settextjustify(CENTERTEXT, CENTERTEXT);
  outtextxy(getmaxx() div 4, getmaxy() div 2, 'This is VERTICAL TEXT');

  settextstyle(SANSSERIFFONT, VERTDIR, 0);
  // setusercharsize(2, 1, 2, 1);
  settextjustify(CENTERTEXT, CENTERTEXT);
  outtextxy(getmaxx() div 2, getmaxy() div 2, 'This is VERTICAL TEXT');

  settextstyle(GOTHICFONT, VERTDIR, 0);
  // setusercharsize(2, 1, 2, 1);
  settextjustify(CENTERTEXT, CENTERTEXT);
  outtextxy(3 * (getmaxx() div 4), getmaxy() div 2, 'This is VERTICAL TEXT');

  getch();
  cleardevice();

  pos_y := 5;
  message(0, pos_y, 'SMALLFONT, size 1');
  settextstyle(SMALLFONT, HORIZDIR, 0);
  setusercharsize(1, 1, 1, 1);
  Inc(pos_y, 20);
  v_skip := textheight('X');
  outtextxy(10, pos_y, str_sym);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_AZC);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_az);
  Inc(pos_y, v_skip + 20);

  message(0, pos_y, 'SMALLFONT, size 3');
  settextstyle(SMALLFONT, HORIZDIR, 0);
  setusercharsize(3, 1, 3, 1);
  Inc(pos_y, 20);
  v_skip := textheight('X');
  outtextxy(10, pos_y, str_sym);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_AZC);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_az);
  Inc(pos_y, v_skip + 20);

  message(0, pos_y, 'SMALLFONT, size 4 x 8');
  settextstyle(SMALLFONT, HORIZDIR, 0);
  setusercharsize(4, 1, 8, 1);
  Inc(pos_y, 20);
  v_skip := textheight('X');
  outtextxy(10, pos_y, str_sym);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_AZC);
  Inc(pos_y, v_skip);
  outtextxy(10, pos_y, str_az);
  // Inc(pos_y, v_skip + 25);

  getch();
  closegraph();

end.