program exo10;

uses sll;


//this will add the value x before the value y
procedure addBefore(var head : pNode; x , y : integer);

    var current , prev , node : pNode;

    begin
        if (head <> NIL) then 
            begin
                current := head^.next;
                prev := head;

                if (head^.data = y) then 
                    begin
                        node := makeNode(x);
                        node^.next := head;
                        head := node;
                        prev := head^.next;
                        current := prev^.next;
                    end;

                while (current <> NIL) do 
                    begin
                        if (current^.data = y) then 
                            begin
                                node := makeNode(x);
                                node^.next := current;
                                prev^.next := node; 
                            end;
                        prev := current;
                        current := current^.next;
                    end; 
            end;
    end;

procedure main();

    var head : pNode;
        x , y : integer;

    begin
        head := getLinkedList(10);
        print(head);

        write('type x : ');readln(x);
        write('type y : ');readln(y);

        addBefore(head , x , y);
        print(head);

        free(head); 
    end;

begin
    main();
end.