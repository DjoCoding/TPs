program exo1;

uses sll;

function valPremier(head : pNode) : integer;

    begin
        if (head = NIL) then valPremier := -1
        else 
            valPremier := head^.data; 
    end;

procedure main();

    var head : pNode;

    begin
        head := getLinkedList(10);

        print(head);
        writeln('the value of the first element is : ' , valPremier(head));
        
        free(head); 
    end;

begin
    main();
end.

