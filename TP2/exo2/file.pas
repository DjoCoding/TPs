program exo2;

uses sll;

function readFile(name : string ;var head : pNode) : integer;

    var myFile : text;
        str : string;

    begin
        assign(myFile , name);

        reset(myFile);

        while (not eof(myFile)) do 
            begin
                readln(myFile , str);
                add(head , str);
            end;

        close(myFile);
        readFile := length(head);
    end;

procedure main();

    var number : integer;
        head : pNode;

    begin
        number := readFile('djaoued.txt' , head);
        writeln('the length of the linked list is : ' , number);
        print(head);
        free(head); 
    end;

begin
    main();
end.