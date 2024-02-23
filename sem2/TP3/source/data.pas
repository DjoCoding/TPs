unit data;

interface 

    uses lib;

    type stat = array[1..5] of integer;

    procedure executeFunc(funcNumber : integer ;var head : pNode);
    function readInteger(s : string) : integer;

implementation

function readString(s : string) : string;

    var result : string;

    begin
        write(s);
        readln(result);
        readString := result; 
    end;

function readInteger(s : string) : integer;

    var result : integer;

    begin
        write(s);
        readln(result);
        readInteger := result; 
    end;

function initInfo() : infoArr;

    var result : infoArr;
        i : integer;

    begin
        for i := 1 to 5 do 
            result[i] := '';
        
        initInfo := result;
    end;

procedure printMenu();

    var myFile : text;
        s : string;

    begin
        assign(myFile , '../print/menu.txt');

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
        myFile : text;
        s : string;

    begin
        for i := 1 to 5 do 
            result[i] := '';
        
        assign(myFile , '../print/file.txt');

        reset(myFile);

        i := 0;

        while ((not eof(myFile)) and (i <> number)) do 
            begin
                readln(myFile , s);
                result[i + 1] := readString(s + ' : ');
                i := i + 1; 
            end;

        getInput :=  result;
    end;

//this will set all the information about a student in a an array then append it to another array!
function getData() : dataSet;

    var result : dataSet;
        i , j : integer;
        myFile : text;
        s : string;

    begin
        i := 1;
        j := 1;

        assign(myFile , '../print/data.txt');

        reset(myFile);

        while (not eof(myFile)) do 
            begin
                readln(myFile , s);
                result[i][(j - 1) mod 5 + 1] := s;
                if (j mod 5 = 0) then i := i + 1;
                j := j + 1;
            end;
        
        close(myFile);
        getData := result;
    end;

procedure setValues(var head : pNode);

    var data : dataSet;
        i : integer;

    begin
        destroy(head);

        data := getData();

        for i := 1 to size do 
            addStudent(head , data[i]);
    end;

procedure writeLine();

    var i : integer;

    begin
        writeln;
        for i := 1 to 50 do 
            write('='); 
        
        for i := 1 to 2 do writeln;
    end;


//this will answer the question of wether a univ (for exemple) exists or no! 
procedure getAnswer(bool : boolean);

    begin
        if (bool) then writeln('well found! :) ')
        else 
            writeln('not found! :( ') 
    end;

//additional procedure (can be implemented directly in other procedures)
procedure writeTab(size : integer);

    var i : integer;
    
    begin
        for i := 1 to size do 
            write('     '); 
    end;


function getStatistics(head : pNode ; info : infoArr) : stat;
    
    var result : stat;

    begin
        result[1] := getNumberUniv(head); 
        result[2] := getNumberFac(head , info); 
        result[3] := getNumberDep(head , info); 
        result[4] := getNumberSpec(head , info); 
        result[5] := getNumberStudent(head , info);

        getStatistics := result; 
    end;

procedure printStatistics(head : pNode);

    var current : pNode;
        info : infoArr;
        statArray : stat;

    begin
        current := head;
        info := initInfo();


        while (current <> NIL) do 
            begin   
                info[1] := current^.name;
                writeln(info[1]);
                statArray := getStatistics(head , info);
                writeTab(1);
                writeln('- Number of Faculties : ' , statArray[2]);
                writeTab(1);
                writeln('- Number of Departements : ' , statArray[3]);
                writeTab(1);
                writeln('- Number of Speccialities : ' , statArray[4]);
                writeTab(1);
                writeln('- Number of Students : ' , statArray[5]);
                current := current^.next;
                writeln;
            end;
    end;

//this procedure will print the content of the structure without using recursion
procedure printStructure(head : pNode);

    var univ , fac , dep , spec , student : pNode;
        i : integer;

    begin
        univ := head;
        i := 1;

        while (univ <> NIL) do 
            begin
                writeln(i , '-- ' , univ^.name);
                fac := univ^.sub;
                while (fac <> NIL) do 
                    begin
                        writeTab(1);
                        writeln('-' , fac^.name);
                        dep := fac^.sub;
                        while (dep <> NIL) do 
                            begin
                                writeTab(2);
                                writeln('-' , dep^.name);
                                spec := dep^.sub;
                                while (spec <> NIL) do 
                                    begin
                                        writeTab(3);
                                        writeln('-' , spec^.name);
                                        student := spec^.sub;

                                        while (student <> NIL) do 
                                            begin
                                                writeTab(4);
                                                writeln('-' , student^.name);
                                                student := student^.next; 
                                            end; 
                                        
                                        spec := spec^.next;
                                    end; 
                                
                                dep := dep^.next;
                            end; 
                        
                        fac := fac^.next;
                    end;
                
                i := i + 1;
                univ := univ^.next;
                writeln;
            end; 
    end;

procedure executeFunc(funcNumber : integer ;var head : pNode);

    var number : integer;
        info : infoArr;

    begin
        if ((funcNumber > 25) or (funcNumber < 0)) then writeln('function number not in range!')
        else 
            begin
                // if ((funcNumber = 22) or ((funcNumber < 11) and (funcNumber > 5))) then writeLine;

                if (funcNumber mod 5 = 0) then number := 5
                else 
                    number := funcNumber mod 5;
                
                if (funcNumber <= 15) then info := getInput(number);

                case funcNumber of 
                    1  : begin 
                            addUniv(head , info);
                            writeln;
                            writeln('the University ''' , info[1] ,''' is added succesfully!');
                        end;
                    2  : begin 
                            addFac(head , info); 
                            writeln;
                            writeln('the  Faculty ''' , info[2] ,''' is added succesfully!');
                        end;
                    3  : begin 
                            addDep(head , info); 
                            writeln;
                            writeln('the Departement ''' , info[3] ,''' is added succesfully!');
                        end;
                    4  : begin 
                            addSpec(head , info); 
                            writeln;
                            writeln('the Speciality ''' , info[1] ,''' is added succesfully!');
                        end;
                    5  : begin 
                            addStudent(head , info); 
                            writeln;
                            writeln('the Student ''' , info[1] ,''' is added succesfully!');
                        end;
                    6  : getAnswer(findUniv(head , info));
                    7  : getAnswer(findFac(head, info));
                    8  : getAnswer(findDep(head , info));
                    9  : getAnswer(findSpec(head , info));
                    10 : getAnswer(findStudent(head , info));
                    11 : begin 
                            removeUniv(head , info);
                            writeln('the university ''' , info[1] ,''' is removed succesfully!');
                        end;
                    12 : begin 
                            removeFac(head , info);
                            writeln('the Faculty ''' , info[2] ,''' is removed succesfully!');
                        end;
                    13 : begin 
                            removeDep(head , info);
                            writeln('the Departement ''' , info[3] ,''' is removed succesfully!');
                        end;
                    14 : begin 
                            removeSpec(head , info);
                            writeln('the Speciality ''' , info[4] ,''' is removed succesfully!');
                        end;
                    15 : begin
                            removeStudent(head , info);
                            writeln('the Student ''' , info[5] ,''' is removed succesfully!');
                        end;
                    16 : 
                        begin 
                            sortUniv(head);
                            writeln('well sorted!');
                        end;                          
                    17 : 
                        begin 
                            sortFac(head);
                            writeln('well sorted!');
                        end;                         
                    18 : 
                        begin 
                            sortDep(head);
                            writeln('well sorted!');
                        end;                         
                    19 : 
                        begin 
                            sortSpec(head);
                            writeln('well sorted!');
                        end;                          
                    20 : 
                        begin 
                            sortStudent(head);
                            writeln('well sorted!');
                        end;
                                               
                    21 : begin 
                            setValues(head);
                            writeln('information set succesfully!');
                        end;
                    22 : printStructure(head);
                    23 : begin 
                            destroy(head);
                            writeln('all cleared!');
                        end;
                    24 : printMenu();
                    25 : printStatistics(head);
                end;
            end;
        writeLine;
    end;




begin 
end.