program findDiff;

function isBissextile(year : integer) : boolean;

    var result : boolean;
        
    begin 

        result := True;

        if (year mod 100 = 0) then 

            begin 
                if ((year div 100) mod 4 <> 0) then  

                    result := False;
            end
        
        else    
            
            if (year mod 4 <> 0) then result := False;
        
        isBissextile := result;
        

    end;

function diffDays(year1 , year2 , month1 , month2 , day1 , day2 : integer ; var count : integer) : integer;

    var i , diff : integer;

    begin 

        if (year1 = year2) then     

            begin 

                if (month1 = month2) then diff := day2 - day1
            
                else 
                    
                    begin 

                        if (month2 - month1 = 1) then 

                            begin   
                                
                                case month1 of 
                                    1 : diff := 31 - day1;
                                    2 : begin
                                            if isBissextile(year1) then  
                                                diff := 29 - day1
                                            else diff := 28 - day1;
                                        end;
                                    3 : diff := 31 - day1;
                                    4 : diff := 30 - day1;
                                    5 : diff := 31 - day1;
                                    6 : diff := 30 - day1;
                                    7 : diff := 31 - day1;
                                    8 : diff := 31 - day1;
                                    9 : diff := 30 - day1;
                                    10 : diff := 31 - day1;
                                    11 : diff := 30 - day1;
                                    12 : diff := 31 - day1;
                                end;

                                count := diff;

                                diff := diff + day2;
                            
                            end
                            
                        else

                            begin

                                case month1 of 
                                    1 : diff := 31 - day1;
                                    2 : begin
                                            if isBissextile(year1) then  
                                                diff := 29 - day1
                                            else diff := 28 - day1;
                                        end;
                                    3 : diff := 31 - day1;
                                    4 : diff := 30 - day1;
                                    5 : diff := 31 - day1;
                                    6 : diff := 30 - day1;
                                    7 : diff := 31 - day1;
                                    8 : diff := 31 - day1;
                                    9 : diff := 30 - day1;
                                    10 : diff := 31 - day1;
                                    11 : diff := 30 - day1;
                                    12 : diff := 31 - day1;
                                end; 

                                diff := diff + day2;

                                for i := month1 + 1 to month2 - 1 do 

                                    begin 

                                        case i of 
                                            2 : begin
                                                    if isBissextile(year1) then  
                                                        diff := 29 + diff
                                                    else diff := 28 + diff;
                                                end;
                                            3 : diff := 31 + diff;
                                            4 : diff := 30 + diff;
                                            5 : diff := 31 + diff;
                                            6 : diff := 30 + diff;
                                            7 : diff := 31 + diff;
                                            8 : diff := 31 + diff;
                                            9 : diff := 30 + diff;
                                            10 : diff := 31 + diff;
                                            11 : diff := 30 + diff;
                                        end;

                                    end;

                            end;
                    
                    end;
                        
            end
        
        else 

            begin

                case month1 of 
                    1 : diff := 31 - day1;
                    2 : begin
                            if isBissextile(year1) then  
                                diff := 29 - day1
                            else diff := 28 - day1;
                        end;
                    3 : diff := 31 - day1;
                    4 : diff := 30 - day1;
                    5 : diff := 31 - day1;
                    6 : diff := 30 - day1;
                    7 : diff := 31 - day1;
                    8 : diff := 31 - day1;
                    9 : diff := 30 - day1;
                    10 : diff := 31 - day1;
                    11 : diff := 30 - day1;
                    12 : diff := 31 - day1;
                end; 

                diff := diff + day2;

                for i := month1 + 1 to 12 do 

                    begin 
                        
                        case i of
                            2 : begin 
                                    if (isBissextile(year1)) then 
                                        diff := diff + 29
                                    else 
                                        diff := diff + 28;
                                end;
                            3 : diff := 31 + diff;
                            4 : diff := 30 + diff;
                            5 : diff := 31 + diff;
                            6 : diff := 30 + diff;
                            7 : diff := 31 + diff;
                            8 : diff := 31 + diff;
                            9 : diff := 30 + diff;
                            10 : diff := 31 + diff;
                            11 : diff := 30 + diff;
                            12 : diff := 31 + diff;
                        end;

                    end;
                
                for i := 1 to month2 - 1 do 

                    begin 
                        
                        case i of
                            1 : diff := diff + 31;
                            2 : begin 
                                    if (isBissextile(year2)) then 
                                        diff := diff + 29
                                    else 
                                        diff := diff + 28
                                end;
                            3 : diff := 31 + diff;
                            4 : diff := 30 + diff;
                            5 : diff := 31 + diff;
                            6 : diff := 30 + diff;
                            7 : diff := 31 + diff;
                            8 : diff := 31 + diff;
                            9 : diff := 30 + diff;
                            10 : diff := 31 + diff;
                            11 : diff := 30 + diff;
                        end;
                        
                    end;

                end;

            // just did this because if year2 - year1 = 1 then diffDays = diff only and not diff + (some month) (always remember that for i := x to x will iterate x -x + 1 then 1!!!!!)
            if (year2 - year1 <> 1) then 
                
                begin

                    for i := year1 + 1 to year2 - 1 do 

                        begin 

                            if isBissextile(i) then 

                                diff := diff + 366
                            
                            else 

                                diff := diff + 365

                        end;

                end;

        diffDays := diff;

    end;

function diffMonths(year1 , year2 , month1 , month2 , day1 , day2 , count : integer ; var count2 : integer) : integer;

    var diff : integer;

    begin

        diff := 0;
        
        if (year1 = year2) then 

            begin 

                if (month1 = month2) then 

                    begin 
                        count2 := day2 - day1;
                    end
                
                else 

                    begin 
                        
                        while (month1 + 1 < month2) do 

                            begin
                                diff := diff + 1;
                                month1 := month1 + 1;
                            end;
                        
                        if (day2 >= day1) then 
                            begin
                                diff := diff + 1;
                                count2 := day2 - day1;
                            end

                        else 
                            begin
                                count2 := count + day2;
                            end

                    end;

            end
        
        else 

            begin 

                while (year1 + 1 < year2) do 

                    begin 
                        year1 := year1 + 1;
                        diff := diff + 12
                    end;

                while (month1 + 1 < month2 + 12) do

                    begin 
                        diff := diff + 1;
                        month1 := month1 + 1
                    end; 

                if (day2 >= day1) then 
                    begin
                        diff := diff + 1;
                        count2 := day2 - day1;
                    end
                    
                else 
                    begin
                        count2 := count + day2;
                    end
            
            end;

                    
        diffMonths := diff;

    end;

var year1 , year2 , month1 , month2 , day1 , day2 , daysByMonths , daysOnly , months: integer;

begin 
    
    writeln();
    writeln('===========================Date Calculator===========================');
    writeln();
    writeln('                            START DATE');
    writeln();
    write('year : ');readln(year1);
    write('month : ');readln(month1);
    write('day : ');readln(day1);

    writeln();
    
    writeln('                             END DATE');   
    writeln();
    write('year : ');readln(year2);
    write('month : ');readln(month2);
    write('day : ');readln(day2);

    months := diffMonths(year1 , year2 , month1 , month2 , day1 , day2 , daysOnly , daysByMonths);

    writeln();
    writeln('Difference between ' , day1 , '/' , month1 , '/' , year1 , ' and ' , day2 , '/' , month2 , '/' , year2 , ':');
    writeln();

    writeln(months div 12 , ' years ' , months mod 12 , ' months ' , daysByMonths , ' days ');

    writeln(diffMonths(year1 , year2 , month1 , month2 , day1 , day2 , daysOnly , daysByMonths) , ' months ' , daysByMonths , ' days');

    writeln(diffDays(year1 , year2 , month1 , month2 , day1 , day2 , daysOnly) , ' days');

end.