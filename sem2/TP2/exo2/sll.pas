unit sll;

interface 

    type pNode = ^Node;
        Node = record
            value : string;
            next : pNode;
        end;
    
    function make(value : string) : pNode;
    procedure add(var head : pNode ; value : string);
    procedure print(head : pNode);
    procedure free(var head : pNode);
    function length(head : pNode) : integer;


implementation

function make(value : string) : pNode;

    var node : pNode;

    begin
        new(node);

        node^.value := value;
        node^.next := NIL;

        make := node; 
    end;

procedure add(var head : pNode ; value : string);

    var node , current : pNode;

    begin
        node := make(value);

        if (head = NIL) then head := node
        else 
            begin
                current := head;
                while  (current^.next <> NIL) do current := current^.next;
                current^.next := node; 
            end; 
    end;

procedure print(head : pNode);

    var current : pNode;
    
    begin
        current := head;

        if (head = NIL) then writeln('<empty>')
        else 
            begin
                while (current^.next <> NIL) do 
                begin 
                    write(current^.value , ' -> '); 
                    current := current^.next;
                end;
                writeln(current^.value); 
            end;
            
    end;

procedure free(var head: pNode);

    var temp , current : pNode;

    begin   
        current := head;

        while (current <> NIL) do 
            begin
                temp := current;
                current := current^.next;
                dispose(temp); 
            end; 
        
        head := NIL;
    end;

function length(head : pNode) : integer;

    var current : pNode;

    begin
        current := head;
        length := 0;

        while (current <> NIL) do 
            begin
                length := length + 1;
                current := current^.next; 
            end; 
    end;

begin 

end.