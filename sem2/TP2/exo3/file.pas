program exo3;

uses sll;

procedure listToFile(name : string ; head:  pNode);

    var myFile : text;
        current : pNode;

    begin
        assign(myFile , name);
        current := head;

        rewrite(myFile);

        while (current <> NIL) do 
            begin 
                writeln(myFile , current^.value);
                current := current^.next;
            end;
        
        close(myFile);
    end;

procedure main();

    var head : pNode;

    begin
        randomize;
        head := getList(random(20));
        print(head);
        listToFile('djaoued.txt' , head);
        free(head); 
    end;

begin
    main();
end.