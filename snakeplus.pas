uses crt;

type edges=record x,y:integer; end;

var key,ht,fx,fy,ns1,ns2,tx,ty,n,score,scoreai,speed,lv,dem,cr:integer;
    bar:array[1..10000] of edges;
    fr,frsn,visited:array[-1..51,-1..26] of boolean;
    x,xx,tm:char;
    sn1,sn2,hd:array[0..10000] of edges;
    ai:string;
    trace:array[0..10000] of integer;
    s:string;
    fi:text;
    a:array[0..6] of integer;
    name:array[0..6] of string;
    ok,p:boolean;


procedure menu; begin end;

procedure intbarrierandfood; var i:integer; begin

    fillchar(fr,sizeof(fr),true);
    for i:=1 to 50 do fr[i,1]:=false;
    for i:=1 to 25 do fr[1,i]:=false;
    for i:=1 to 50 do fr[i,25]:=false;
    for i:=1 to 25 do fr[50,i]:=false;

    for i:=1 to lv*15 do begin
        bar[i].x:=random(48); bar[i].y:=random(23);
    end;
    fx:=random(48); fy:=random(23);
    while not fr[fx,fy] or (fx<=1) or (fy<=1) or (frsn[fx,fy]) do begin
        fx:=random(48); fy:=random(23);
    end;

    textcolor(brown);
    for i:=1 to 25 do begin
        gotoxy(51,i); write('±');
        gotoxy(1,i); write('±');
    end;
    for i:=1 to 50 do begin
        gotoxy(i,1); write('Í');
        gotoxy(i,25); write('Í');
    end;

end;

procedure barrier; var i:integer; begin
    textcolor(white);
    for i:=1 to lv*15 do begin
       if (bar[i].x>1) and (bar[i].y>2) then begin
        fr[bar[i].x,bar[i].y]:=false;
        gotoxy(bar[i].x,bar[i].y);
        write('²');
       end;
    end;
end;

procedure food; begin
    textcolor(green);
    gotoxy(fx,fy); write('');
end;

procedure snake1; var i:integer; begin
    textcolor(red);
    gotoxy(sn1[1].x,sn1[1].y);
    write('');
    for i:=2 to ns1 do begin
        gotoxy(sn1[i].x,sn1[i].y);
        write('ù');
    end;

end;

procedure snake2; var i:integer; begin
    textcolor(blue);
    gotoxy(sn2[1].x,sn2[1].y);
    write('');
    for i:=2 to ns2 do begin
        gotoxy(sn2[i].x,sn2[i].y);
        write('ù');
    end;
end;

procedure pause; begin
    textcolor(lightgray);
    gotoxy(20,10); write('PAUSE');
    key:=ord(readkey);
    IF key=112 THEN begin p:=false;gotoxy(20,10); textcolor(black); write('PAUSE');
    exit; end;
    if key=109 then begin ht:=-1; menu; exit; end;
end;

procedure control; var i:integer; begin
    tm:=x;
    if keypressed then begin x:=readkey; key:=ord(x); end;
    if key=112 then begin p:=true; while p do pause ; key:=0; end;
    if key=109 then begin ht:=-1; menu; exit; end;
    begin
    if (x='H')and(sn1[1].y-1<>sn1[2].y) then begin
       gotoxy(sn1[ns1].x,sn1[ns1].y); textcolor(black); write('ù');
       frsn[sn1[ns1].x,sn1[ns1].y]:=false;
       for i:=ns1 downto 2 do begin
           sn1[i].x:=sn1[i-1].x; sn1[i].y:=sn1[i-1].y;
       end;
       dec(sn1[1].y);
       frsn[sn1[1].x,sn1[1].y]:=true;
    end
    else if (x='P')and(sn1[1].y+1<>sn1[2].y) then begin
       gotoxy(sn1[ns1].x,sn1[ns1].y); textcolor(black); write('ù');
       frsn[sn1[ns1].x,sn1[ns1].y]:=false;
       for i:=ns1 downto 2 do begin sn1[i].x:=sn1[i-1].x; sn1[i].y:=sn1[i-1].y; end;
       inc(sn1[1].y);
       frsn[sn1[1].x,sn1[1].y]:=true;
    end
    else if (x='K')and(sn1[1].x-1<>sn1[2].x) then begin
       gotoxy(sn1[ns1].x,sn1[ns1].y); textcolor(black); write('ù');
       frsn[sn1[ns1].x,sn1[ns1].y]:=false;
       for i:=ns1 downto 2 do begin sn1[i].x:=sn1[i-1].x; sn1[i].y:=sn1[i-1].y; end;
       dec(sn1[1].x);
       frsn[sn1[1].x,sn1[1].y]:=true;
    end
    else if (x='M')and(sn1[1].x+1<>sn1[2].x) then begin
       gotoxy(sn1[ns1].x,sn1[ns1].y); textcolor(black); write('ù');
       frsn[sn1[ns1].x,sn1[ns1].y]:=false;
       for i:=ns1 downto 2 do begin sn1[i].x:=sn1[i-1].x; sn1[i].y:=sn1[i-1].y; end;
       inc(sn1[1].x);
       frsn[sn1[1].x,sn1[1].y]:=true;
    end else x:=tm;

    if (ai[n]='w') then begin
       gotoxy(sn2[ns2].x,sn2[ns2].y); textcolor(black); write('ù');
       frsn[sn2[ns2].x,sn2[ns2].y]:=false;
       for i:=ns2 downto 2 do begin sn2[i].x:=sn2[i-1].x; sn2[i].y:=sn2[i-1].y; end;
       dec(sn2[1].y);
       frsn[sn2[1].x,sn2[1].y]:=true;
    end
    else if (ai[n]='s') then begin
       gotoxy(sn2[ns2].x,sn2[ns2].y); textcolor(black); write('ù');
       frsn[sn2[ns2].x,sn2[ns2].y]:=false;
       for i:=ns2 downto 2 do begin sn2[i].x:=sn2[i-1].x; sn2[i].y:=sn2[i-1].y; end;
       inc(sn2[1].y);
       frsn[sn2[1].x,sn2[1].y]:=true;
    end
    else if (ai[n]='a') then begin
       gotoxy(sn2[ns2].x,sn2[ns2].y); textcolor(black); write('ù');
       frsn[sn2[ns2].x,sn2[ns2].y]:=false;
       for i:=ns2 downto 2 do begin sn2[i].x:=sn2[i-1].x; sn2[i].y:=sn2[i-1].y; end;
       dec(sn2[1].x);
       frsn[sn2[1].x,sn2[1].y]:=true;
    end
    else if (ai[n]='d') then begin
       gotoxy(sn2[ns2].x,sn2[ns2].y); textcolor(black); write('ù');
       frsn[sn2[ns2].x,sn2[ns2].y]:=false;
       for i:=ns2 downto 2 do begin sn2[i].x:=sn2[i-1].x; sn2[i].y:=sn2[i-1].y; end;
       inc(sn2[1].x);
       frsn[sn2[1].x,sn2[1].y]:=true;
    end;
    dec(n);
    if n=0 then n:=1;
    end;
end;

procedure inttwosnake; begin
    ns1:=3; ns2:=3;
    sn1[1].x:=4; sn1[1].y:=2;
    sn1[2].x:=3; sn1[2].y:=2;
    sn1[3].x:=2; sn1[3].y:=2;
    sn2[1].x:=47; sn2[1].y:=2;
    sn2[2].x:=48; sn2[2].y:=2;
    sn2[3].x:=49; sn2[3].y:=2;
end;

function th1:boolean; begin
    if not fr[fx-1,fy] and not fr[fx+1,fy] and not fr[fx,fy+1] then exit(true);
    if not fr[fx-1,fy] and not fr[fx+1,fy] and not fr[fx,fy-1] then exit(true);
    if not fr[fx,fy+1] and not fr[fx+1,fy] and not fr[fx,fy-1] then exit(true);
    if not fr[fx,fy-1] and not fr[fx-1,fy] and not fr[fx,fy+1] then exit(true);
    exit(false);
end;

procedure intfood; begin
    fx:=random(48); fy:=random(23);
    while (not fr[fx,fy]) or (fx<=1) or (fy<=1) or (frsn[fx,fy]) or th1 do begin
        fx:=random(48); fy:=random(23);
    end;
end;

procedure bfs; var tmx,tmy,l,r:integer; begin

    fillchar(visited,sizeof(visited),true);
    visited[sn2[2].x,sn2[2].y]:=false;
    l:=1; r:=1; hd[l].x:=sn2[1].x; hd[l].y:=sn2[1].y;
    while l<=r do begin
        tmx:=hd[l].x; tmy:=hd[l].y;  inc(l);
        if (tmx=fx)and(tmy=fy) then break
        else begin
            if (tmx+1<=50)and(fr[tmx+1,tmy])and(visited[tmx+1,tmy]) then begin
                inc(r); hd[r].x:=tmx+1; hd[r].y:=tmy;
                visited[tmx+1,tmy]:=false;
                trace[r]:=l-1;
            end;
            if (tmx-1>0) and (fr[tmx-1,tmy])and(visited[tmx-1,tmy]) then begin
                inc(r); hd[r].x:=tmx-1; hd[r].y:=tmy;
                visited[tmx-1,tmy]:=false;
                trace[r]:=l-1;
            end;
            if (tmy+1<=25) and (fr[tmx,tmy+1])and(visited[tmx,tmy+1])then begin
                inc(r); hd[r].x:=tmx; hd[r].y:=tmy+1;
                visited[tmx,tmy+1]:=false;
                trace[r]:=l-1;
            end;
            if (tmy-1>0) and (fr[tmx,tmy-1])and(visited[tmx,tmy-1]) then begin
                inc(r); hd[r].x:=tmx; hd[r].y:=tmy-1;
                visited[tmx,tmy-1]:=false;
                trace[r]:=l-1;
            end;
        end;
    end;
    ai:=''; n:=0;
    dec(l);
    while (hd[l].x<>sn2[1].x)or(hd[l].y<>sn2[1].y) do begin
        if hd[l].x=hd[trace[l]].x-1  then ai:=ai+'a'
        else if hd[l].x=hd[trace[l]].x+1 then ai:=ai+'d'
        else if hd[l].y=hd[trace[l]].y+1 then ai:=ai+'s'
        else ai:=ai+'w';
        l:=trace[l];
    end;
    n:=length(ai);
end;

procedure gameover; var tg,i,j:integer; nametg:string[20]; xep:boolean; begin
    textcolor(yellow);
    gotoxy(20,10);writeln('GAME OVER ë');
    gotoxy(20,12);writeln('YOUR SCORE: ',score);
    xep:=false;
    if score>a[cr] then xep:=true;
    if xep then
    begin
        gotoxy(20,13);write('YOUR.NAME:');readln(name[6]);
        a[6]:=score;
        for i:=1 to cr do
        for j:=i+1 to 6 do
        if a[i]<a[j] then begin
           tg:=a[i];
           a[i]:=a[j];
           a[j]:=tg;
           cr:=i;
           nametg:=name[i];
           name[i]:=name[j];
           name[j]:=nametg;
        end;
    end else delay(3000);
end;

Procedure Beep ; Begin
       Sound ( 150 ) ; Delay ( 400 ) ; Nosound ;
End ;

Procedure Ru; Var Counter : Integer ; BEGIN
       //For Counter := 1 To 30 Do Begin
            Sound ( 100 ) ;
            Delay ( 45 ) ;
            Nosound ;
           // Delay ( 300 ) ;
       //End ;
end;


procedure check;  begin
    if (not fr[sn1[1].x,sn1[1].y]) or (score+lv*50<scoreai) then begin
       beep; gameover; ok:=false;  exit;
    end
    else if (sn1[1].x=fx)and(sn1[1].y=fy) then begin
        inc(ns1);
        sn1[ns1].x:=sn1[ns1-1].x+1; sn1[ns1].y:=sn1[ns1-1].y;
        intfood;
        food;
        inc(score,10*lv);
        inc(dem);
        ru;
    end
    else if (sn2[1].x=fx)and(sn2[1].y=fy) then begin
        inc(ns2);
        sn2[ns2].x:=sn2[ns2-1].x+1; sn2[ns2].y:=sn2[ns2-1].y;
        intfood;
        bfs;
        food;
        inc(scoreai,10*lv);
        ru;
    end;
    if (dem=5)and(score<>0) then begin
        inc(lv);
        dem:=0;
        dec(scoreai,50);
        dec(speed,20);
        clrscr;
        delay(1500);
        intbarrierandfood;
        x:='M'; xx:='a';
        inttwosnake;
        barrier;
        food;
    end;
end;

procedure drawscreen; var i:integer; begin

    gotoxy(60,9); textcolor(green); write('SCORE: ');
    textcolor(red); write(score);
    gotoxy(51,1); textcolor(yellow); write('LV ',lv);
    textcolor(Magenta);
    gotoxy(58,3); write('Press p to Pause');
    gotoxy(58,5); write('Press m to go Menu');
    textcolor(white);
    gotoxy(55,13); write('Score    Name');
    for i:=1 to 5 do begin
        gotoxy(55,14+i); write(a[i]);
        gotoxy(61,14+i); write(name[i]);
    end;
end;

function cal:longint; var i:integer; begin
    cal:=0;
    for i:=1 to lv-1 do
        cal:=cal+(i)*10*5;
end;

procedure mainplay; begin
    clrscr;
    speed:=200-(lv-1)*20;
    intbarrierandfood;
    x:='M'; xx:='a';
    inttwosnake;
    barrier;
    food;
    score:=cal; scoreai:=0;
    ok:=true;   dem:=0;
    while true do begin
        drawscreen;
        snake1;
        snake2;
        control;
        if ht=-1 then exit;
        check;
        if ok=false then begin clrscr; exit; end;
        if (tx<>fx)or(ty<>fy) then begin
           bfs; tx:=fx; ty:=fy;
        end;
        delay(speed);
        //vexephang;
    end;
end;


PROCEDURE about;
BEGIN
    clrscr;
    textcolor(white);
    writeln('Game : Snake Plus');
   textcolor(10); writeln('Tac gia:   Nguyen Tran Huu Dang');   textcolor(white);
    writeln('Lop:      11Tin thpt chuyen THD');
    writeln('Lien he:  https://www.facebook.com/huudang29052000 ');
    writeln('Y tuong:   De tim lai cam giac hung thu lap trinh, toi da bat tay nguyen cuu ');
    writeln('mot game cho vui');
    writeln('Va` cuoi cung toi cung da lap trinh thanh cong game "Snake plus"');
    writeln('theo thuat toan cua~ minh`');

    writeln;
    writeln('Nhan Enter de tro lai menu');
    key:=ord(readkey);
    IF key=13 THEN begin ht:=-1; menu; end;
END;

PROCEDURE huongdan;
BEGIN
    clrscr;
    textcolor(cyan);
    writeln('Ban phai dung cac phim mui ten: '+CHAR(24)+' '+CHAR(25)+' '+CHAR(26)+' '+CHAR(27));
    writeln('De dieu khien ran an duoc  va khong bi tong vao thanh hoac chuong ngai vat !');
    writeln('Neu ran xanh an duoc qua nhieu, ban se thua !');
    //writeln('Cac chuong ngai vat co kha nang bien mat, hay can than !');
    writeln('Toc do tro choi se tang theo tung LV');

    writeln;
    textcolor(white);
    writeln('Nhan Enter de tro lai menu');
    key:=ord(readkey);
    IF key=13 THEN begin ht:=-1; menu; end;
END;

procedure bangxh; var i:byte; begin
    clrscr;
    textcolor(green);
    gotoxy(35,10); write('SCORE      NAME');
    textcolor(yellow);
    for i:=1 to 5 do begin
        gotoxy(35,11+i); write(a[i]);
        gotoxy(42,11+i); write(name[i]);
    end;
    writeln;
    gotoxy(35,18);
    textcolor(white);
    writeln('Nhan Enter de tro lai menu');
    key:=ord(readkey);
    IF key=13 THEN begin ht:=-1; menu; end;
end;

procedure mainscreen; var x,y,tmp:integer;  ck:boolean;  begin
        x:=35; y:=9; ck:=true; tmp:=0; speed:=200; lv:=1;
        clrscr;
        textbackground(black);
        textcolor(white);
        gotoxy(35,5); writeln('ù _ ³  ÄÄ¿ ÄÄ¿');
        gotoxy(35,6); writeln('º º ³/  /  ÄÄ³');
        gotoxy(35,7); writeln('º º ³\ /_  __³');
        textcolor(green);
        gotoxy(60,24); write('Huu_Dang');
        gotoxy(x,y);
        if tmp=0 then textcolor(red) else textcolor(blue);
        if tmp<>1 then inc(tmp) else dec(tmp);
        write('SNAKEùùPLUS ëë');
        if ck then inc(x) else dec(x);
        if x>=36  then ck:=false;
        if x<=35 then ck:=true;
        //textcolor(yellow); gotoxy(29,20); writeln('BAM DAI 1 PHIM DE CHOI !');
        delay(400);
        tm:='.';
        ht:=1;
        textcolor(green);
        gotoxy(33,10);write('1.® Start ¯');
        textcolor(white);
        gotoxy(33,11);write('2.­ Ranking ­');
        textcolor(white);
        gotoxy(33,12);write('3.¨ How to play ¨' );
        textcolor(white);
        gotoxy(33,13);write('4. Credit ');
        textcolor(white);
        gotoxy(33,14);write('5. Exit ');
        repeat
        IF keypressed THEN BEGIN
           key:=ord(readkey);
           IF key=0 THEN key:=ord(readkey);
           IF key=80 THEN inc(ht);
           IF key=72 THEN dec(ht);
           IF ht=0 THEN ht:=5;
           IF ht=6 THEN ht:=1;
           IF ht=1 THEN BEGIN
              textcolor(green);
              gotoxy(33,10);write('1.® Start ¯');
              textcolor(white);
              gotoxy(33,11);write('2.­ Ranking ­');
              textcolor(white);
              gotoxy(33,12);write('3.¨ How to play ¨');
              textcolor(white);
              gotoxy(33,13);write('4. Credit ');
              textcolor(white);
              gotoxy(33,14);write('5. Exit ');
           END;
           IF ht=2 THEN BEGIN
              textcolor(white);
              gotoxy(33,10);write('1.® Start ¯');
              textcolor(10);
              gotoxy(33,11);write('2.­ Ranking ­');
              textcolor(white);
              gotoxy(33,12);write('3.¨ How to play ¨');
              textcolor(white);
              gotoxy(33,13);write('4. Credit ');
              textcolor(white);
              gotoxy(33,14);write('5. Exit ');
           END;
           IF ht=3 THEN BEGIN
              textcolor(white);
              gotoxy(33,10);write('1.® Start ¯');
              textcolor(white);
              gotoxy(33,11);write('2.­ Ranking ­');
              textcolor(10);
              gotoxy(33,12);write('3.¨ How to play ¨');
              textcolor(white);
              gotoxy(33,13);write('4. Credit ');
              textcolor(white);
              gotoxy(33,14);write('5. Exit ');
           END;
           IF ht=4 THEN BEGIN
              textcolor(white);
              gotoxy(33,10);write('1.® Start ¯');
              textcolor(white);
              gotoxy(33,11);write('2.­ Ranking ­');
              textcolor(white);
              gotoxy(33,12);write('3.¨ How to play ¨');
              textcolor(10);
              gotoxy(33,13);write('4. Credit ');
              textcolor(white);
              gotoxy(33,14);write('5. Exit ');
           END;
           IF ht=5 THEN BEGIN
              textcolor(white);
              gotoxy(33,10);write('1.® Start ¯');
              textcolor(white);
              gotoxy(33,11);write('2.­ Ranking ­');
              textcolor(white);
              gotoxy(33,12);write('3.¨ How to play ¨');
              textcolor(white);
              gotoxy(33,13);write('4. Credit ');
              textcolor(green);
              gotoxy(33,14);write('5. Exit ');
           END;
           IF key=13 THEN BEGIN
              IF ht=1 THEN mainplay;
              IF ht=2 THEN bangxh;
              IF ht=3 THEN huongdan;
              IF ht=4 THEN about;
              if ht=5 then halt;
           END;
       END;
       UNTIL ht=-1;

end;

begin
    randomize;
    speed:=200; lv:=1; cr:=5;
    a[1]:=900; name[1]:='Dang IT ';
    a[2]:=500; name[2]:='Dang cute ';
    a[3]:=350; name[3]:='Truong from hell';
    a[4]:=300; name[4]:='Trung trong trang';
    a[5]:=290; name[5]:='Donal Trump Oppa';

    while true do mainscreen;

    readln;
end.
