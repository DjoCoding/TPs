unit func;

interface 

    uses dll;

    function readInteger(s : string) : integer;
    function readString(s : string) : string;
    procedure printMenu();
    procedure execFunction(funcNumber : integer ; var head , tail : pNode);


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

procedure writeLines();

    var i : integer;

    begin
        for i := 1 to 2 do 
            writeln(); 
    end;

procedure execFunction(funcNumber : integer ; var head , tail : pNode);

    var pos1 , pos2 , size , temp : integer;

    begin 
        writeLines;

        case funcNumber of 
            1 : begin 
                    free(head , tail);
                    size := readInteger('type the size of the linked list : ');
                    getRandomList(head , tail , size);
                end;
            2 : print(head);
            3 : begin
                    pos1 := readInteger('type the position of the first node : ');
                    pos2 := readInteger('type the position of the second node : ');
                    swapNodeValues(head , pos1 , pos2); 
                end;
            4 : reverseList(head , tail);
            5 : begin
                    temp := readInteger('type the value : ');
                    removeAfterValue(head , tail , temp); 
                end;
            6 : addValue(head , 1);
            7 : begin
                    temp := readInteger('type the value you wanna insert in the list: '); 
                    insertionSort(head);
                    insert(head, tail , temp);
                end;
            8 : begin
                    temp := readInteger('type the value you want : ');
                    twoSum(head , temp); 
                end;
            9 : insertionSort(head);
            10 : bubbleSort(head);
            11 : begin 
                    if (testSorting(head)) then writeln('the list is sorted!')
                    else 
                        writeln('the list is not sorted!');
                end;
            12 : begin
                    divideList() 
                end;
        end;
    end;

begin 
end.