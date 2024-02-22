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
    function getList(length : integer) : pNode; 
    function getNode(head : pNode ; index : integer) : pNode;



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
            while (current <> NIL) do 
                begin 
                    writeln(current^.value); 
                    current := current^.next;
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

function getString(length : integer) : string;

    var result : string;

    begin
        result := '';
        while (length <> 0) do 
            begin   
                result := result + chr(random(26) + ord('A'));
                length := length - 1; 
            end; 
        
        getString := result;
    end;

function getList(length : integer) : pNode;

    var head : pNode;
        current : pNode;

    begin
        head := make(getString(3));
        current := head;

        while (length <> 1) do 
            begin
                current^.next := make(getString(3));
                current := current^.next;
                length := length - 1; 
            end;
        
        getList := head;
    end;

function getNode(head : pNode ; index : integer) : pNode;

    var current : pNode;

    begin
        getNode := NIL;
        current := head;

        while ((index <> 1) and (current^.next <> NIL)) do 
            begin
                index := index - 1;
                current := current^.next; 
            end; 
        
        if (index = 1) then getNode := current;
    end;

begin 

end.