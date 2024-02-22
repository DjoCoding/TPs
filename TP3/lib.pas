unit lib;

interface 

    const size = 13;

    type pNode = ^Node;

        Node = record 
            name : string;
            next , sub : pNode;
        end;

        infoArr = array[1..5] of string;


        dataSet = array[1..size] of infoArr;
        
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


    procedure setValues(var head : pNode);
    procedure print(head : pNode ; level : integer);
    procedure free(var head : pNode);

    procedure executeFunc(funcNumber : integer ;var head : pNode);
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
        randomize;
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

procedure addUniv(var head: pNode ; info : infoArr);

    begin
        addToList(head , info[1]);
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

function getInput(number : integer) : infoArr;

    var result : infoArr;
        i : integer;

    begin
        for i := 1 to 5 do 
            result[i] := '';
        
        if (number >= 1) then 
            begin
                write('type the University Name : ');readln(result[1]); 
            end;
        
        if (number >= 2) then 
            begin
                write('type the Faculty Name : ');readln(result[2]); 
            end;
        
        if (number >= 3) then 
            begin
                write('type the Departement Name : ');readln(result[3]); 
            end;
        
        if (number >= 4) then 
            begin
                write('type the Speciality Name : ');readln(result[4]); 
            end;
        
        if (number >= 5) then 
            begin
                write('type the Student Name : ');readln(result[5]); 
            end;
        
        getInput :=  result;

    end;


function getData() : dataSet;

    var result : dataSet;
        i , j : integer;
        myFile : text;
        s : string;

    begin
        i := 1;
        j := 1;

        assign(myFile , 'data.txt');

        reset(myFile);

        while (not eof(myFile)) do 
            begin
                if (j = 6) then 
                    begin 
                        j := 1;
                        i := i + 1;
                    end;
                readln(myFile , s);
                result[i][j] := s;
                j := j + 1;
            end;
        
        close(myFile);
        getData := result;
    end;

procedure setValues(var head : pNode);

    var data : dataSet;
        i : integer;

    begin
        free(head);

        data := getData();

        for i := 1 to size do 
            addStudent(head , data[i]);
    end;

procedure writeLine();

    var i : integer;

    begin
        for i := 1 to 3 do writeln;
        for i := 1 to 50 do 
            write('='); 
        writeln;
        for i := 1 to 3 do writeln;
    end;


//this will answer the question of wether a univ (for exemple) exists or no! 
procedure getAnswer(bool : boolean);

    begin
        if (bool) then writeln('well found! :) ')
        else 
            writeln('not found! :( ') 
    end;

procedure executeFunc(funcNumber : integer ;var head : pNode);

    var number : integer;
        info : infoArr;

    begin
        if ((funcNumber > 24) or (funcNumber < 0)) then writeln('function number not in range!')
        else 
            begin
                if ((funcNumber = 22) or ((funcNumber < 11) and (funcNumber > 5))) then writeLine;

                if (funcNumber mod 5 = 0) then number := 5
                else 
                    number := funcNumber mod 5;
                
                if (funcNumber <= 15) then info := getInput(number);

                case funcNumber of 
                    1  : addUniv(head , info);
                    2  : addFac(head , info); 
                    3  : addDep(head , info); 
                    4  : addSpec(head , info); 
                    5  : addStudent(head , info); 
                    6  : getAnswer(findUniv(head , info));
                    7  : getAnswer(findFac(head, info));
                    8  : getAnswer(findDep(head , info));
                    9  : getAnswer(findSpec(head , info));
                    10 : getAnswer(findStudent(head , info));
                    11 : removeUniv(head , info);
                    12 : removeFac(head , info);
                    13 : removeDep(head , info);
                    14 : removeSpec(head , info);
                    15 : removeStudent(head , info);
                    16 : sortUniv(head);
                    17 : sortFac(head);
                    18 : sortDep(head);
                    19 : sortSpec(head);
                    20 : sortStudent(head);
                    21 : setValues(head);
                    22 : print(head , 0);
                    23 : free(head);
                    24 : printMenu();
                end;
            end;
        writeLine;
    end;


begin 
end.