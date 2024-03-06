program exo1;

uses sll;

function valDernier(head : pNode) : integer;

    var current : pNode;

    begin
        if (head = NIL) then valDernier := -1 
        else 
            begin
                current := head;
                while (current^.next <> NIL) do current := current^.next;
                valDernier := current^.data; 
            end; 
    end;

procedure main();

    var head : pNode;

    begin
        head := getLinkedList(10);
        print(head);

        writeln('the value of the last element is : ' , valDernier(head));
        free(head); 
    end;

begin
    main();
end.