program exo7;

uses sll;

procedure removeLast(var head : pNode);

    var current : pNode;

    begin
        if (head <> NIL) then 
            if (head^.next = NIL) then 
                begin
                    dispose(head);
                    head := NIL; 
                end
            else 
                begin
                    current := head;
                    while (current^.next^.next <> NIL) do current := current^.next;
                    dispose(current^.next);
                    current^.next := NIL; 
                end;
    end;

procedure main();

    var head : pNode;

    begin
        head := getLinkedList(10);

        print(head);

        removeLast(head);

        print(head);
        
        free(head); 
    end;

begin
    main();
end.