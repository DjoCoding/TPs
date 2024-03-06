program exo8;

uses sll;

procedure removeAfter(head : pNode ; x : integer);

    var current , temp : pNode;

    begin
        if (head <> NIL) then 
            if (head^.next <> NIL) then 
                begin
                    current := head;
                    while (current^.next <> NIL) do 
                        begin
                            if (current^.data = x) then 
                                begin
                                    temp := current^.next;
                                    current^.next := temp^.next;
                                    dispose(temp);
                                    temp := NIL;
                                end;
                            current := current^.next; 
                        end; 
                end; 
    end;

procedure main();

    var head : pNode;
        x : integer;

    begin
        head := getLinkedList(10);

        print(head);

        write('type x : ');readln(x);

        removeAfter(head , x);

        print(head);

        
        free(head); 
    end;

begin
    main();
end.