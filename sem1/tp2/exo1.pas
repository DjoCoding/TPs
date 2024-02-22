program divisors;

var 
    number , i : integer;

begin
    write('type a number : ');readln(number);
    for i := 1 to (number div 2) do     
    begin
        if (number mod i = 0) then writeln(i);
    end;
    writeln(number)
end.