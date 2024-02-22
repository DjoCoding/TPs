program exo;


function findNewLetter(c  : char ; number : integer) : char;
	
	var val : integer;

	begin
		val := ord(c) - 65;

		findNewLetter := chr(((val + number) mod 26) + 65);
	end;


function checkChar(c : char) : boolean;
	
	begin 
		checkChar := ((c >= 'A') and (c <= 'Z'));
	end;

function checkInput(s  : string) : boolean;
	
	var len : integer;
		i : integer;

	begin
		len := length(s); 
		i := 1;
		checkInput := true;

		while ((i <= len) and (checkInput)) do
			begin
				checkInput := checkInput and checkChar(s[i]);
				i := i + 1;
			end;
	end;

function generateKey(length : integer) : string;
	
	var i : integer;
		randomValue : integer;

	begin
		generateKey := '';
		for i := 1 to length do 
			begin
				randomValue := random(26) + 65;
				generateKey := generateKey + chr(randomValue);
			end;
	end;

function getValue(number:  integer): integer;
	
	begin
		while (number < 0) do 
			number := number + 26;
		number := number mod 26; 
		getValue := number;
	end;

function encryption(s , key : string) : string;
	
	var len ,  i: integer;

	begin
		len := length(s);
		encryption := '';

		for i := 1 to len do 
			encryption := encryption + chr(getValue(ord(s[i]) + ord(key[i])) + 65);
	end;

function decryption(s , key : string) : string;
	
	var len , i : integer;

	begin
		len := length(s);
		decryption := '';
		for i := 1 to len do 
			decryption := decryption + chr(getValue(ord(s[i]) - ord(key[i])) + 65) 
	end;

function rotateString(s : string ; number : integer) : string;
	
	var i : integer;	
		len : integer;

	begin
		len := length(s);
		rotateString := '';
		for i := 1 to len do 
			rotateString := rotateString + findNewLetter(s[i] , number);
	end;

function decryptCipher(cipherText : string ; number : integer) : string;

	begin
		decryptCipher := rotateString(cipherText , 26 - number); 
	end;

function encryptionUsingCipher(s , key : string ; number : integer) : string;

	begin
		encryptionUsingCipher := encryption(rotateString(s , number mod 26) , key); 
	end; 

function decryptionUsingCipher(s , key : string ; number : integer) : string;

	begin
		decryptionUsingCipher := decryptCipher(decryption(s , key) , number mod 26);
	end;

procedure main();

	var plaintext , key : string;
		len : integer;
		cipher : string;
		number:  integer;

	begin 
		repeat
			write('type the message to be encrypted : ');readln(plaintext);
		until(checkInput(plaintext));

		len := length(plaintext);
		key := generateKey(len);
		cipher := encryption(plaintext , key);
		writeln('this is without usingt the rotation : ');
		writeln('the encrypted message is : ' , cipher);
		writeln('the decrypted message is : ' , decryption(cipher , key));
		

		writeln;

		writeln('this is after using the rotation : ');
		write('type the number of the rotation :  ');readln(number);
		cipher := encryptionUsingCipher(plaintext , key , number);
		writeln('the encrypted message is : ' ,cipher);
		writeln('the decrypted message is : ' , decryptionUsingCipher(cipher , key , number));
	end;

begin
	main();
end.

