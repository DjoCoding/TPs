program exo;

type tab = array[1..10] of string;

function find_words(text : string ; var count : integer) : tab;

    var i : integer;
        temp : string;
    

    begin
        count := 0;

        temp := '';

        for i := 1 to length(text) do 
            begin
                if (text[i] <> ' ') then 
                    temp := temp + text[i]
                else 
                    begin
                        count := count + 1;
                        find_words[count] := temp;
                        temp := '';
                    end;
            end; 
        
        count := count + 1;
        find_words[count] := temp;
    end;

procedure sort_words(var T : tab ; count : integer);

    var i , j : integer;
        temp : string;
    
    begin
        for i := 1 to (count - 1) do 
            for j := 1 to (count - i) do 
                begin
                    if (T[j] > T[j+1]) then 
                        begin
                            temp := T[j];
                            T[j] := T[j+1];
                            T[j+1] := temp; 
                        end; 
                end; 
    end;

procedure display(count : integer; T : tab);

    var i : integer;


    begin
        for i := 1 to count do 
            writeln(T[i]); 
    end;


var T : tab;
    count : integer;
    str : string;


begin 
    write('type a string : ');readln(str);

    T := find_words(str , count);

    writeln('before sorting : ');

    writeln('the number of words is : ' , count);

    display(count , T);

    
    writeln('after sorting : ');

    sort_words(T , count);

    display(count , T);

end.