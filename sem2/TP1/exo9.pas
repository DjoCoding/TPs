program exo9;

uses sll;

//this will add the value x after the value y
//make sure x <> y
procedure addAfter(head : pNode ; x , y : integer);

    var current , node : pNode;

    begin
        current := head;
        node := NIL;

        while (current <> NIL) do 
            begin
                if (current^.data = y) then 
                    begin
                        node := makeNode(x);
                        node^.next := current^.next;
                        current^.next := node; 
                        current := node;
                    end;
               current := current^.next;
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

        addAfter(head , x , y);
        print(head);

        free(head); 
    end;

begin
    main();
end.