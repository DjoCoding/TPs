uses lib , func;

procedure main();

    var head : pNode;
        funcNumber : integer;

    begin   
        randomize;

        printMenu();
    
        repeat
            funcNumber := readInteger('type the number of the function : ');
            executeFunction(funcNumber , head);
        until (funcNumber = 0);

        free(head);
    end;

begin
    main();
end.