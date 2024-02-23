program test;

uses lib , data , crt;

function getString(length : integer) : string;

    var result : string;
        i : integer;

    begin
        result := '';

        for i := 1 to length do 
            result := result + chr(random(26) + ord('A')); 
        
        getString := result;
    end;




procedure main();

    var  head : pNode;
        number : integer;
    
    begin       
        printMenu();
        head := NIL;
        
        repeat
            write('type 0 to end the program , a number of some function otherwise : ');
            readln(number);
            if (number <> 0) then
                begin 
                    clrscr;
                    executeFunc(number , head);
                end;
        until (number = 0);

        writeln;

        writeln('thank you!');

        free(head);
    end;

begin
    main();
end.