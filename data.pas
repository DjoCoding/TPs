unit data;

interface 

    uses lib;

    const size = 13;

    type dataSet = array[1..size] of infoArr;

    function getData() : dataSet;
    procedure printArray(info : infoArr);
    procedure setData();
    function setValues() : pNode;

implementation

function getData() : dataSet;

    var result : dataSet;
        i , j : integer;
        myFile : text;
        s : string;

    begin
        i := 1;
        j := 1;

        assign(myFile , 'result.txt');

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

procedure printArray(info : infoArr);

    var i : integer;

    begin
        write('[ ');
        for i := 1 to 4 do 
            write(info[i] , ' , ');
        writeln(info[5] , ']'); 
    end;

procedure setRandomData();

    var myFile : text;
        info : infoArr;
        i : integer;
    
    begin
        info := getRandomInfo();

        assign(myFile , 'data.txt');

        append(myFile);

        for i := 1 to 5 do 
            writeln(myFile , info[i]);
        
        close(myFile);
    end;

function getInput(number : integer) : infoArr;

    var result : infoArr;

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
        
        if (number >= 1) then 
            begin
                write('type the Departement Name : ');readln(result[3]); 
            end;
        
        if (number >= 1) then 
            begin
                write('type the Speciality Name : ');readln(result[4]); 
            end;
        
        if (number >= 1) then 
            begin
                write('type the Student Name : ');readln(result[5]); 
            end;
        
        getInput :=  result;

    end;


function setValues() : pNode;

    var head : pNode;
        data : dataSet;

    begin
        data := getData();
        head := NIL;

        for i := 1 to size do 
            addStudent(head , data[i]);

        setData := head; 
    end;



begin 
end.