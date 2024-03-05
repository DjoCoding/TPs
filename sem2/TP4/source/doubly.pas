unit doubly;

interface 

    type 
        pNode = ^Node;
        Node = record 
            value : integer; 
            next , prev : pNode;
        end;

        pList = ^List;
        List = record 
            head , tail : pNode;
        end;

        pLists = ^Lists;
        Lists = record 
            list : pList;
            next : pLists;
        end;
    
    function make(value : integer) : pNode;
    function createList() : pList;
    procedure add(list : pList; value : integer);
    procedure free(var list : pList);
    function getHead(list : pList) : pNode;

    function getList(length : integer) : pList;
    procedure print(list : pList);
    procedure swap(list : pList ; pos1 , pos2 : integer);
    procedure reverseList(list : pList);
    procedure printReverse(list : pList);
    procedure addOne(list : pList);
    procedure removeAfterValueX(list : pList ; value : integer);
    procedure Insertion_Sort(list : pList);
    procedure insert_value(list : pList; value : integer);
    procedure twoSum(list : pList ; value : integer);
    procedure bubble_sort(list : pList);
    function check_sorted_list(list : pList) : boolean;
    procedure divideList(var lists : pLists ; list : pList);
    procedure printLists(lists : pLists);
    procedure freeLists(var lists : pLists);
    procedure divideListIntoFour(var lists : pLists ; list : pList);


implementation

function make(value : integer) : pNode;

    var node : pNode; 

    begin
        new(node);
        node^.value := value;
        node^.next := NIL;
        node^.prev := NIL;

        make := node;
        node := NIL; 
    end;


function createList() : pList;

    var list : pList;

    begin
        new(list);

        list^.head := NIL;
        list^.tail := NIL;

        createList := list;

        list := NIL; 
    end;

function getHead(list : pList) : pNode;

    begin
        getHead := (list^.head); 
    end;

function getTail(list : pList) : pNode;

    begin
        getTail := (list^.tail); 
    end;

procedure add(list : pList; value : integer);

    var node : pNode;

    begin
        node := make(value);

        if (getHead(list) = NIL) then 
            begin
                list^.head := node;
                list^.tail := node;  
            end
        else 
            begin
                getTail(list)^.next := node;
                node^.prev := getTail(list);
                list^.tail := node; 
            end;
        
        node := NIL;
    end;


function getList(length : integer) : pList;
    
    var list : pList;
        i : integer;

    begin
        list := createList();

        for i := 1 to length do 
            add(list , random(10));

        getList := list;

        list := NIL;
    end;


procedure print(list : pList);

    var node : pNode;

    begin
        if (getHead(list) = NIL) then writeln('the linked list is empty!')
        else 
            begin
                node := list^.head;

                while (node^.next <> NIL) do 
                    begin
                        write(node^.value , ' <-> ');
                        node := node^.next; 
                    end; 
                
                writeln(node^.value);
            end;
        
        node := NIL;
    end;    


procedure free(var list : pList);

    var node : pNode;

    begin
        if (list <> NIL) then 
            begin
                while (getHead(list) <> NIL) do 
                    begin
                        node := getHead(list);
                        list^.head := node^.next;
                        dispose(node); 
                    end; 
                list^.tail := NIL;        
                list := NIL;
            end; 
        node := NIL;
    end;

function getNode(list : pList ; pos : integer) : pNode;

    var node : pNode;

    begin 
        node := getHead(list);

        while ((pos <> 1) and (node^.next <> NIL)) do 
            begin
                node := node^.next;
                pos := pos - 1; 
            end; 
        
        getNode := node;
    end;

function min(a , b : integer) : integer;

    begin
        if (a < b) then min := a 
        else 
            min := b; 
    end;

function max(a , b : integer) : integer;

    begin
        max := a + b - min(a , b); 
    end;

procedure swap(list : pList ; pos1 , pos2 : integer);

    var node1 , node2 , before1 , before2 , after1 , after2 : pNode;

    begin
        node1 := getNode(list , min(pos1 , pos2));
        node2 := getNode(list , max(pos2 , pos1));

        if ((node1 <> NIL) and (node2 <> NIL)) then 
            begin
                before1 := node1^.prev;
                after2 := node2^.next;

                if (getHead(list) = node1) then list^.head := node2;
                if (getTail(list) = node2) then list^.tail := node1;

                if (after2 <> NIL) then after2^.prev := node1;

                if (before1 <> NIL) then before1^.next := node2;

                if (node1^.next = node2) then 
                    begin
                        node1^.next := after2;
                        node2^.prev := before1;
                        node2^.next := node1;
                        node1^.prev := node2;
                    end
                else 
                    begin
                        after1 := node1^.next;
                        before2 := node2^.prev;

                        node1^.next := after2;
                        node2^.prev := before1;

                        node1^.prev := before2;
                        before2^.next := node1;

                        node2^.next := after1;
                        after1^.prev := node2;
                    end;
            end;
        
        node1 := NIL;
        node2 := NIL;
        after1 := NIL;
        after2 := NIL;
        before1 := NIL;
        before2 := NIL;
    end;

procedure reverseList(list : pList);

    var prev , current , next : pNode;

    begin
        prev := NIL;
        current := getHead(list);

        list^.head := getTail(list);
        
        while (current <> NIL) do 
            begin
                next := current^.next;

                current^.next := prev;

                current^.prev := next;
                
                prev := current;

                current := next; 
            end;
        
        list^.head := prev;
    end;

procedure removeAfterValueX(list : pList ; value : integer);
    
    var node , temp : pNode;

    begin 
        node := getHead(list);

        if (node <> NIL) then 
            while (node^.next <> NIL) do 
                if (node^.value = value) then 
                    begin
                        temp := node^.next;
                        node^.next := temp^.next;
                        if (temp^.next <> NIL) then 
                            temp^.next^.prev := node;
                        temp^.next := NIL;
                        temp^.prev := NIL;
                        dispose(temp);
                    end
                else 
                    node := node^.next;
    end;

procedure printReverse(list : pList);

    var node : pNode;

    begin
        if (getHead(list) = NIL) then writeln('the linked list is empty!')
        else 
            begin
                node := getTail(list);

                while (node^.prev <> NIL) do 
                    begin
                        write(node^.value , ' <-> ');
                        node := node^.prev; 
                    end; 
                
                writeln(node^.value);
            end;
        
        node := NIL;
    end;

procedure addOne(list : pList);

    var node : pNode;

    begin
        node := getHead(list);

        while (node <> NIL) do 
            begin
                if (node^.value mod 2 = 1) then node^.value := node^.value + 1;
                node := node^.next; 
            end; 
    end;

procedure Insertion_Sort(list : pList);

    var node , temp : pNode;
        value : integer;

    begin
        node := getHead(list); 

        if (node <> NIL) then 
            begin
                node := node^.next;

                while (node <> NIL) do 
                    begin
                        value := node^.value;
                        temp := node^.prev;

                        while ((temp <> NIL) and (value < temp^.value)) do 
                            begin
                                temp^.next^.value := temp^.value;
                                temp := temp^.prev;
                            end; 
                        
                        if (temp = NIL) then list^.head^.value := value
                        else 
                            temp^.next^.value := value;
                        
                        node := node^.next;
                    end;
            end;
        
        node := NIL;
        temp := NIL;
    end;


procedure insert_value(list : pList; value : integer);

    var node , temp : pNode;   

    begin
        node := make(value);

        temp := getHead(list);

        if (temp = NIL) then 
            begin
                add(list , value);
                dispose(node); 
            end
        else 
            begin
                while (temp <> NIL) do 
                    if (temp^.value >= value) then break
                    else 
                        temp := temp^.next;

                if (temp = NIL) then 
                    begin
                        list^.tail^.next := node;
                        node^.prev := list^.tail;
                        list^.tail := node; 
                    end
                else 
                    begin
                        if (temp = getHead(list)) then 
                            list^.head := node;

                        node^.next := temp;
                        node^.prev := temp^.prev;
                        
                        temp^.prev := node;

                        if (node^.prev <> NIL) then
                            node^.prev^.next := node;
                    end;
            end;
        
        temp := NIL;
        node := NIL;
    end;

procedure twoSum(list : pList ; value : integer);

    var left , right : pNode;
        sum : integer;

    begin
        left := getHead(list);
        right := getTail(list);

        Insertion_Sort(list);

        write('{ ');

        while ((left <> right)) do 
            begin
                sum := left^.value + right^.value;
                if (sum = value) then 
                    begin 
                        write('(' , left^.value , ' , ' , right^.value , ') ');
                        right := right^.prev;
                    end
                else 
                    if (sum < value) then left := left^.next
                    else 
                        right := right^.prev;
            end; 
        
        writeln('}');
    end;

procedure swap(var a , b : integer);

    var temp : integer;

    begin
        temp := a;
        a := b;
        b := temp; 
    end;


procedure bubble_sort(list : pList);

    var node , last , temp : pNode;

    begin
        node := getHead(list);

        if (node <> NIL) then 
            begin

                last := getTail(list);

                while (node^.next <> NIL) do 
                    begin
                        temp := getHead(list);

                        while (temp <> last) do 
                            begin
                                if (temp^.value > temp^.next^.value) then   
                                    swap(temp^.value , temp^.next^.value);
                                temp := temp^.next;
                            end; 
                        
                        last := last^.prev;
                        node := node^.next;
                    end;
            end; 
    end;

function check_sorted_list(list : pList) : boolean;

    var node : pNode;
        result : boolean;

    begin
        node := getHead(list);

        while (node <> NIL) do 
            begin
                if (getHead(list)^.value <> node^.value) then break;
                node := node^.next; 
            end; 
        
        if (node = NIL) then result := true 
        else 
            if (node^.value > getHead(list)^.value) then 
                begin
                    result := true;
                    while ((result) and (node^.next <> NIL)) do 
                        begin
                            result := (node^.value <= node^.next^.value);
                            node := node^.next; 
                        end; 
                end
            else 
                begin
                    result := true;
                    while ((result) and (node^.next <> NIL)) do 
                        begin
                            result := (node^.value >= node^.next^.value);
                            node := node^.next; 
                        end; 
                end;
        
        check_sorted_list := result;
    end;

function length(list : pList) : integer;

    var result : integer;
        node : pNode;
    
    begin 
        node := getHead(list);

        result := 0;

        while (node <> NIL) do 
            begin
                result := result + 1;
                node := node^.next; 
            end;
        
        length := result;
    end;

function copyList(list : pList) : pList;

    var node : pNode;
        result : pList;

    begin 
        node := getHead(list);

        result := createList();

        while (node <> NIL) do
            begin 
                add(result , node^.value);
                node := node^.next;
            end;
        
        copyList := result;
    end;

procedure addToLists(var lists : pLists ; list : pList);

    var temp : pLists;

    begin
        new(temp);
        temp^.list := list;
        temp^.next := lists;
        lists := temp;
    end;


procedure divideList(var lists : pLists ; list : pList);

    var 
        tempList : pList;
        mid : pNode;
        len : integer;
        newList : pList;
    
    begin
        newList := copyList(list);

        len := length(newList);

        mid := getNode(newList , len - (len div 2));

        new(tempList);
        tempList^.head := mid^.next;
        tempList^.tail := list^.tail;

        newList^.tail := mid;
        
        if (tempList^.head <> NIL) then 
            tempList^.head^.prev := NIL;

        mid^.next := NIL;

        addToLists(lists , tempList);
        addToLists(lists , newList);
    end;

procedure printLists(lists : pLists);

    var tempList : pList;
        temp : pLists;
        i : integer;
    
    begin
        temp := lists;
        i := 1;

        while (temp <> NIL) do 
            begin
                tempList := temp^.list;
                write(i , ' : ');
                print(tempList);
                writeln;
                temp := temp^.next; 
                i := i + 1;
            end; 
    end;

procedure freeLists(var lists : pLists);

    var temp : pLists;

    begin 
        while (lists <> NIL) do 
            begin
                temp := lists^.next;
                free(lists^.list);
                dispose(lists);
                lists := temp; 
            end;
    end;

procedure divideListIntoFour(var lists : pLists ; list : pList);

    var 
        tempList , newList : pList;  
        node : pNode;
        len : integer;

    begin
        newList := copyList(list);

        len := length(newList);
        node := getNode(newList , len - len div 2);


        new(tempList);
        tempList^.head := node^.next;
        tempList^.tail := list^.tail;

        newList^.tail := node;
        
        if (node^.next <> NIL) then
            node^.next^.prev := NIL;

        node^.next := NIL;

        divideList(lists , tempList);
        divideList(lists , newList);
    end;


begin 
end.




    
