program exo;


function ROUND(number : integer) : integer;

    begin
        while (number < 0) do 
            number := number + 26;
        
        ROUND := number;
    end;


{
    this function will generate a random key based on the length
    of the given plaintext
}
function generateKEY(length : integer): string;

    var i : integer;

    begin
        generateKEY := '';
        for i := 1 to length do 
            generateKEY := generateKEY + chr(random(26) + 65); 
    end;



function CRYPT(key , plaintext : string) : string;

    var i : integer;
        len : integer;

    begin
        CRYPT := '';
        len := length(plaintext);

        for i := 1 to len do 
            CRYPT := CRYPT + chr(((ord(plaintext[i]) + ord(key[i])) mod 26) + 65);
    end;

function DECRYPT(key , ciphertext : string) : string;

    var i : integer;
        len : integer;

    begin
        DECRYPT := ''; 
        len := length(ciphertext);

        for i := 1 to len do 
            DECRYPT := DECRYPT + chr((ROUND(ord(ciphertext[i]) - ord(key[i])) mod 26) + 65);
    end;

function convertDigitToChar(number : integer) : char;
    
    begin
        convertDigitToChar := chr(number + ord('0')); 
    end;

function convertNumberToString(number : integer) : string;
    
    var result : string;

    begin
        result := '';
        if (number = 0) then result := '0';

        while (number <> 0) do 
            begin
                result := convertDigitToChar(number mod 10) + result;
                number := number div 10;
            end; 

        convertNumberToString := result;
    end;

function getAscii(s : string) : string;
    
    var i : integer;

    begin
        for i := 1 to length(s) do 
            getAscii := getAscii + convertNumberToString(converToBin(ord(s[i]))); 
    end;

function convertStringToNumber(s : string) : longint;
    
    var result : longint;

    begin
        len := length(s);
        result := 0;

        for i := 1 to len do 
            result := result * 10 + ord(s[i]) - 48;

        convertStringToNumber := result;
    end;

function converToBin(number : integer) : longint;
    
    var q : longint ; 
        r : integer;

    begin
        q := number;
        m := 1;
        repeat 
            r := q mod 2;
            q := q div 2;
            converToBin := r * m + converToBin;
            m := m * 10;
        until(q = 0); 
    end;

function XORchar(c1 , c2 : chra): integer;

    begin 
        if (c1 = c2) then XORchar := 0
        else XORchar := 1;
    end;

function getBytes(s : string) : string;
    
    var i : integer;

    begin
        for i := 1 to length(s) do 
            begin
                getBytes := getBytes + s[i];
                if (i mod 8 = 0) then 
                    getBytes := getBytes + ' '; 
            end; 
    end;

function XORstring(s1 , s2  : string) : string;
    
    var ascii1 , ascii2 : string;
        result : string;

    begin
        ascii1 := getAscii(s1);
        ascii2 := getAscii(s2);
        for i := 1 to length(ascii1) do 
            XORstring := XORstring + convertNumberToString(XORchar(s1[i] , s2[i]));
    end;


procedure main();

    var plaintext , key , ciphertext : string;

    begin
        write('type the text you wanna encrypt : ');readln(plaintext);

        key := generateKEY(length(plaintext));

        ciphertext := CRYPT(key , plaintext);

        writeln('the key is : ' , key);

        writeln('the encrypted message is : ' , ciphertext);

        writeln('back to our message : ' , DECRYPT(key , ciphertext)); 
    end;
    
begin   
    main();
end.