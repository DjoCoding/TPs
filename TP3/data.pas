unit data;

interface 

    uses lib;

    const size = 13;

    type dataSet = array[1..size] of infoArr;

    function getData() : dataSet;
    procedure printArray(info : infoArr);
    procedure setValues(var head : pNode);
    // procedure setRandomData();


implementation

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

procedure printArray(info : infoArr);

    var i : integer;

    begin
        write('[ ');
        for i := 1 to 4 do 
            write(info[i] , ' , ');
        writeln(info[5] , ']'); 
    end;

// procedure setRandomData();

//     var myFile : text;
//         info : infoArr;
//         i : integer;
    
//     begin
//         info := getRandomInfo();

//         assign(myFile , 'data.txt');

//         append(myFile);

//         for i := 1 to 5 do 
//             writeln(myFile , info[i]);
        
//         close(myFile);
//     end;

procedure setValues(var head : pNode);

    var data : dataSet;
        i : integer;

    begin
        data := getData();

        for i := 1 to size do 
            addStudent(head , data[i]);
    end;



begin 
end.