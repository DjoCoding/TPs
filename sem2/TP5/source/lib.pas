unit lib;

interface

    const MAX_VALUE = 32767;
    
    type pNode = ^Node;
        Node = record 
            value : integer;
            next : pNode;
        end;
    
        list = record 
            odd , even : pNode;
        end;
    
    function getList(size , maxValue : integer) : pNode;
    procedure print(head : pNode);
    procedure printRecursive(head : pNode);
    function min(head : pNode) : integer;
    function reverseList(head : pNode) : pNode;
    function convertDecimal(head : pNode) : longint;
    function divideList(head : pNode) : list;
    function checkSortedList(head : pNode) : boolean;
    function getListWithoutLastElements(head : pNode ; number : integer) : pNode;
    function length(head : pNode) : integer;
    procedure free(var head : pNode);

implementation

function make(value: integer) : pNode;

    var node : pNode;

    begin
        new(node);
        node^.next := NIL;
        node^.value := value;
        make := node;
        node := NIL; 
    end;

procedure add(var head : pNode ; value , pos : integer);

    var node , temp : pNode;

    begin
        node := make(value);

        if ((pos = 1) or (head = NIL)) then
            begin
                node^.next := head;
                head := node;
                node := NIL;  
            end 
        else 
            begin
                pos := pos - 2; 
                temp := head;
                while ((temp^.next <> NIL) and (pos <> 0)) do 
                    begin
                        temp := temp^.next;
                        pos := pos - 1; 
                    end;
                node^.next := temp^.next;
                temp^.next := node;
            end;
        
        node := NIL;
        temp := NIl;
    end;

procedure addBeg(var head : pNode ; value : integer);

    begin 
        add(head , value , 1);
    end;

procedure addEnd(var head : pNode ; value : integer);

    begin
        add(head , value , length(head) + 1);
    end;

function getList(size , maxValue : integer) : pNode;

    var head : pNode;
        i : integer;

    begin
        head := NIL;
        for i := 1 to size do addBeg(head , random(maxValue + 1));
        getList := head;
        head := NIL; 
    end;


procedure printRecursive(head : pNode);

    begin
        if (head <> NIL) then 
            if (head^.next = NIL) then write(head^.value)
            else
                begin
                    write(head^.value , ' -> ');
                    printRecursive(head^.next);
                end;
    end;

procedure print(head : pNode);

    begin
        if (head = NIL) then writeln('the linked list is empty!')
        else
            begin 
                printRecursive(head);
                writeln; 
            end;
    end;    

procedure free(var head : pNode);

    var temp : pNode;

    begin 
        while (head <> NIL) do 
            begin
                temp := head^.next;
                dispose(head);
                head := temp; 
            end;
        
        temp := NIL;
    end;

function min(a , b : integer) : integer;

    begin 
        if (a > b) then min := b 
        else 
            min := a;
    end;

function min(head : pNode) : integer;

    begin
        if (head = NIL) then min := MAX_VALUE
        else
            min := min(head^.value , min(head^.next));
    end;

procedure reverseList(var head, prev : pNode);

    var temp : pNode;

    begin 
        if (head <> NIL) then 
            begin
                temp := head^.next;
                head^.next := prev; 
                prev := head;
                head := temp;
                reverseList(head , prev);
            end;
    end;

function reverseList(head : pNode) : pNode;

    var prev : pNode;

    begin
        prev := NIL;
        reverseList(head , prev);
        reverseList := prev; 
    end;

function length(head : pNode) : integer;

    begin
        if (head = NIL) then length := 0
        else 
            length := 1 + length(head^.next); 
    end;

function power(base , expo : integer) : longint;

    var i : integer;

    begin 
        power := 1;
        for i := 1 to expo do 
            power := power * base;
    end;

function convert(head : pNode ; i : integer) : longint;

    begin
        if (head = NIL) then convert := 0
        else
            if (head^.value = 1) then  
                convert := convert + power(2 , i) + convert(head^.next , i - 1)
            else 
                convert := convert + convert(head^.next , i - 1);
    
        //if the pascal language has some compiling optimization we can do the following
        {
            if (head <> NIL) then 
                convert := convert + (head^.value) * power(2 , i) + conver(head^.next , i - 1);
            
            (if (head^.value = 0) then we don't make any calcualation)
        }
    end;


function convertDecimal(head : pNode) : longint;

    var len : integer;

    begin
        len := length(head);
        // head := reverseList(head);
        convertDecimal := convert(head , len - 2);
    end;

procedure divideList(head : pNode ; var lists : list ; index : integer);

    begin
        if (head <> NIL) then 
            begin
                if (index mod 2 = 0) then 
                    addEnd(lists.even , head^.value)
                else 
                    addEnd(lists.odd  , head^.value);

                divideList(head^.next , lists , index + 1);
            end;
    end;

function divideList(head : pNode) : list;

    var result : list;

    begin
        result.even := NIL;
        result.odd := NIL;

        divideList(head , result , 1);

        divideList := result; 
    end;

function checkSortedList(head : pNode) : boolean;

    // we suppose that the list is sorted in the non-decreasing order!

    begin 
        if (head = NIL) then checkSortedList := TRUE
        else
            if (head^.next = NIL) then checkSortedList := TRUE
            else 
                if (head^.value > head^.next^.value) then 
                    checkSortedList := FALSE
                else 
                    checkSortedList := checkSortedList(head^.next);
    end;

procedure getListWithoutLastElements(head : pNode ;var newList : pNode ; index, maxIndex : integer);

    begin
        if (head <> NIL) then 
            if (index <= maxIndex) then 
                begin
                    addEnd(newList , head^.value);
                    getListWithoutLastElements(head^.next, newList , index + 1 , maxIndex);
                end;
    end;

function getListWithoutLastElements(head : pNode ; number : integer) : pNode;

    var result : pNode;
        maxIndex : integer;

    begin
        result := NIL;
        maxIndex := length(head) - number;
        getListWithoutLastElements(head , result , 1 , maxIndex); 
        getListWithoutLastElements := result;
    end;


begin 
end.
