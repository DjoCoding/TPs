program makeCalendar;

procedure calendar(nbrOfDays , startDay : integer);

    var ptr , i : integer;

    begin 

        ptr := 0;
        i := 1;

        writeln('D  L  M  M  J  V  S');

        if (startDay = 0) then 

            begin
                write('                  ') ;
                ptr := 6;
            end
        
        else 

            begin   

                while ptr + 1 < startDay do 

                    begin
                        write('   ');
                        ptr := ptr + 1;
                    end;    
            end;

        
        while True do 

            begin 

                if (i = nbrOfDays + 1) then break;

                if (ptr = 7) then 

                    begin   
                        writeln();
                        ptr := 0
                    end; 

                case i of 
                    1..9 : write(i , '  ');
                    else  write(i , ' ')
                end;
                
                i := i + 1;
                
                ptr := ptr + 1;

                   
            end;
        
        writeln();
        
    end;

var startDay , nbrOfDays : integer;

begin 

    writeln('==========Calendar==========');
    writeln();
    write('Insert the start date (0-Sunday ... 6-Saturday) : ');readln(startDay);
    write('Insert the number of days in this month : ');readln(nbrOfDays);

    writeln('Calendar');

    writeln();

    calendar(nbrOfDays , startDay);
    
end.