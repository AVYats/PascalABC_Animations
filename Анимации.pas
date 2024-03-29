unit Анимации;

uses GraphABC, ABCSprites;

var xwind, ywind, xscreen, yscreen, steptime, currtime, maxtime, maxtitlelength:integer;
var fonepicture: Picture;
animationStart:boolean;

type
 Clip = class
 public
    xinit, yinit, xcur, ycur, width, height, xdiff, ydiff, maxxmov, maxymov, scalec, wblockscount, hblockscount: integer;  
    name:String;
    setmaxxmov, setmaxymov: boolean;
    pic: Picture;
    ObjArr: array [,] of SpriteABC;
    
 constructor create(nm:String; pc:Picture);
    begin
      xinit := 0;
      yinit := 0;
      xcur := 0; 
      ycur := 0;
      xdiff := 0; 
      ydiff := 0;
      pic := pc;
      name := nm;
      wblockscount := 1;
      hblockscount := 1;
      width := pic.Width;
      height := pic.Height;
      maxxmov := xwind;
      maxymov := ywind;
      setmaxxmov := false;
      setmaxymov := false;
      ObjArr := new SpriteABC[1,1];
      ObjArr[0,0] := new SpriteABC(0,0,width,pic);      
    end;  
    
    function РазмерКадра(wdth, higt:integer):Clip;
    begin
     if(pic.Width mod wdth = 0) and (pic.Width > wdth) then
     begin
       DestroyObjArr();
       width := wdth;
       height := higt;
       CreateObjArr();        
     end;
     Result := Self;
    end;
    
    function НачальноеПоложение(x,y:integer):Clip;
    begin
      xinit := x;
      yinit := y;
      xcur := x; 
      ycur := y;
      MoveObjArr();
      Result := Self;
    end;
    
    function РазмножитьВправоНа(n:integer):Clip;
    begin
      if(width*n <= xscreen) then
      begin
        DestroyObjArr();
        wblockscount := n;
        CreateObjArr();
      end;
      Result := Self;
    end; 
    
    function РазмножитьВнизНа(n:integer):Clip;
    begin
      if(height*n <= yscreen) then
      begin
        DestroyObjArr();
        hblockscount := n;
        CreateObjArr();
      end;
      Result := Self;
    end; 
    
    function Скорость(sp:integer):Clip;
    begin
      if(sp < 0) then
        sp := 0
      else if(sp > 10) then
        sp := 10;
          
      for var w := 0 to wblockscount-1 do
        for var h := 0 to hblockscount-1 do
          ObjArr[w,h].Speed := sp;
      Result := Self;
    end;
    
    function Перемещение(x, y, mx, my: integer):Clip;
    begin
     xdiff := x; 
     ydiff := y;
     maxxmov := mx;
     maxymov := my;
     Result := Self;
    end; 
    
    function СмещатьВлевоНа(x: integer):Clip;
    begin
     xdiff := -1*x; 
     Result := Self;
    end; 
    
    function СмещатьВправоНа(x: integer):Clip;
    begin
     xdiff := x; 
     Result := Self;
    end; 
    
    function СмещатьВверхНа(y: integer):Clip;
    begin
     ydiff := -1*y;
     Result := Self;
    end; 
        
    function СмещатьВнизНа(y: integer):Clip;
    begin
     ydiff := y;
     setmaxxmov := true;
     Result := Self;
    end; 
    
    function МаксГоризонтСмещение(mx: integer):Clip;
    begin
     maxxmov := mx;
     setmaxxmov := true;
     Result := Self;
    end;
    
    function МаксВертикСмещение(my: integer):Clip;
    begin
     maxymov := my;
     setmaxymov := true;
     Result := Self;
    end;
    
    procedure DestroyObjArr();
    begin 
      for var w := 0 to wblockscount-1 do
        for var h := 0 to hblockscount-1 do
          ObjArr[w,h].Destroy();     
      ObjArr := nil;
    end;
    
    procedure CreateObjArr();
    begin 
     ObjArr := new SpriteABC[wblockscount,hblockscount];
      for var w := 0 to wblockscount-1 do
        for var h := 0 to hblockscount-1 do
          ObjArr[w,h] := new SpriteABC(xcur+width*w,ycur+h*height,width,pic);
    end;
    
    procedure MoveObjArr();
    begin
     for var w := 0 to wblockscount-1 do
        for var h := 0 to hblockscount-1 do
          ObjArr[w,h].MoveTo(xcur+width*w,ycur+h*height); 
    end; 
    
    procedure DoStep();
    begin
      if(xdiff <> 0) then
      begin
        xcur := xcur+xdiff;
        if(xdiff > 0) then
        begin       
           if( (xcur - xinit) >= maxxmov) then
           begin
             xcur := xinit;
             ycur := yinit;
           end
        end
        else if(xdiff < 0) then
        begin
          if( (xinit - xcur) >= maxxmov) then
          begin
             xcur := xinit;
             ycur := yinit;
          end
        end
      end;
      if(ydiff <> 0) then
      begin
        ycur := ycur+ydiff;
        if(ydiff > 0) then
        begin
           if( (ycur - yinit) >= maxymov) then
           begin
             xcur := xinit;
             ycur := yinit;
           end
        end
        else if(ydiff < 0) then
        begin
          if( (yinit - ycur) >= maxymov) then
          begin
             xcur := xinit;
             ycur := yinit;
          end
        end
      end;
    MoveObjArr();
   end;      
 end;
  
var ClipArr: array of Clip;
  
function СоздатьКлип(name, pic:String):Clip;
begin
  var pict:Picture;
  if FileExists(pic) then
    pict := Picture.Create(pic)
  else
  begin
    pict := Picture.Create(50,50); 
    pict.Line(0,0,50,50,clRed); 
    pict.Line(50,0,0,50,clRed); 
  end;    
  if (ClipArr = nil) then
  begin
    ClipArr := new Clip[1];
    ClipArr[0] := new Clip(name, pict);
    Result := ClipArr[0];
  end
  else
  begin
    var ClipArrCopy := new Clip[ClipArr.Length+1];
    for var i := 0 to ClipArr.Length-1 do
      ClipArrCopy[i] := ClipArr[i];
    ClipArrCopy[ClipArrCopy.Length-1] := new Clip(name, pict);
    ClipArr := nil;
    ClipArr := new Clip[ClipArrCopy.Length]; 
    for var i := 0 to ClipArrCopy.Length-1 do
      ClipArr[i] := ClipArrCopy[i];
    ClipArrCopy := nil;
    Result := ClipArr[ClipArr.Length-1];
  end
end;

function Клип(name:String):Clip;
begin
  for var i := 0 to ClipArr.Length-1 do
    if ClipArr[i].name = name then
    begin
      Result := ClipArr[i];
      break;
    end; 
end;

procedure SetFonePictureFullWnd();
begin
 if(fonepicture <> nil) then
  begin
    fonepicture.Width := xwind;
    fonepicture.Height := ywind;
    fonepicture.Draw(0, 0);
  end;  
end;

procedure РазмерОкна(x,y:integer);
begin
  if(x > xscreen) then
    xwind := xscreen
  else if (x <= 0) then
    xwind := 1
  else
    xwind := x;
  if(y > yscreen) then
    ywind := yscreen
  else if (y <= 0) then
    ywind := 1
  else
    ywind := y; 
      
  SetWindowSize(xwind, ywind);
  SetFonePictureFullWnd();
end;

procedure ЗаголовокОкна(title:String);
begin
    if(title.Length > maxtitlelength) then
      title := LeftStr(title, maxtitlelength);
    SetWindowTitle(title);//задаем заголовок графического окна
end;

procedure ФоноваяКартинка(pic:String);
begin
  if FileExists(pic) then
    fonepicture := Picture.Create(pic)
  else
  begin
    fonepicture := Picture.Create(xwind,ywind); 
    fonepicture.Line(0,0,xwind,ywind,clRed); 
    fonepicture.Line(xwind,0,0,ywind,clRed); 
  end;  
  SetFonePictureFullWnd();
end;

procedure ЗапуститьАнимацию();
begin
 if(ClipArr <> nil) then
   if (ClipArr.Length <> 0) then
   begin
     animationStart := true;
     StartSprites();
     repeat  
      for var i := 0 to ClipArr.Length-1 do
        ClipArr[i].DoStep();  
      sleep(steptime);
     until(animationStart = false); 
   end
end;

begin
  xwind := 800;
  ywind := 600;
  xscreen := ScreenWidth();
  yscreen := ScreenHeight();
  animationStart := false;
  maxtitlelength := 100;
  steptime := 100;
  currtime := 0;
  maxtime := 0;
  SetWindowTitle('Анимация');//задаем заголовок графического окна
  SetWindowSize(xwind, ywind); //задаем размер графического окна    
end.