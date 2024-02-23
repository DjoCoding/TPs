program test;

uses data , lib;

procedure main();

    var  head : pNode;
        number : integer;
    
    begin       
        // printMenu();
        // head := NIL;
        
        // repeat
        //     write('type 0 to end the program , a number of some function otherwise : ');
        //     readln(number);
        //     if (number <> 0) then
        //         begin 
        //             clrscr;
        //             executeFunc(number , head);
        //         end;
        // until (number = 0);

        // writeln;

        // writeln('thank you!');

        // free(head);
        
        head := NIL;

        executeFunc(24 , head);

        repeat
            number := readInteger('type the number of the function : ');
            writeln;
            if (number <> 0) then executeFunc(number , head);
        until(number = 0);

        free(head);
    end;

begin
    main();
end.