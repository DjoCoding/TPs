program exo3;

uses sll;

function valAfter(head : pNode ; data : integer) : integer;

    var current : pNode;

    begin
        valAfter := -1;
        current := head;
        
        if (head <> NIL) then 
            while (current^.next <> NIL) do 
                if (current^.data = data) then 
                    begin
                        valAfter := current^.next^.data;
                        break; 
                    end
                else 
                    current := current^.next;

    end;

procedure main();

    var head : pNode;
        x : integer;

    begin
        head := getLinkedList(10);

        print(head);

        write('type a value x : ');readln(x);

        writeln('the first value after x is : ' , valAfter(head , x));
        free(head); 
    end;

begin
    main();
end.