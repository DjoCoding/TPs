program exo;


function find_number(start , endd : integer) : integer;

    begin
        find_number := (start + endd) div 2; 
    end;

procedure display(number : integer);

    var i : integer;

    begin
        for i := 1 to 23 do 
            write('-');
        
        writeln;

        writeln('| the number is : ' , number , ' |');

        for i := 1 to 23 do 
            write('-'); 
        
        writeln;
    end;

procedure main();

    var mid , start , endd: integer;
        compare : string;
        answer: string;


    begin

        start := 0;
        endd := 501;

        repeat 
            mid := find_number(start , endd);

            write('does this number is equal to  ' , mid , ' : ');readln(answer);

            if (answer[1] = 'n') then 
                begin
                    write('does ', mid , ' bigger : ');readln(compare);

                    if compare[1] = 'y' then 
                        endd := mid
                    else 
                        start := mid;
 
                end
            else 
                begin 
                    writeln('the number is found');
                    answer := 'y';
                end;

        until((endd - start = 1) or (answer[1] = 'y'));

        writeln;
        display(find_number(start , endd));

    end;

begin 
    main();
end.