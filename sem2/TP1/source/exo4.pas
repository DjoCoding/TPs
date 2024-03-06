program exo4;

uses sll;

function content(head : pNode ; index : integer) : integer;

    var current : pNode;

    begin
        if (head = NIL) then content := -1
        else    
            begin
                current := head;
                index := index - 1;
                while ((index <> 0) and (current^.next <> NIL)) do 
                    begin
                        current := current^.next;
                        index := index - 1; 
                    end; 
                if (index = 0) then content := current^.data
                else 
                    content := -1;
            end; 
    end;

procedure main();

    var head : pNode;
        index : integer;

    begin
        head := getLinkedList(10);

        print(head);

        write('type an index : ');readln(index);
        writeln('the value is : ' , content(head , index));
        free(head); 
    end;

begin
    main();
end.