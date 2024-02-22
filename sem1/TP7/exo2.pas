program exo;

uses CRT;

type tab = array[1..500] of string;

//for operation 1 

    //THIS FUNCTION WILL RETURN THE POSITION OF THE FIRST OCCURENCE OF THE SEACHED STRING IN THE ORIGINAL STRING
    //IF IT DOESN'T EXIST IT'LL RETURN 0
function find_string(start : integer ; OriginalString , SearchedString : string) : integer;

    var i , j : integer;
        found : boolean;
    
    begin
        found := false;
        find_string := 0;
        i := start;

        while (i <= length(OriginalString) - length(SearchedString) + 1) and not found do 
            begin

                if (OriginalString[i] <> SearchedString[1]) then i := i + 1
                else 
                    begin
                        j := 2;

                        while (j <= length(SearchedString)) and (OriginalString[i + j - 1] = SearchedString[j]) do 
                            j := j + 1;
                        
                        if (j = length(SearchedString) + 1) then begin 
                                find_string := i;
                                found := True;
                            end
                        else 
                            i := i + j - 1;

                    end; 
            end; 
    end;

    //THIS PROCEDURE WILL PRINT ALL THE POSITIONS OF THE SEARCHEDSTRING IN THE ORIGINAL STRING USING THE PREVIOUS FUNCTION
procedure find_all_occurences(OriginalString , SearchedString : string);
    
    var  start , position: integer;
    
    begin

        start := 1;

        position := find_string(start , OriginalString , SearchedString);


        if (position = 0) then writeln('NOT FOUND!')
        else 
            begin
                while (position <> 0) do 
                    begin
                        writeln('The string is found in : ' , position);
                        start := position + length(SearchedString);
                        position := find_string(start , OriginalString ,SearchedString); 
                    end; 
            end;
    end;


//OPERATION 2

//THIS FUNCTION WILL REMOVE THE FIRST OCCURENCE OF THE SEARCHED STRING NI THE ORIGINAL STRING AND IT'LL RETURN THE RESULT STRING
function remove(OriginalString , SearchedString : string) : string;

    var i , j : integer;
        position : integer;

    begin
        position := find_string(1 , OriginalString , SearchedString);

        if (position = 0) then remove := OriginalString
        else 
            begin 
                remove := '';

                for i := 1 to position - 1 do 
                    remove := remove + OriginalString[i];
                
                for i := (position + length(SearchedString)) to length(OriginalString) do 
                    remove := remove + OriginalString[i];
            end;

    end;

function remove_all_occurences(OriginalString , SearchedString : string) : string;

    var temp : string;
        position : integer;
    
    begin
        temp := OriginalString;

        position := find_string(1 , temp , SearchedString); 

        if (position = 0) then writeln(OriginalString)
        else 
            begin
                while (position <> 0) do begin 
                        temp := remove(temp , SearchedString); 
                        position := find_string(1 , temp , SearchedString);
                    end;
            end;
        
        remove_all_occurences := temp;
    end;

//THIS IS FOR THE OPERATION3
function replace(wordd , OriginalString , SearchedString : string) : string;

    var temp : string;
        i , lenS , lenW: integer;
        position : integer;
    
    begin
        position := find_string(1 , OriginalString , SearchedString);

        lenS := length(SearchedString);
        lenW := length(wordd);


        if (position = 0) then replace := OriginalString
        else 
            begin
                replace := '';

                for i := 1 to position - 1 do 
                    replace := replace + OriginalString[i];
                
                if (lenS > lenW) then 
                    begin
                        for i := 1 to lenW do 
                            replace := replace + wordd[i];
                        
                    end
                else 
                    begin
                        for i := 1 to (lenW) do 
                            replace := replace + wordd[i];
                    end;
                
                for i := position + lenS to length(OriginalString) do 
                    replace := replace + OriginalString[i];
                
            end;

    end;

procedure replace_all_occurences(wordd : string ; OriginalString , SearchedString : string);

    var temp : string;
        position : integer;

    begin
        temp := OriginalString;

        position := find_string(1 , temp , SearchedString);

        if (position = 0) then writeln(OriginalString)
        else 
            if (SearchedString = wordd) then writeln(OriginalString)
            else 
                begin
                    while (position <> 0) do 
                        begin
                            temp := replace(wordd , temp , SearchedString); 
                            position := find_string(1 , temp , SearchedString);
                        end;
                end;

        writeln(temp);

    end;

//FOR THE OPERATION 4

function extractWords(OriginalString : string ; var count : integer) : tab;

    //count will return the number of the words found in the text

    var i : integer;
        temp : string;
    
    begin
        temp := '';
        count := 0;

        for i := 1 to length(OriginalString) do 
            begin
                if (OriginalString[i] = ' ') then begin 
                        count := count + 1;
                        extractWords[count] := temp;
                        temp := '';
                    end
                else 
                    temp := temp + OriginalString[i];
            end; 
        
        count := count + 1;
        extractWords[count] := temp;
    end;


procedure sortStrings(size : integer ; var words : tab);

    var i , j  : integer;
        temp : string;

    begin
        for i := 1 to (size - 1) do 
            for j := 1 to (size - i) do 
                if (words[j] > words[j+1]) then 
                    begin
                        temp := words[j];
                        words[j] := words[j+1];
                        words[j+1] := temp; 
                    end;

        
    end;

    
function displayWords(OriginalString : string) : string;

    var i , size : integer;
        words : tab;

    begin
        words := extractWords(OriginalString , size);

        sortStrings(size , words);

        displayWords := '';

        for i := 1 to size do 
            displayWords := displayWords + words[i] + ' ';
    end;

//OPERATION 5

function find_new_string(OriginalString : string) : string;

    var i , j : integer;
        temp : string;
        words : tab;
        size : integer;
    
    begin
        words := extractWords(OriginalString , size);

        for i := 1 to (size - 1) do 
            for j := 1 to (size - i) do 
                begin
                    if length(words[j]) > length(words[j+1]) then
                        begin
                            temp := words[j];
                            words[j] := words[j+1];
                            words[j+1] := temp;
                        end; 
                end;

        find_new_string := '';
        
        for i := 1 to size do 
            find_new_string := find_new_string + words[i] + ' ';
    end;

procedure help();

    begin
        CLRSCR;
        writeln('                                              ==============HELP=============='); 
        writeln;
        writeln('1 : this choice will let you know the positions of all the occurences of a string in another one');
        writeln('2 : this choice will give you the ability to delete all the occurences of a string in another string');
        writeln('3 : this choice will let you replace all the occurences of some specific string in another string by a chosen word');
        writeln('4 : this choice will sort the words in the given string by alphabet');
        writeln('5 : this choice will sort the words in the given string by length of the word');

        writeln;
    end;

procedure main();

    var OriginalString , SearchedString : string;
        operation : integer;
        i : integer;
        new_word : string;
        answer : string;

    begin

        CLRSCR;

        write('type the original string : ');readln(OriginalString);

        repeat

            write('which operation you wanna make (for more information type : 0) : ');readln(operation);

            case operation of 

                0 : begin 
                        clrscr;
                        help();
                    end;
                1 : begin 
                        clrscr; 
                        writeln;
                        writeln('                                    ==============OPERATION1==============');

                        writeln;
                        write('type the searched string : ');readln(SearchedString);
                        find_all_occurences(OriginalString , SearchedString);
                    end;
                2 : begin 
                        clrscr; 
                        writeln; 
                        writeln('                                    ==============OPERATION2==============');

                        writeln;
                        write('type the searched string : ');readln(SearchedString);
                        writeln('the updated string after removing all the occurences of "' , SearchedString , '" is : ' , remove_all_occurences(OriginalString , SearchedString));
                    end;

                3 : begin 
                        clrscr; 
                        writeln; 
                        writeln('                                    ==============OPERATION3==============');
                        writeln;
                        write('type the string you wanna replace : ');readln(SearchedString);
                        write('type the new word : ');readln(new_word);

                        writeln;
                        replace_all_occurences(new_word , OriginalString , SearchedString); 
                    end;
                4 : begin 
                        clrscr; 
                        writeln; 
                        writeln('                                    ==============OPERATION4==============');

                        writeln; 

                        writeln;
                        writeln(displayWords(OriginalString));
                    end;
                5 : begin 
                        clrscr; 
                        writeln; 
                        writeln('                                    ==============OPERATION5==============');

                        writeln;
                        writeln(find_new_string(OriginalString));
                    end;
            end;

            writeln;

            write('do you wanna test something else : ');readln(answer);

        until (answer[1] = 'n');
        
    end;

begin
    main();
end.