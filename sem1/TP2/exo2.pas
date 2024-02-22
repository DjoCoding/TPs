program readingChars;

var number , i , count : integer;
    letter : char;
    result : string;

begin
    result := '';
    count := 0;
    repeat
        write('type a number greater than 2 : ');readln(number)
    until(number > 1);
    i := number;
    while (i > 0) do 
    begin  
        write('type the letter number ' , number - i + 1 , ' : ');readln(letter);
        result := result + letter;
        i := i - 1;
    end;
    for i := 0 to (number - 2) do 
    begin   
        if (result[i] = 'A') and (result[i+1] = 'B') then count := count + 1; 
    end;
    writeln('the number of times AB shows up is : ' , count)
end.