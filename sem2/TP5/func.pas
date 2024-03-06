unit func;

interface 
    
    uses lib;

    function readInteger(s : string) : integer;
    procedure printMenu();
    procedure executeFunction(funcNumber : integer ; var head : pNode);

implementation

procedure printMenu();

    var myFile : text;
        line : string;

    begin
        assign(myFile , './user_interface/menu.txt');

        reset(myFile);

        while (not eof(myFile)) do 
            begin
                readln(myFile , line);
                writeln(line); 
            end; 
        
        close(myFile);
    end;

function readInteger(s : string) : integer;

    var result : integer;

    begin
        write(s);
        readln(result);
        readInteger := result; 
    end;

procedure writeNewLine(number : integer);

    var i : integer;

    begin
        for i := 1 to number do writeln; 
    end;

procedure executeFunction(funcNumber : integer ; var head : pNode);

    var lists : list;
        size : integer;
        newList : pNode;
    begin 
        writeNewLine(2);

        case funcNumber of
            1 : begin 
                    free(head);
                    size := readInteger('type the size of the linked list : ');
                    head := getList(size , size);
                end;
            2 : print(head);
            3 : begin 
                    if (head = NIL) then 
                        writeln('no values available in the linked list')
                    else 
                        writeln('The minimum value in the linked list is : ' , min(head));
                end;
            4 : head := reverseList(head);
            5 : begin   
                    free(head);
                    head := getList(size , 1);
                    writeln('binary linked list : ');
                    print(head);
                    writeln;
                    writeln('the decimal value is : ' , convertDecimal(head));
                end;
            6 : begin 
                    lists := divideList(head);
                    write('the odd list : ');
                    print(lists.odd);
                    write('the even list : ');
                    print(lists.even);
                    free(lists.odd);
                    free(lists.even);
                end;
            7 : begin 
                    if (checkSortedList(head)) then 
                        writeln('the linked list is sorted!')
                    else
                        writeln('the linked list isn''t sorted!')
                end;
            8 : begin
                    size := readInteger('type the number of the elements: ');
                    newList := getListWithoutLastElements(head , size);
                    print(newList); 
                    free(newList);
                end;
            9 : printMenu();
        end;

        writeNewLine(2);
    end;

begin 
end.