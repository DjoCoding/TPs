program exo1;

function getString(length : integer) : string;

    var result : string;
        i : integer;

    begin
        result := '';
        for i := 1 to length do 
            result := result + chr(ord('A') + random(26));

        getString := result; 
    end;

procedure fillFile(name : string ; number : integer);

    var myFile : text;
        i : integer;

    begin
        assign(myFile , name);

        rewrite(myFile);

        for i := 1 to number do 
            writeln(myFile , getString(10 + random(10)) , ' ');
        
        writeln(myFile);
        
        close(myFile);
    end;

procedure main();

    var number : integer;

    begin
        randomize;
        write('type a number : ');readln(number);
        fillFile('strings.txt' , number); 
    end;

begin
    main();
end.