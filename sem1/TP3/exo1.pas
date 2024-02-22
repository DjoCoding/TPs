program divisors;

var number , i , sum: integer;

begin
    sum := 0;
    write('please type a number : ');readln(number);
    if (number < 0) then number := number * (-1);
    if (number = 0 ) then writeln('all numbers in Z (the set of integers) divide 0');
    i := 2;
    while (i < number) do 
    begin
        if (number mod i = 0) then 
        begin
            writeln(i , ' and ' , (-1)*i  , ' divide ' , number);
            sum := sum + i;
        end;
    i := i + 1;
    end;
    writeln('the sum of all the positive divisors of ' , number , ' without 1 and ' , number , ' is ' , sum)
end.