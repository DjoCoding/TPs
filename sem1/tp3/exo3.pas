program check;

var number , hundreds , tens , ones : integer;

begin
    number := 2;
    while (number < 999) do
    begin

        hundreds := number div 100;
        ones := number mod 10;
        tens := (number - ((hundreds * 100) + ones)) div 10;
        

        if (hundreds + tens + ones <= 10) then 
            writeln(number , ' is one of those numbers that has this proprety');
        
        number := number + 1;
    end;
end.