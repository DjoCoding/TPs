program exo5;

uses sll;

const size = 10;

function length(head : pNode) : integer;

    var current : pNode;
        result : integer;
    
    begin
        result := 0;
        current := head;

        while (current <> NIL) do 
            begin
                current := current^.next;
                result := result + 1;
            end; 
        
        length := result;
    end;

procedure main();

    var head : pNode;

    begin
        head := getLinkedList(size);

        print(head);

        writeln('the length of the linked list is : ' , length(head));
        
        free(head); 
    end;

begin
    main();
end.