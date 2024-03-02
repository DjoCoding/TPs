// uses dll , func;

uses doubly;

// procedure main();

//     var head , tail : pNode;
//         funcNumber : integer;
    
//     begin
//         head := NIL;
//         tail := NIL;

//         printMenu();

//         repeat
//             funcNumber := readInteger('type the function number: ');
//             execFunction(funcNumber , head , tail);
//         until (funcNumber = 0); 

//         free(head , tail);
//     end;

procedure main();

    var lists : pLists;
        list : pList;
        value : integer;

    begin
        randomize;

        list := getList(10);
        
        print(list);

        lists := divideList(list);

        writeln('djaoued 1');
        printLists(lists);
        writeln('djaoued2');
        
        freeLists(lists);

        free(list);
    end;

begin
    main();
end.