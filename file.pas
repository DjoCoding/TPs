program test;

uses lib , data;

function getString(length : integer) : string;

    var result : string;
        i : integer;

    begin
        result := '';

        for i := 1 to length do 
            result := result + chr(random(26) + ord('A')); 
        
        getString := result;
    end;


procedure main();

    var func : integer;
        
    
    begin       
        head := setData();

        printMenu();

        write('choose one of the functions above : ');readln(func);




        free(head);
    end;

begin
    main();
end.