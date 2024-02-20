unit lib;

interface 

    type pNode = ^Node;

        Node = record 
            name : string;
            next , sub : pNode;
        end;

        infoArr = array[1..5] of string;
        
    procedure addUniv(var head: pNode ; info : infoArr);
    procedure addFac(var head : pNode; info : infoArr);
    procedure addDep(var head : pNode ; info : infoArr);
    procedure addSpec(var head : pNode ; info : infoArr);
    procedure addStudent(var head : pNode ; info : infoArr);

    function getUniv(head : pNode ; info : infoArr) : pNode;
    function getFac(head : pNode; info : infoArr) : pNode;
    function getDep(head : pNode ; info : infoArr) : pNode;
    function getSpec(head : pNode ; info : infoArr) : pNode;
    function getStudent(head : pNode ; info : infoArr) : pNode;

    function findUniv(head : pNode ; info : infoArr) : boolean;
    function findFac(head : pNode; info : infoArr) : boolean;
    function findDep(head : pNode ; info : infoArr) : boolean;
    function findSpec(head : pNode ; info : infoArr) : boolean;
    function findStudent(head : pNode ; info : infoArr) : boolean;

    procedure removeUniv(var head : pNode ; info : infoArr);
    procedure removeFac(var head : pNode ; info : infoArr);
    procedure removeDep(var head : pNode ; info : infoArr);
    procedure removeSpec(var head : pNode ; info : infoArr);
    procedure removeStudent(var head : pNode ; info : infoArr);

    procedure sortUniv(var head : pNode);
    procedure sortFac(var head : pNode);
    procedure sortDep(var head : pNode);
    procedure sortSpec(var head : pNode);
    procedure sortStudent(var head : pNode);


    procedure print(head : pNode ; level : integer);
    procedure free(var head : pNode);

    procedure executeFunc(funcNumber : integer);
    procedure printMenu();

implementation


 
function make(value : string) : pNode;

    var node : pNode;

    begin 
        new(node);

        node^.name := value;
        node^.next := NIL;
        node^.sub := NIL;

        make := node;
    end;


procedure swap(var a , b : string);

    var temp : string;

    begin
        temp := a;
        a := b;
        b := temp; 
    end;


//sorting a list
procedure sortList(var head : pNode);

    var current , temp , min : pNode;

    begin 
        if (head <> NIL) then 
            begin
                current := head;
                while (current^.next <> NIL) do 
                    begin
                        min := current;
                        temp := current^.next;
                        while (temp <> NIL) do 
                            begin
                                if (temp^.name < min^.name) then min := temp;
                                temp := temp^.next; 
                            end; 
                        
                        if (min <> current) then swap(min^.name , current^.name);
                        current := current^.next;
                    end; 
            end;
    end;

function getRandomInfo() : infoArr;

    var result : infoArr;
        i : integer;
    
    function getRandomString() : string;
        
        var result : string;
            i , length : integer;

        begin
            result := '';
            length := random(5) + 5;

            for i := 1 to length do 
                result := result + chr(random(26) + ord('A'));

            getRandomString := result;    
        end;
    
    begin
        randomdize;
        for i := 1 to 5 do 
            result[i] := getRandomString();
        getRandomInfo := result;
    end;

//this will remove anything below the given node (subLists)
procedure removeSubList(var head : pNode);

    var current , temp : pNode;

    begin 
        current := head^.sub;  
        while (current <> NIL) do 
            begin
                temp := current^.next;
                removeSubList(current);
                dispose(current);
                current := temp;
            end;
    end;

procedure addToList(var head : pNode ; value : string);

    var node , current : pNode;

    begin
        node := make(value);

        if (head = NIL) then head := node
        else 
            begin
                current := head;
                while (current^.next <> NIL) do current := current^.next;
                current^.next := node; 
            end; 
    end;

function getFromList(head : pNode ; value : string) : pNode;

    var result : pNode;

    begin
        result := head;
        while (result <> NIL) do 
            if (result^.name = value) then break 
            else 
                result := result^.next;
            
        getFromList := result;
    end;

procedure addUniv(var head: pNode ; value : string);

    begin
        addToList(head , value);
    end;

procedure addFac(var head : pNode ; info : infoArr);

    var univ : pNode;
    
    begin
        univ := getUniv(head , info);


        //(univ = NIL) <=> univ doesn't exist
        
        if (univ  = NIL) then 
            begin
                addUniv(head , info);
                univ := getUniv(head, info); 
            end;
        
        addToList(univ^.sub , info[2]); //univ^.sub is the head of the list now;
    end;

procedure addDep(var head : pNode ; info : infoArr);

    var fac : pNode;

    begin
        fac := getFac(head , info);

        if (fac = NIL) then 
            begin 
                addFac(head , info);
                fac := getFac(head , info);
            end;
        
        addToList(fac^.sub , info[3]);
    end;

procedure addSpec(var head : pNode ; info : infoArr);

    var dep  : pNode;

    begin
        dep := getDep(head , info);

        if (dep = NIL) then 
            begin
                addDep(head , info);
                dep := getDep(head , info); 
            end; 
        
        addToList(dep^.sub , info[4]);
    end;

procedure addStudent(var head : pNode ; info : infoArr);

    var spec : pNode;

    begin
        spec := getSpec(head , info);

        if (spec = NIL) then 
            begin
                addSpec(head , info); 
                spec := getSpec(head , info);
            end; 

        addToList(spec^.sub , info[5]);
    end;

function getUniv(head : pNode ; info : infoArr) : pNode;

    begin
        getUniv := getFromList(head, info[1]);
    end;

function getFac(head : pNode ; info : infoArr) : pNode;

    var result : pNode;

    begin   
        result := getUniv(head , info);
        
        if (result <> NIL) then 
            result := getFromList(result^.sub , info[2]);
        
        getFac := result;
    end;

function getDep(head : pNode ; info : infoArr) : pNode;

    var result : pNode;

    begin
        result := getFac(head , info);

        if (result <> NIL) then 
            result := getFromList(result^.sub , info[3]);
        
        getDep := result;
    end;

function getSpec(head : pNode ; info : infoArr) : pNode;

    var result : pNode;

    begin
        result := getDep(head , info);

        if (result <> NIL) then 
            result := getFromList(result^.sub , info[4]);
        
        getSpec := result;
    end;

function getStudent(head : pNode ; info : infoArr) : pNode;

    var result : pNode;

    begin 
        result := getSpec(head , info);

        if (result <> NIL) then 
            result := getFromList(result^.sub , info[5]);
        
        getStudent := result;
    end;

procedure print(head : pNode ; level : integer);

    var current : pNode;
        i : integer;

    begin 
        if (head <> NIL) then 
            begin
                current := head;
                while (current <> NIL) do 
                    begin
                        for i := 1 to level do
                            write('     ');
                        writeln('- ' , current^.name);
                        print(current^.sub , level + 1);
                        current := current^.next;
                    end;
            end;
    end;

procedure free(var head : pNode);

    var current , next : pNode;

    begin
        current := head;

        while (current <> NIL) do 
            begin
                next := current^.next;
                free(current^.sub);
                dispose(current);
                current := next; 
            end; 
        
        head := NIL;
    end;

function findUniv(head : pNode ; info : infoArr) : boolean;

    begin
        findUniv := getUniv(head , info) <> NIL;
    end;

function findFac(head : pNode ; info : infoArr) : boolean;

    begin
        findFac := getFac(head , info) <> NIL;
    end;

function findDep(head : pNode ; info : infoArr) : boolean;

    begin
        findDep := getDep(head , info) <> NIL;
    end;

function findSpec(head : pNode ; info : infoArr) : boolean;

    begin
        findSpec := getSpec(head , info) <> NIL;
    end;

function findStudent(head : pNode ; info : infoArr) : boolean;

    begin
        findStudent := getStudent(head , info) <> NIL;
    end;

procedure removeNode(var head : pNode ; value : string);

    var current , node  : pNode;

    begin
        if (head <> NIL) then 
            if (head^.name = value) then 
                begin
                    current := head;
                    head := head^.next;
                    removeSubList(current);
                    dispose(current); 
                    current := NIL;
                end
            else 
                begin
                    current := head;
                    while (current^.next <> NIL) do 
                        begin
                            if (current^.next^.name = value) then break;
                            current := current^.next;
                        end; 
                    
                    if (current^.next <> NIL) then 
                        begin 
                            node := current^.next;
                            current^.next := node^.next;
                            removeSubList(node);
                            dispose(node);
                            node := NIL;
                        end;
                end;
    end;

procedure removeUniv(var head : pNode ; info : infoArr);

    begin
        removeNode(head , info[1]); 
    end;

procedure removeFac(var head : pNode ; info : infoArr);

    var univ : pNode;

    begin
        univ := getUniv(head , info);
        removeNode(univ^.sub , info[2]); 
    end;

procedure removeDep(var head : pNode ; info : infoArr);

    var fac : pNode;

    begin
        fac := getFac(head , info);
        removeNode(fac^.sub , info[3]); 
    end;

procedure removeSpec(var head : pNode ; info : infoArr);

    var dep : pNode;

    begin
        dep := getDep(head , info);
        removeNode(dep^.sub , info[4]); 
    end;

procedure removeStudent(var head : pNode ; info : infoArr);

    var spec:  pNode;

    begin
        spec := getSpec(head , info);
        removeNode(spec^.sub , info[5]); 
    end;


procedure sortUniv(var head : pNode);

    begin
        sortList(head); 
    end;

procedure sortFac(var head : pNode);

    var univ : pNode;

    begin
        univ := head;
        while (univ <> NIL) do 
            begin
                sortList(univ^.sub);
                univ := univ^.next; 
            end;
    end;

procedure sortDep(var head : pNode);

    var univ , fac : pNode;

    begin
        univ := head;
        while (univ <> NIL) do 
            begin
                fac := univ^.sub;
                while (fac <> NIL) do 
                    begin
                        sortList(fac^.sub);
                        fac := fac^.next; 
                    end; 
                univ := univ^.next; 
            end;
    end;

procedure sortSpec(var head : pNode);

    var univ , fac , dep : pNode;

    begin
        univ := head;
        while (univ <> NIL) do 
            begin
                fac := univ^.sub;
                while (fac <> NIL) do 
                    begin
                        dep := fac^.sub;
                        while (dep <> NIL) do 
                            begin
                                sortList(dep^.sub);
                                dep := dep^.next; 
                            end; 
                        fac := fac^.next;
                    end; 
                univ := univ^.next;
            end;
    end;


procedure sortStudent(var head : pNode);

    var univ , fac , dep , spec: pNode;

    begin
        univ := head;
        while (univ <> NIL) do 
            begin
                fac := univ^.sub;
                while (fac <> NIL) do 
                    begin
                        dep := fac^.sub;
                        while (dep <> NIL) do 
                            begin
                                spec := dep^.sub;
                                while (spec <> NIL) do 
                                    begin
                                        sortList(spec^.sub);
                                        spec := spec^.next;
                                    end;
                                dep := dep^.next;
                            end; 
                        fac := fac^.next;
                    end; 
                univ := univ^.next;
            end;
    end;

procedure printMenu();

    var myFile : text;
        s : string;

    begin
        assign(myFile , 'menu.txt');

        reset(myFile);

        while (not eof(myFile)) do 
            begin
                readln(myFile , s);
                writeln(s);
            end; 
        
        close(myFile)
    end;

procedure executeFunc(funcNumber : integer ; head : pNode);

    var answer : integer;
        info : infoArr;

    begin
        if ((func > 20) or (func < 0)) then writeln('function number not in range!')
        else 
            begin
                case func of 
                    1 : 
                        begin 
                            info := getInput(func);
                            addUniv(head , info);
                        end
                    2 : begin
                            info := getInput(func);
                            addFac(head , info); 
                        end;
                    3 : begin
                            info := getInput(func);
                            addDep(head , info); 
                        end;
                    4 : begin
                            info := getInput(func);
                            addSpec(head , info); 
                        end;
                    5 : begin
                            info := getInput(func);
                            addStudent(head , info); 
                        end;

                    6 : findUniv(head : pNode ; info : infoArr) : boolean;
                    7 : findFac(head : pNode; info : infoArr) : boolean;
                    8 : findDep(head : pNode ; info : infoArr) : boolean;
                    9 : findSpec(head : pNode ; info : infoArr) : boolean;
                    10 : findStudent(head : pNode ; info : infoArr) : boolean;
                    11 : removeUniv(head : pNode ; info : infoArr);
                    12 : removeFac(head : pNode ; info : infoArr);
                    13 : removeDep(head : pNode ; info : infoArr);
                    14 : removeSpec(head : pNode ; info : infoArr);
                    15 : removeStudent(head : pNode ; info : infoArr);
                    16 : sortUniv(head : pNode);
                    17 : sortFac(head : pNode);
                    18 : sortDep(head : pNode);
                    19 : sortSpec(head : pNode);
                    20 : sortStudent(head : pNode);
                end;
            end;
    end;

begin 
end.