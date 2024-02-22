program ex1;

procedure fill(var arr : array of char);

    var i : integer;

    begin
        for i := 0 to 23 do 
            arr[i] := chr(random(25) + ord('A')); 
    end;

function count(arr : array of char ; target : char) : integer;

    var i , cpt : integer;

    begin
        cpt := 0;
        for i := 0 to 23 do 
            if (arr[i] = target) then 
                cpt := cpt + 1;
        count := cpt;
    end;

procedure display(arr : array of char);

    var i : integer;

    begin
        for i := 1 to 23 do 
            write(arr[i] , ' '); 
    end;

var arr : array[0..23] of char; 
    target : char;

begin
    Randomize;
    fill(arr);
    display(arr);
    writeln;
    write('type the character : ');readln(target);
    writeln('the number of times ' , target , ' shows up is : ' , count(arr , target));
end.
