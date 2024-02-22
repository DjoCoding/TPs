program displayText;

type arr = array[1..4] of shortint;

var nums : arr;
    i : integer;
    number : integer;

procedure fill(var number : integer);

    begin
        for i := 4 downto 1 do 
            begin
                nums[i] := number mod 10;
                number := number div 10;
            end;
    end;

procedure display();

    var countZeros : shortint;

    begin
        countZeros := 0;

        for i := 1 to 4 do 
            begin
                case i of 
                    1 : begin
                            case nums[i] of 
                                1 : write('One ');
                                2 : write('Two ');
                                3 : write('Three ');
                                4 : write('Four ');
                                5 : write('Five ');
                                6 : write('Six ');
                                7 : write('Seven ');
                                8 : write('Eight ');
                                9 : write('Nine ');
                            end; 
                            if (nums[i] = 0) then countZeros := countZeros + 1
                            else  write('Thousand '); 
                        end;

                    2 : begin
                            case nums[i] of 
                                1 : write('One ');
                                2 : write('Two  ');
                                3 : write('Three  ');
                                4 : write('Four  ');
                                5 : write('Five  ');
                                6 : write('Six  ');
                                7 : write('Seven ');
                                8 : write('Eight ');
                                9 : write('Nine ');
                            end; 
                            if (nums[i] = 0) then countZeros := countZeros + 1
                            else 
                                if (nums[i] = 1) then write('Hundred ')
                                else write('Hundreds ');
                        end;
                    
                    3 : begin
                            case nums[i] of 
                                2 : write('Twenty ');
                                3 : write('Thirty ');
                                4 : write('Fourty ');
                                5 : write('Fifty ');
                                6 : write('Sixty ');
                                7 : write('Seventy ');
                                8 : write('Eighty ');
                                9 : write('Ninety ');
                            end;
                            if (nums[i] = 0) then countZeros := countZeros + 1;
                        end;
                    
                    4 : begin
                            if (nums[i-1] = 1) then 
                                case (nums[i]) of
                                    0 : begin
                                            if (countZeros <> 3) then 
                                                write('Ten'); 
                                        end;
                                    1 : write('Eleven ');
                                    2 : write('Twelve ');
                                    3 : write('Thirteen ');
                                    4 : write('Fourteen ');
                                    5 : write('Fifteen ');
                                    6 : write('Sixteen ');
                                    7 : write('Seventeen ');
                                    8 : write('Eighteen ');
                                    9 : write('Nineteen ');
                                end
                            else
                                case nums[i] of 
                                    0 : countZeros := countZeros + 1;
                                    1 : write('One ');
                                    2 : write('Two');
                                    3 : write('Three');
                                    4 : write('Four');
                                    5 : write('Five');
                                    6 : write('Six');
                                    7 : write('Seven');
                                    8 : write('Eight');
                                    9 : write('Nine');
                                end;
                        end;
                end;

            end;
        if (countZeros = 4) then write('Zero');
        writeln;

    end;


begin
    repeat
        write('Type a number : ');readln(number);
        if (number > 9999) or (number < 0) then 
            writeln('Invalid input!!');
    until((number >= 0) and (number < 10000));

    fill(number);
    write('The number is : ');

    for i := 1 to 4 do 
        write(nums[i]);
    writeln();
    
    write('The number in words is : ');
    display();
end.