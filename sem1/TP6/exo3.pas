program pascal;

const rows = 20;

type matrix = array [1..rows , 1..rows] of longint;

procedure makeArray(var arr : matrix ; number : integer);

    var i , j : integer;

    begin 
        arr[1][1] := 1;
        arr[2][1] := 1; arr[2][2] := 1;
        for i := 3 to number do 
            begin 
                arr[i][1] := 1; 
                for j := 2 to i - 1 do 
                    arr[i][j] := arr[i-1][j-1] + arr[i-1][j];
                arr[i][i] := 1;
            end;
    end;
 
procedure displayPascal(arr : matrix ; number : integer);

    var i , j : integer;
    
    begin
        for i := 1 to number do 
            begin
                if (i < 11) then 
                    write('[Line ' , (i - 1) , ']   ')
                else
                    write('[Line ' , (i - 1) , ']  ');
                for j := 1 to i do 
                    write(arr[i][j]:6, ' ');
                writeln();
            end;
    end;


var 
    arr : matrix;
    number : integer;

begin
    repeat 
        write('Enter a number : ');readln(number);
        if (number > 20) or (number <= 0) then 
            writeln('Invalid Input!')
    until((number > 0) and (number <= 20));
    makeArray(arr , number);
    displayPascal(arr , number);
end.