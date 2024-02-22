program square;

var number , i : integer;

begin
    repeat 
        write('type a positive number : ');readln(number);
    until(number >= 0);

    i := 0;
    write('{');
    while (i <= number) do 
    begin
        if (i * i <= number) then write(i , ' , ' )
        else break;
        i := i + 1;
    end;
    write('} all those numbers verifie the given inequality')
end.