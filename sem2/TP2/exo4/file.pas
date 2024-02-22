program exo4;

uses sll;

function checkPower2(number : integer) : boolean;

    var i : integer;

    begin   
        if (number = 0) then checkPower2 := true
        else 
            begin
                i := 1;
                checkPower2 := false;

                while ((i * i <= number) and (not checkPower2)) do 
                    begin
                        checkPower2  := (i * i = number);
                        i := i + 1;
                    end;
            end;
    end;

procedure main();

    var head : pNode;

    begin
        randomize;

        head := getList(16);
        writeln(length(head));
        writeln(checkPower2(length(head)));
        free(head);
    end;

begin 
    main();
end.
