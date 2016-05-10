unit unitXOAI;

interface

type
  TMyArr = Array of Array of Integer;

function IsWin(var arr: TMyArr; xsize, ysize: Integer): Integer;
procedure AI(var arr: TMyArr; xsize, ysize: Integer);

implementation

function IsWin(var arr: TMyArr; xsize, ysize: Integer): Integer;
var
  i, j, k: Integer;
  tmp: Integer;
begin
  Result := 0;
  
  for i := 0 to xsize - 1 do
    for j := 0 to ysize - 1 do
      if arr[i, j] <> 0 then
      begin

        if arr[i, j] = 1 then
          tmp := -1
        else
          tmp := 1;

        if i + 4 <= xsize - 1 then
          if (arr[i, j] = arr[i + 1, j]) and
             (arr[i, j] = arr[i + 2, j]) and
             (arr[i, j] = arr[i + 3, j]) and
             (arr[i, j] = arr[i + 4, j]) then
          begin
            Result := tmp;

            for k := 0 to 4 do
              if arr[i + k, j] = 1 then
                arr[i + k, j] := 3
              else
                arr[i + k, j] := 4;

            break;
          end;

        if j + 4 <= ysize - 1 then
          if (arr[i, j] = arr[i, j + 1]) and
             (arr[i, j] = arr[i, j + 2]) and
             (arr[i, j] = arr[i, j + 3]) and
             (arr[i, j] = arr[i, j + 4]) then
          begin
            Result := tmp;

            for k := 0 to 4 do
              if arr[i, j + k] = 1 then
                arr[i, j + k] := 3
              else
                arr[i, j + k] := 4;

            break;
          end;

        if (i + 4 <= xsize - 1) and (j + 4 <= ysize - 1) then
          if (arr[i, j] = arr[i + 1, j + 1]) and
             (arr[i, j] = arr[i + 2, j + 2]) and
             (arr[i, j] = arr[i + 3, j + 3]) and
             (arr[i, j] = arr[i + 4, j + 4]) then
          begin
            Result := tmp;

            for k := 0 to 4 do
              if arr[i + k, j + k] = 1 then
                arr[i + k, j + k] := 3
              else
                arr[i + k, j + k] := 4;

            break;
          end;

        if (i + 4 <= xsize - 1) and (j - 4 >= 0) then
          if (arr[i, j] = arr[i + 1, j - 1]) and
             (arr[i, j] = arr[i + 2, j - 2]) and
             (arr[i, j] = arr[i + 3, j - 3]) and
             (arr[i, j] = arr[i + 4, j - 4]) then
          begin
            Result := tmp;

            for k := 0 to 4 do
              if arr[i + k, j - k] = 1 then
                arr[i + k, j - k] := 3
              else
                arr[i + k, j - k] := 4;

            break;
          end;

      end;
end;

procedure AI(var arr: TMyArr; xsize, ysize: Integer);

  function CanWin: Boolean;
  var
    i, j, k, w: Integer;
  begin
    Result := False;

    for i := 0 to xsize - 1 do
      for j := 0 to ysize - 1 do
      begin

        //горизонтальные
        if (i <= xsize - 5) and (not Result) then
        begin
          w := 0;

          for k := 0 to 4 do
            if arr[i + k, j] = 1 then
              inc(w)
            else if arr[i + k, j] = 2 then
              w := 0;

          if w = 4 then
            for k := 0 to 4 do
              if arr[i + k, j] = 0 then
              begin
                arr[i + k, j] := 1;
                Result := True;
                break;
              end;
        end;

        //вертикальные
        if (j <= ysize - 5) and (not Result) then
        begin
          w := 0;

          for k := 0 to 4 do
            if arr[i, j + k] = 1 then
              inc(w)
            else if arr[i, j + k] = 2 then
              w := 0;

          if w = 4 then
            for k := 0 to 4 do
              if arr[i, j + k] = 0 then
              begin
                arr[i, j + k] := 1;
                Result := True;
                break;
              end;
        end;

        //диагональные
        if (i <= xsize - 5) and (j <= ysize - 5) and (not Result) then
        begin
          w := 0;

          for k := 0 to 4 do
            if arr[i + k, j + k] = 1 then
              inc(w)
            else if arr[i + k, j + k] = 2 then
              w := 0;

          if w = 4 then
            for k := 0 to 4 do
              if arr[i + k, j + k] = 0 then
              begin
                arr[i + k, j + k] := 1;
                Result := True;
                break;
              end;
        end;

        //диагональные 2
        if (i <= xsize - 5) and (j >= 4) and (not Result) then
        begin
          w := 0;

          for k := 0 to 4 do
            if arr[i + k, j - k] = 1 then
              inc(w)
            else if arr[i + k, j - k] = 2 then
              w := 0;

          if w = 4 then
            for k := 0 to 4 do
              if arr[i + k, j - k] = 0 then
              begin
                arr[i + k, j - k] := 1;
                Result := True;
                break;
              end;
        end;

      end;
  end;

  function DontWinEnemy: Boolean;
  var
    i, j, k, w: Integer;
  begin
    Result := False;

    for i := 0 to xsize - 1 do
      for j := 0 to ysize - 1 do
      begin

        //горизонтальные
        if (i <= xsize - 5) and (not Result) then
        begin
          w := 0;

          for k := 0 to 4 do
            if arr[i + k, j] = 2 then
              inc(w)
            else if arr[i + k, j] = 1 then
              w := 0;

          if w = 4 then
            for k := 0 to 4 do
              if arr[i + k, j] = 0 then
              begin
                arr[i + k, j] := 1;
                Result := True;
                break;
              end;
        end;

        //вертикальные
        if (j <= ysize - 5) and (not Result) then
        begin
          w := 0;

          for k := 0 to 4 do
            if arr[i, j + k] = 2 then
              inc(w)
            else if arr[i, j + k] = 1 then
              w := 0;

          if w = 4 then
            for k := 0 to 4 do
              if arr[i, j + k] = 0 then
              begin
                arr[i, j + k] := 1;
                Result := True;
                break;
              end;
        end;

        //диагональные
        if (i <= xsize - 5) and (j <= ysize - 5) and (not Result) then
        begin
          w := 0;

          for k := 0 to 4 do
            if arr[i + k, j + k] = 2 then
              inc(w)
            else if arr[i + k, j + k] = 1 then
              w := 0;

          if w = 4 then
            for k := 0 to 4 do
              if arr[i + k, j + k] = 0 then
              begin
                arr[i + k, j + k] := 1;
                Result := True;
                break;
              end;
        end;

        //диагональные 2
        if (i <= xsize - 5) and (j >= 4) and (not Result) then
        begin
          w := 0;

          for k := 0 to 4 do
            if arr[i + k, j - k] = 2 then
              inc(w)
            else if arr[i + k, j - k] = 1 then
              w := 0;

          if w = 4 then
            for k := 0 to 4 do
              if arr[i + k, j - k] = 0 then
              begin
                arr[i + k, j - k] := 1;
                Result := True;
                break;
              end;
        end;

      end;
  end;

  function DontEnemyMakeFourInLine: Boolean;
  var
    i, j, k, w: Integer;
  begin
    Result := False;

    for i := 0 to xsize - 1 do
      for j := 0 to ysize - 1 do
      begin

        //горизонтальные
        if (i <= xsize - 4) and (not Result) then
        begin
          w := 0;

          for k := 0 to 3 do
            if arr[i + k, j] = 2 then
              inc(w)
            else if arr[i + k, j] = 1 then
              w := 0;

          if w = 3 then
            for k := 0 to 3 do
              if arr[i + k, j] = 0 then
              begin
                arr[i + k, j] := 1;
                Result := True;
                break;
              end;
        end;

        //вертикальные
        if (j <= ysize - 4) and (not Result) then
        begin
          w := 0;

          for k := 0 to 3 do
            if arr[i, j + k] = 2 then
              inc(w)
            else if arr[i, j + k] = 1 then
              w := 0;

          if w = 3 then
            for k := 0 to 3 do
              if arr[i, j + k] = 0 then
              begin
                arr[i, j + k] := 1;
                Result := True;
                break;
              end;
        end;

        //диагональные
        if (i <= xsize - 4) and (j <= ysize - 4) and (not Result) then
        begin
          w := 0;

          for k := 0 to 3 do
            if arr[i + k, j + k] = 2 then
              inc(w)
            else if arr[i + k, j + k] = 1 then
              w := 0;

          if w = 3 then
            for k := 0 to 3 do
              if arr[i + k, j + k] = 0 then
              begin
                arr[i + k, j + k] := 1;
                Result := True;
                break;
              end;
        end;

        //диагональные 2
        if (i <= xsize - 4) and (j >= 3) and (not Result) then
        begin
          w := 0;

          for k := 0 to 3 do
            if arr[i + k, j - k] = 2 then
              inc(w)
            else if arr[i + k, j - k] = 1 then
              w := 0;

          if w = 3 then
            for k := 0 to 3 do
              if arr[i + k, j - k] = 0 then
              begin
                arr[i + k, j - k] := 1;
                Result := True;
                break;
              end;
        end;

      end;
  end;

  function DontEnemyMakeCross: Boolean;
  var
    i, j: Integer;
  begin
    Result := False;

    for i := 2 to xsize - 3 do
      for j := 2 to ysize - 3 do
        if (arr[i - 2, j] = 0) and
           (arr[i + 2, j] = 0) and
           (arr[i, j - 2] = 0) and
           (arr[i, j + 2] = 0) and
           (arr[i, j] = 0) and
           (arr[i - 1, j] = 2) and
           (arr[i + 1, j] = 2) and
           (arr[i, j - 1] = 2) and
           (arr[i, j + 1] = 2) and
           (not Result) then
        begin
          arr[i, j] := 1;
          Result := True;
          break;
        end;
  end;

  function DontEnemyMakePerekrestok: Boolean;
  var
    i, j: Integer;
  begin
    Result := False;

    //низ-право
    if not Result then
      for i := 1 to xsize - 3 do
        for j := 1 to ysize - 3 do
          if (arr[i - 1, j] = 0) and
             (arr[i, j - 1] = 0) and
             (arr[i, j] = 0) and
             (arr[i + 1, j] = 2) and
             (arr[i + 2, j] = 2) and
             (arr[i, j + 1] = 2) and
             (arr[i, j + 2] = 2) and
             (not Result) then
          begin
            arr[i, j] := 1;
            Result := True;
            break;
          end;

    //низ-лево
    if not Result then
      for i := 2 to xsize - 2 do
        for j := 1 to ysize - 3 do
          if (arr[i + 1, j] = 0) and
             (arr[i, j - 1] = 0) and
             (arr[i, j] = 0) and
             (arr[i - 1, j] = 2) and
             (arr[i - 2, j] = 2) and
             (arr[i, j + 1] = 2) and
             (arr[i, j + 2] = 2) and
             (not Result) then
          begin
            arr[i, j] := 1;
            Result := True;
            break;
          end;

    //верх-лево
    if not Result then
      for i := 2 to xsize - 2 do
        for j := 2 to ysize - 2 do
          if (arr[i + 1, j] = 0) and
             (arr[i, j + 1] = 0) and
             (arr[i, j] = 0) and
             (arr[i - 1, j] = 2) and
             (arr[i - 2, j] = 2) and
             (arr[i, j - 1] = 2) and
             (arr[i, j - 2] = 2) and
             (not Result) then
          begin
            arr[i, j] := 1;
            Result := True;
            break;
          end;

    //верх-право
    if not Result then
      for i := 1 to xsize - 3 do
        for j := 2 to ysize - 2 do
          if (arr[i - 1, j] = 0) and
             (arr[i, j + 1] = 0) and
             (arr[i, j] = 0) and
             (arr[i + 1, j] = 2) and
             (arr[i + 2, j] = 2) and
             (arr[i, j - 1] = 2) and
             (arr[i, j - 2] = 2) and
             (not Result) then
          begin
            arr[i, j] := 1;
            Result := True;
            break;
          end;
  end;

  function RandomMove: Boolean;
  var
    i, j, x, y: Integer;
  begin
    Result := False;

    for i := 0 to 200 do
      if not Result then
      begin
        x := Random(xsize);
        y := Random(ysize);
        if arr[x, y] = 0 then
        begin
          arr[x, y] := 1;
          Result := True;
          break;
        end;
      end;

    if not Result then
      for i := 0 to xsize - 1 do
        for j := 0 to ysize - 1 do
          if arr[i, j] = 0 then
            if not Result then
            begin
              arr[i, j] := 1;
              Result := True;
              break;
            end;
  end;

  function MakeCross: Boolean;
  var
    i, j: Integer;
  begin
    Result := False;

    for i := 1 to xsize - 2 do
      for j := 1 to ysize - 2 do
        if (arr[i, j] = 0) and
           (arr[i + 1, j] = 1) and
           (arr[i - 1, j] = 1) and
           (arr[i, j + 1] = 1) and
           (arr[i, j - 1] = 1) and
           (arr[i + 2, j] = 0) and
           (arr[i - 2, j] = 0) and
           (arr[i, j + 2] = 0) and
           (arr[i, j - 2] = 0) and
           (not Result) then
        begin
          arr[i, j] := 1;
          Result := True;
          break;
        end;
  end;

  function MakeLines(xmin, xmax: Integer): Boolean;

    function MakeHorizontalLines(d: Integer): Boolean;
    var
      i, j, k, w: Integer;
    begin
      Result := False;

      for i := 0 to xsize - 5 do
        for j := 0 to ysize - 1 do
          if ((arr[i, j] = 0) or (arr[i, j] = 1)) and (not Result) then
          begin
            w := 0;

            for k := 0 to 4 do
              if arr[i + k, j] = 1 then
                inc(w)
              else if arr[i + k, j] = 2 then
                w := -5;

            if w >= d then
            begin
              for k := 0 to 4 do
              begin
                if arr[i + k, j] = 1 then
                  w := 5;

                if (arr[i + k, j] = 0) and (not Result) and (w = 5) then
                begin
                  arr[i + k, j] := 1;
                  Result := True;
                  break;
                end;
              end;

              w := 0;

              if not Result then
                for k := 4 downto 0 do
                begin
                  if arr[i + k, j] = 1 then
                    w := 5;

                  if (arr[i + k, j] = 0) and (not Result) and (w = 5) then
                  begin
                    arr[i + k, j] := 1;
                    Result := True;
                    break;
                  end;
                end;
            end;
          end;
    end;

    function MakeVerticalLines(d: Integer): Boolean;
    var
      i, j, k, w: Integer;
    begin
      Result := False;

      for i := 0 to xsize - 1 do
        for j := 0 to ysize - 5 do
          if ((arr[i, j] = 0) or (arr[i, j] = 1)) and (not Result) then
          begin
            w := 0;

            for k := 0 to 4 do
              if arr[i, j + k] = 1 then
                inc(w)
              else if arr[i, j + k] = 2 then
                w := -5;

            if w >= d then
            begin
              for k := 0 to 4 do
              begin
                if arr[i, j + k] = 1 then
                  w := 5;

                if (arr[i, j + k] = 0) and (not Result) and (w = 5) then
                begin
                  arr[i, j + k] := 1;
                  Result := True;
                  break;
                end;
              end;

              w := 0;

              if not Result then
                for k := 4 downto 0 do
                begin
                  if arr[i, j + k] = 1 then
                    w := 5;

                  if (arr[i, j + k] = 0) and (not Result) and (w = 5) then
                  begin
                    arr[i, j + k] := 1;
                    Result := True;
                    break;
                  end;
                end;
            end;
          end;
    end;

    function MakeDiagonalLines(d: Integer): Boolean;
    var
      i, j, k, w: Integer;
    begin
      Result := False;

      for i := 0 to xsize - 5 do
        for j := 0 to ysize - 5 do
          if ((arr[i, j] = 0) or (arr[i, j] = 1)) and (not Result) then
          begin
            w := 0;

            for k := 0 to 4 do
              if arr[i + k, j + k] = 1 then
                inc(w)
              else if arr[i + k, j + k] = 2 then
                w := -5;

            if w >= d then
            begin
              for k := 0 to 4 do
              begin
                if arr[i + k, j + k] = 1 then
                  w := 5;

                if (arr[i + k, j + k] = 0) and (not Result) and (w = 5) then
                begin
                  arr[i + k, j + k] := 1;
                  Result := True;
                  break;
                end;
              end;

              w := 0;

              if not Result then
                for k := 4 downto 0 do
                begin
                  if arr[i + k, j + k] = 1 then
                    w := 5;

                  if (arr[i + k, j + k] = 0) and (not Result) and (w = 5) then
                  begin
                    arr[i + k, j + k] := 1;
                    Result := True;
                    break;
                  end;
                end;
            end;
          end;
    end;

    function MakeDiagonalLines2(d: Integer): Boolean;
    var
      i, j, k, w: Integer;
    begin
      Result := False;

      for i := 0 to xsize - 5 do
        for j := 0 to ysize - 5 do
          if ((arr[i, j] = 0) or (arr[i, j] = 1)) and (not Result) then
          begin
            w := 0;

            for k := 0 to 4 do
              if arr[i + k, j + k] = 1 then
                inc(w)
              else if arr[i + k, j + k] = 2 then
                w := -5;

            if w >= d then
            begin
              for k := 0 to 4 do
              begin
                if arr[i + k, j + k] = 1 then
                  w := 5;

                if (arr[i + k, j + k] = 0) and (not Result) and (w = 5) then
                begin
                  arr[i + k, j + k] := 1;
                  Result := True;
                  break;
                end;
              end;

              w := 0;

              if not Result then
                for k := 4 downto 0 do
                begin
                  if arr[i + k, j + k] = 1 then
                    w := 5;

                  if (arr[i + k, j + k] = 0) and (not Result) and (w = 5) then
                  begin
                    arr[i + k, j + k] := 1;
                    Result := True;
                    break;
                  end;
                end;
            end;
          end;
    end;

    function RandomLines: Boolean;
    var
      i, j, k: Integer;
    begin
      Result := False;

      for j := xmax downto xmin do
        for i := 0 to 10 do
          if not Result then
          begin
            k := Random(4);

            case k of
            0: Result := MakeHorizontalLines(j);
            1: Result := MakeVerticalLines(j);
            2: Result := MakeDiagonalLines(j);
            3: Result := MakeDiagonalLines2(j);
            end;

          end else
            break;
    end;

  begin
    Result := RandomLines;
  end;

begin
  //НАПАДЕНИЕ
  //выиграть, если можно
  if not CanWin then
    //ЗАЩИТА
    //не позволить выиграть противнику
    if not DontWinEnemy then
      //НАПАДЕНИЕ
      //делать линии
      if not MakeLines(3, 4) then
        //не дать сделать крест
        if not DontEnemyMakeCross then
          //не дать сделать перекрёсток
          if not DontEnemyMakePerekrestok then
            //не дать поставить четыре в открытом ряду,
            //если через ход он сможет довести до пяти в ряд
            if not DontEnemyMakeFourInLine then
              //НАПАДЕНИЕ
              //делать крест
              if not MakeCross then
                //делать линии
                if not MakeLines(1, 2) then
                  //поставить куда угодно
                  RandomMove;

end;

end.
