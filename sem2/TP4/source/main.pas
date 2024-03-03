uses doubly , func;


procedure main();

    var number : integer;
        list : pList;
        lists : pLists;

    begin
        list := NIL;
        lists := NIL;

        printMenu();

        repeat
            number := readInteger('type the number of the function you want to execute : ');
            execFunction(list , lists , number);
        until (number = 0); 

        freeLists(lists);
        free(list);
    end;

begin
    main();
end.