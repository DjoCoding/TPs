program numberToLetters;

var number : integer;
    hundreds , tens , ones : integer;
    result , res , re: string;

begin 
    res := '';
    re := '';
    result := '';
    repeat
        write('type a positive number : ');readln(number);
    until(number > 0);

    hundreds := number div 100;
    tens := number div 10 - 10 * hundreds;
    ones := number mod 10 ;

    case hundreds of 
        1 : result := 'one hundred';
        2 : result := 'two hundreds';
        3 : result := 'three hundreds';
        4 : result := 'four hundreds';
        5 : result := 'five hundreds';
        6 : result := 'six hundreds';
        7 : result := 'seven hundreds';
        8 : result := 'eight hundreds';
        9 : result := 'nine hundreds';
    end;

    case tens of 
        1 : begin  
                case one of 
                    0 : res := 'ten';
                    1 : res := 'eleven';
                    2 : res := 'twelve';
                    3 : res := 'thirteen';
                    4 : res := 'fourteen';
                    5 : res := 'fifteen';
                    6 : res := 'sixteen';
                    7 : res := 'seventeen';
                    8 : res := 'eighteen';
                    9 : res := 'nineteen';
            end;
        2 : res := 'twenty';
        3 : res := 'thirty';
        4 : res := 'fourty';
        5 : res := 'fifty';
        6 : res := 'sixty';
        7 : res := 'seventy';
        8 : res := 'eighty';
        9 : res := 'ninety';
    end;

    case ones of 
        1 : re := 'one';
        2 : re := 'two';
        3 : re := 'three';
        4 : re := 'four';
        5 : re := 'five';
        6 : re := 'six';
        7 : re := 'seven';
        8 : re := 'eight';
        9 : re := 'nine';
    end;


if (hundreds = 0) then 
    if (tens = 0) then 
        if (ones = 0) then 
            result := 'Zero';
        else 
            result := re;
    else
        if (ones = 0) then
            result := res;
        else 
            if (tens <> 1) then 
                result := res + ' and ' + re;
            else 
                result := res;
else 
    if (tens = 0) then 
        if (ones = 0) then 
            result := result;
        else 
            result := result + ' and ' + re;
    else 
        if (ones = 0) then
            result := result + ' and ' + res;
        else 
            if (tens <> 1 ) then
                result := result + ' and ' + res + ' and ' + re;
            else 
                result := result + ' and ' + res;
    
writeln(result);
end.
            