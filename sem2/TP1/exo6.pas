program exo6;

uses sll;

procedure removeFirst(var head : pNode);

    var temp : pNode;

    begin
        if (head <> NIL) then 
            begin
                temp := head^.next;
                dispose(head);
                head := temp; 
            end; 
    end;

procedure main();

    var head : pNode;

    begin
        head := getLinkedList(10);

        print(head);

        removeFirst(head);

        print(head);
        
        free(head); 
    end;

begin
    main();
end.
