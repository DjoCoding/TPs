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

    function searchUniv(head : pNode ; name : string) : boolean;
    function searchFac(head : pNode; name : string) : boolean;
    function searchDep(head : pNode ; name : string) : boolean;
    function searchSpec(head : pNode ; name : string) : boolean;
    function searchStudent(head : pNode ; name : string): boolean;

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
    procedure destroy(var head : pNode);

    function getNumberUniv(head : pNode) : integer;
    function getNumberFac(head : pNode ; info : infoArr) : integer;
    function getNumberDep(head : pNode ; info : infoArr) : integer;
    function getNumberSpec(head : pNode ; info : infoArr) : integer;
    function getNumberStudent(head : pNode ; info : infoArr) : integer;

implementation

//this will create new nodes
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
                        
                        if (min <> current) then 
                            begin   
                                swap(min^.name , current^.name);
                                temp := min^.sub;
                                min^.sub := current^.sub;
                                current^.sub := temp;
                            end;
                        current := current^.next;
                    end; 
            end;
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

function searchUniv(head : pNode ; name : string) : boolean;

    var found : boolean;
        current : pNode;

    begin
        current := head;
        found := false;

        while ((current^.next <> NIL) and (not found)) do 
            begin 
                found := (current^.name = name);
                current := current^.next;
            end; 

        searchUniv := found;
    end;

function searchFac(head : pNode ; name : string) : boolean;

    var found : boolean;
        current , fac : pNode;

    begin
        current := head;
        found := false;
        
        while ((current <> NIL) and (not found)) do
            begin
                fac := current^.sub;

                while ((fac <> NIL) and (not found)) do 
                    begin
                        found := (fac^.name = name);
                        fac := fac^.next; 
                    end; 
                
                current := current^.next;
            end;
        

        searchFac := found;
    end;

function searchDep(head : pNode ; name : string) : boolean;

    var found : boolean;
        current , fac , dep : pNode;
    
    begin
        current := head;
        found := false;

        while ((current <> NIL) and (not found)) do 
            begin
                fac := current^.sub;

                while ((fac <> NIL) and (not found)) do 
                    begin 
                        dep := fac^.sub;
                        while ((dep <> NIL) and (not found)) do 
                            begin
                                found := (dep^.name = name);
                                dep := dep^.next; 
                            end;
                        fac := fac^.next;
                    end; 
                current := current^.next;
            end; 
        
        searchDep := found;
    end;

function searchSpec(head : pNode ; name : string) : boolean;

    var found : boolean;
        current , dep , fac , spec : pNode;

    begin
        current := head;
        found := false;

        while ((current <> NIL) and (not found)) do 
            begin
                fac := current^.sub;
                while ((fac <> NIL) and (not found)) do 
                    begin
                        dep := fac^.sub;
                        while ((dep <> NIL) and (not found)) do 
                            begin
                                spec := dep^.sub;
                                while ((spec <> NIL) and (not found)) do 
                                    begin
                                        found := (spec^.name = name);
                                        spec := spec^.next;
                                    end; 
                                dep := dep^.next;
                            end; 
                        fac := fac^.next;
                    end;
                current := current^.next; 
            end; 

        searchSpec := found;
    end;

function searchStudent(head : pNode ; name : string): boolean;

    var found : boolean;
        current , dep , fac , spec , student : pNode;

    begin
        current := head;
        found := false;

        while ((current <> NIL) and (not found)) do 
            begin
                fac := current^.sub;
                while ((fac <> NIL) and (not found)) do 
                    begin
                        dep := fac^.sub;
                        while ((dep <> NIL) and (not found)) do 
                            begin
                                spec := dep^.sub;
                                while ((spec <> NIL) and (not found)) do 
                                    begin
                                        student := spec^.sub;
                                        while ((student <> NIL) and (not found)) do 
                                            begin
                                                found := (student^.name = name);
                                                student := student^.next;
                                            end; 
                                        spec := spec^.next;
                                    end; 
                                dep := dep^.next;
                            end; 
                        fac := fac^.next;
                    end;
                current := current^.next; 
            end; 
        searchStudent := found;
    end;

//this procedure uses recursion (another one that does the same thing is present in the data file (iterative))
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
                        writeln;
                        current := current^.next;
                    end;
            end;
    end;

//this will destroy all the structure
procedure destroy(var head : pNode);

    var current , next : pNode;

    begin
        current := head;

        while (current <> NIL) do 
            begin
                next := current^.next;
                destroy(current^.sub);
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

//this will remove a specific node in the list ( => removes everything below it )
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

function getLength(head : pNode) : integer;

    var count : integer;
        current : pNode;

    begin
        count := 0; 
        current := head;
        while (current <> NIL) do 
            begin
                current := current^.next;
                count := count + 1; 
            end;
        
        getLength := count;
    end;

function getNumberUniv(head : pNode) : integer;

    begin
        getNumberUniv := getLength(head); 
    end;

function getNumberFac(head : pNode ; info : infoArr) : integer;

    var univ : pNode;

    begin
        univ := getUniv(head , info);
        getNumberFac := getLength(univ^.sub); 
    end;

function getNumberDep(head : pNode ; info : infoArr) : integer;

    var fac , univ : pNode;
        count : integer;

    begin
        count := 0;
        univ := getUniv(head , info);
        fac := univ^.sub;

        while (fac <> NIL) do 
            begin   
                count := count + getLength(fac^.sub);
                fac := fac^.next;
            end;
        
        getNumberDep := count;
    end;

function getNumberSpec(head : pNode ; info : infoArr) : integer;

    var count : integer;
        fac , univ , dep : pNode;
    
    begin
        count := 0;
        univ := getUniv(head , info);
        
        fac := univ^.sub;

        while (fac <> NIL) do 
            begin
                dep := fac^.sub;
                while (dep <> NIL) do 
                    begin
                        count := count + getLength(dep^.sub);
                        dep := dep^.next; 
                    end; 
                fac := fac^.sub;
            end;
        getNumberSpec := count;
    end;


function getNumberStudent(head : pNode ; info : infoArr) : integer;

    var univ , fac , dep , spec : pNode;
        count : integer;
    
    begin
        count := 0;
        univ := getUniv(head , info);
        fac := univ^.sub;

        while (fac <> NIL) do 
            begin
                dep := fac^.sub;
                while (dep <> NIL) do 
                    begin
                        spec := dep^.sub;
                        while (spec <> NIL) do 
                            begin
                                count := count + getLength(spec^.sub);
                                spec := spec^.next; 
                            end; 
                        dep := dep^.next;
                    end; 
                fac := fac^.next;
            end; 
        
        getNumberStudent := count;
    end;





begin 
end.