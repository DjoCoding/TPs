unit func;

interface 

    uses doubly;

    function readInteger(s : string) : integer;
    function readString(s : string) : string;
    procedure printMenu();
    procedure execFunction(var list : pList ; var lists : pLists ;var funcNumber : integer);

implementation

function readInteger(s : string) : integer;

    var result : integer;

    begin
        write(s);
        readln(result);
        readInteger := result; 
    end;

function readString(s : string) : string;

    var result : string;

    begin
        write(s);
        readln(result);
        readString := result; 
    end;

procedure printMenu();

    var myFile : text;
        s : string;
    
    begin
        assign(myFile , '../user_interface/menu.txt');
        reset(myFile);

        while (not eof(myFile)) do 
            begin 
                readln(myFile , s);
                writeln(s);
            end;  
        
        close(myFile);
    end;

procedure writeLines(number : integer);

    var i : integer;

    begin
        for i := 1 to number do 
            writeln(); 
    end;

procedure execFunction(var list : pList ; var lists : pLists ;var funcNumber : integer);
    
    var pos1 , pos2 , value : integer;

    begin
        writeLines(1);

        case funcNumber of 
            1 :  begin
                    free(list);
                    list := getList(11); 
                end;
            2 : print(list); 
            3 : begin 
                    pos1 := readInteger('type the index of the first element : ');
                    pos2 := readInteger('type the index of the second element : ');
                    swap(list , pos1 , pos2);
                end;
            4 : reverseList(list);
            5 : begin   
                    value := readInteger('type the value you want to remove after it : ');
                    removeAfterValueX(list , value);
                end;
            6 : addOne(list);
            7 : begin
                    Insertion_Sort(list);
                    value := readInteger('type the value to insert it in the sorted list : ');
                    insert_value(list , value); 
                end;
            8 : begin
                    value := readInteger('type the value : ');
                    twoSum(list , value); 
                end;
            9 : Insertion_Sort(list);
            10 : bubble_sort(list);
            11 : begin 
                    if (check_sorted_list(list)) then writeln('the list is sorted!')
                    else 
                        writeln('the list isn''t sorted!');
                end;
            12 : begin  
                    freeLists(lists);
                    divideList(lists , list); 
                    writeln('those are the lists : ');
                    writeln;
                    printLists(lists);
                end;
            13 : begin 
                    freeLists(lists);
                    divideListIntoFour(lists , list);
                    writeln('those are the lists : ');
                    writeln;
                    printLists(lists);
                end;
            14 : printMenu();
            15 : funcNumber := 0;
            
        end;

        writeLines(2);
    end;

begin 
end.