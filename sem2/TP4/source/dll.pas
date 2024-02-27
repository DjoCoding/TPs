unit dll;

interface 

    type pNode = ^Node;
        Node = record
            value : integer;
            next, prev : pNode;
        end;
    
    procedure add(var head , tail : pNode ; value : integer ; pos: integer);
    procedure getRandomList(var head , tail : pNode ; size : integer);
    procedure print(head : pNode);
    procedure swapNodeValues(var head : pNode ; pos1 , pos2 : integer);
    procedure reverseList(var head , tail : pNode);
    procedure removeAfterValue(var head , tail : pNode ; value : integer);
    procedure addValue(head : pNode ; value : integer);
    procedure twoSum(var head : pNode ; value : integer);
    procedure insertionSort(var head : pNode);
    procedure bubbleSort(var head , tail : pNode);
    function testSorting(head : pNode) : boolean;
    procedure insert(var head , tail : pNode ; value : integer);
    procedure divideList(var head , tail , head1 , tail1 , head2 , tail2 : pNode);
    procedure divideFour(var head , tail , head1 , tail1 , head2 , tail2 ,  head3 , tail3 , head4 , tail4 : pNode);
    procedure free(var head , tail : pNode);

implementation

procedure swapInt(var a , b : integer);
    
    var temp : integer;

    begin
        temp := a;
        a := b;
        b := temp; 
    end;

//this will swap two addresses
procedure swap(var node1 , node2 : pNode);

    var temp : pNode;

    begin 
        temp := node1;
        node1 := node2;
        node2 := temp;
    end;

function make(value : integer) : pNode;

    var node : pNode;

    begin
        new(node);
        node^.next := NIL;
        node^.prev := NIL;
        node^.value := value;
        make := node; 
    end;

procedure add(var head , tail : pNode ; value : integer ; pos: integer);

    var node , current : pNode;

    begin
        node := make(value);

        if (head = NIL) then 
            begin
                head := node;
                tail := node; 
            end
        else 
            if (pos = 1) then 
                begin
                    node^.next := head;
                    head^.prev := node;
                    head := node; 
                end
            else 
                begin
                    current := head;

                    while ((pos <> 1) and (current <> NIL)) do 
                        begin
                            current := current^.next;
                            pos := pos - 1;
                        end;
                    
                    if (current = NIL) then 
                        begin 
                            node^.prev := tail;
                            tail^.next := node;
                            tail := node;
                        end
                    else 
                        begin
                            node^.next := current;
                            node^.prev := current^.prev;

                            current^.prev^.next := node;
                            current^.prev := node;
                        end;
                end;
    end;

procedure addBeg(var head , tail : pNode ; value : integer);

    begin
        add(head , tail , value, 1); 
    end;

procedure getRandomList(var head , tail : pNode ; size : integer);

    var i : integer;

    begin
        for i := 1 to size do 
            addBeg(head , tail , random(100));
    end;

procedure print(head : pNode);

    var current : pNode;

    begin
        current := head;

        if (head = NIL) then writeln('the list is empty!')
        else 
            begin 
                while (current^.next <> NIL) do 
                    begin
                        write(current^.value , ' <-> ');
                        current := current^.next; 
                    end; 
                writeln(current^.value);
            end;
    end;

function length(head : pNode) : integer;

    var current : pNode;

    begin
        current := head;
        length := 0;

        while (current <> NIL) do 
            begin
                current := current^.next;
                length := length + 1; 
            end; 
    end;

function getNode(head : pNode ; pos : integer) : pNode;

    var current : pNode;

    begin
        current := head;

        if (head <> NIL) then 
            while ((pos <> 1) and (current^.next <> NIL)) do 
                begin 
                    current := current^.next;
                    pos := pos - 1;
                end;

        getNode := current;
    end;

procedure swapNodeValues(var head : pNode ; pos1 , pos2 : integer);

    var node1 , node2 : pNode;

    begin
        node1 := getNode(head , pos1);
        node2 := getNode(head , pos2);

        if ((node1 <> NIL) and (node2 <> NIL)) then 
            swapInt(node1^.value , node2^.value);
    end;

procedure reverseList(var head , tail : pNode);

    var prev , current , next : pNode;

    begin
        current := head;
        prev := NIL;


        while (current <> NIL) do 
            begin
                next := current^.next;
                current^.next := prev;
                current^.prev := next;
                prev := current;
                current := next;
            end; 

        swap(head , tail);
    end;



procedure removeAfterValue(var head , tail : pNode ; value : integer);

    var current , temp : pNode;

    begin   
        if (head <> NIL) then 
            begin 
                current := head;
                while (current^.next <> NIL) do 
                    if (current^.value = value) then break
                    else 
                        current := current^.next;
                
                if (current^.next <> NIL) then 
                    begin
                        temp := current^.next;
                        if (temp = tail) then 
                            tail := current;
                        current^.next := temp^.next;
                        dispose(temp);
                        temp := NIL; 
                    end;
            end; 
    end;


//this will add the given value to all the nodes that are odd

procedure addValue(head : pNode ; value : integer);

    var current : pNode;

    begin
        current := head;
        while (current <> NIL) do 
            begin
                if (current^.value mod 2 = 1) then current^.value := current^.value + value;
                current := current^.next; 
            end; 
    end;

//this will insert the value in the list and let the new list sorted!

procedure insert(var head , tail : pNode ; value : integer);

    var current , node : pNode;

    begin 
        node := make(value);

        if (head = NIL) then
            begin
                head := node;
                tail := node; 
            end
        else
            if (value <= head^.value) then addBeg(head , tail , value)
            else 
                begin
                    current := head;

                    while (current <> NIL) do
                        if (current^.value >= value) then break
                        else 
                            current := current^.next;

                    if (current = NIL) then 
                        begin
                            node^.prev := tail;
                            tail^.next := node; 
                            tail := node;
                        end
                    else 
                        begin
                            node^.next := current;
                            node^.prev := current^.prev;
                            current^.prev^.next := node; 
                            current^.prev := node;
                        end;
                end; 
    end;

//this will print all the values of the nodes where value1 + value2  = value

procedure twoSum(var head : pNode ; value : integer);

    var current , next : pNode;

    begin   
        current := head;

        while (current <> NIL) do 
            begin
                next := current^.next;
                while (next <> NIL) do 
                    begin
                        if ((current^.value + next^.value = value)) then 
                            writeln('(' , current^.value , ' , ' , next^.value , ')');
                        next := next^.next; 
                    end; 
                current := current^.next;
            end; 
    end;

// insertionSort for linked list

procedure insertionSort(var head : pNode);

    var current , temp : pNode;
        value : integer;

    begin
        current := head;

        while (current <> NIL) do 
            begin   
                temp := current;

                value := temp^.value;

                while (temp^.prev <> NIL) do 
                    if (value < temp^.prev^.value) then 
                        begin
                            temp^.value := temp^.prev^.value;
                            temp := temp^.prev;
                        end
                    else 
                        break;
                
                temp^.value := value;
                current := current^.next;
            end; 
    end;

// bubbleSort for linked list

procedure bubbleSort(var head , tail : pNode);

    var current , last,  temp : pNode; 
        i , j , value , len : integer;

    begin

        if (head <> NIL) then 
            begin
                current := head;
                last := tail;

                while (current^.next <> NIL) do 
                    begin
                        last := last^.prev;

                        temp := current;


                        while ((temp^.next <> NIL)) do 
                            begin
                                if (temp^.value < temp^.next^.value) then swapInt(temp^.value , temp^.value);
                                temp := temp^.next; 
                            end;
                        
                        current := current^.next;
                        last := last^.prev;
                    end;
            end; 
    end;

function testSorting(head : pNode) : boolean;

    var result : boolean;
        increasing : boolean; //this will let us know if we test the sorting in the increasing order or
                              // in the decreasing order;
        current : pNode;

    begin
        result := TRUE;

        if (head <> NIL) then 
            if (head^.next <> NIL) then 
                begin
                    current := head;

                    while (current^.next <> NIL) do 
                        if (current^.value = current^.next^.value) then current := current^.next
                        else 
                            break;

                    if (current^.next <> NIL) then 
                        increasing := (current^.value <= current^.next^.value);
                    
                    current := current^.next;

                    if (current <> NIL) then 
                        while ((result) and (current^.next <> NIL)) do 
                            begin
                                if (increasing) then result := (current^.value <= current^.next^.value)
                                else 
                                    result := (current^.value >= current^.next^.value);

                                current := current^.next; 
                            end;
                end;

        testSorting := result;
    end;

procedure divideList(var head , tail , head1 , tail1 , head2 , tail2 : pNode);

    var current , last : pNode;

    begin
        current := head;
        last := tail;

        if (head <> NIL) then 
            begin
                while ((current <> last) and (current^.next <> last)) do 
                    begin
                        current := current^.next;
                        last := last^.prev; 
                    end; 
                
                if (current = last) then 
                    begin
                        head2 := current^.next;
                        tail2 := tail;

                        head2^.prev := NIL;
                        current^.next := NIL;

                        head1 := head; 
                        tail1 := current;
                    end
                else 
                    begin 
                        current^.next := NIL;
                        last^.prev := NIL;

                        head1 := head;
                        head2 := last;

                        tail1 := current;
                        tail2 := tail;
                    end;
            end; 
    end;

procedure divideFour(var head , tail , head1 , tail1 , head2 , tail2 ,  head3 , tail3 , head4 , tail4 : pNode);

    begin   
        divideList(head , tail , head1 , tail1 ,  head3 , tail3 );
        divideList(head1 , tail1 , head1 , tail1 , head2 , tail2);
        divideList(head3 , tail3 , head3 , tail3 , head4 , tail4); 
    end;

procedure free(var head , tail : pNode);

    var current , temp : pNode;

    begin
        current := head;

        while (current <> NIL) do 
            begin
                temp := current^.next;
                dispose(current);
                current := temp; 
            end; 
        
        current := NIL;
        temp := NIL;
        head := NIL;
        tail := NIL;
    end;

begin 
end.