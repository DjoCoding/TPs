unit sll;

interface 

    type pNode = ^Node;

        Node = record 
            data : integer;
            next : pNode;
        end;
    
    function makeNode(data : integer) : pNode;
    procedure addNode(var head: pNode ; data : integer ; pos : integer);
    procedure print(head :  pNode);
    function getLinkedList(length : integer) : pNode;
    procedure free(var head : pNode);
 
implementation

function makeNode(data : integer) : pNode;

    var node : pNode;

    begin
        new(node);
        node^.data := data;
        node^.next := NIL;
        makeNode := node; 
    end;

procedure addNode(var head : pNode ; data : integer ; pos : integer);

    var current , node : pNode;
        i : integer;

    begin
        node := makeNode(data);

        if (head = NIL) then head := node
        else 
            if (pos <= 1) then 
                begin
                    node^.next := head;
                    head := node; 
                end
            else 
                begin
                    i := 1;
                    current := head;
                    while ((i < pos - 1) and (current^.next <> NIL)) do 
                        begin
                            current := current^.next;
                            i := i + 1; 
                        end;

                    node^.next := current^.next;
                    current^.next := node;
                end;
    end;

procedure print(head : pNode);

    var current : pNode;

    begin
        current := head;
        if (head = NIL) then writeln('the linked list is empty!')
        else 
            begin
                while (current^.next <> NIL) do  
                    begin 
                        write(current^.data , ' -> ');
                        current := current^.next;
                    end;
                writeln(current^.data);
            end; 
    end;

procedure free(var head : pNode);

    var current , temp : pNode;

    begin
        current := head;
        while (current <> NIL) do 
            begin
                temp := current^.next;
                dispose(current);
                current := temp; 
            end; 
        head := NIL;
    end;

function getLinkedList(length : integer) : pNode;

    var head , node : pNode;

    begin
        randomize;
        
        head := NIL;
        if (length <> 0) then 
            begin
                new(head);
                head^.data := random(10);
                head^.next := NIL;

                node := head;
                while (length <> 1) do 
                    begin
                        new(node^.next);
                        node^.next^.data := random(10);
                        node^.next^.next := NIL;
                        node := node^.next;
                        length := length - 1;
                    end; 
            end; 
        getLinkedList := head;
    end;

begin 
end.
