program exo5;

uses sll;

//using the position of a node in a list , we get it's row if it's represented in matrix form
function getRow(col , number : integer) : integer;

    begin
        if (number mod col = 0) then getRow := number div col
        else 
            getRow := number div col + 1; 
    end;

function getCol(col , number : integer) : integer;

    begin
        if (number mod col = 0) then getCol := col
        else 
            getCol := number mod col; 
    end;

function checkPower2(number : integer) : boolean;

    var i : integer;

    begin   
        if (number = 0) then checkPower2 := true
        else 
            begin
                i := 1;
                checkPower2 := false;

                while ((i * i <= number) and (not checkPower2)) do 
                    begin
                        checkPower2  := (i * i = number);
                        i := i + 1;
                    end;
            end;
    end;


//suppose here that the sqrt(number) is an integer
function sqrt(number : integer) : integer;

    var i : integer;

    begin
        i := 0;

        while (i * i <> number) do 
            i := i + 1;

        sqrt := i; 
    end;

//if the matrix is a square matrix , then dim(Mat) = sqrt(length(list));
function getDimension(head : pNode) : integer;

    var len : integer;

    begin
        len := length(head);
        if (checkPower2(len)) then getDimension := sqrt(len)
        else 
            getDimension := -1; 
    end;

//for every node in the list , we get it's row and col
//suppose the matrix is a square matrix
procedure getPos(head : pNode);

    var current : pNode;
        dim , index : integer;

    begin
        dim := getDimension(head);

        if (dim > 0) then 
            begin
                index := 1; //this will represent the index of the node in the list
                current := head; 
                while (current <> NIL) do 
                    begin 
                        writeln(current^.value , ' : row = ' , getRow(dim , index) , ' ; col = ' , getCol(dim , index));
                        current := current^.next;
                        index := index + 1;
                    end;
            end
        else 
            writeln('this can not be a square matrix!')
    end;

//partie de l'exo 6

//knowing the row and the col of a node in the list , and it's dim , we get the index of the node
function getIndex(dim , i , j :  integer) : integer;

    begin
        getIndex := ((i - 1) * (dim) + j); 
    end;


//on suppose que la list chainee est une matrice carre de dimension dim
function getElement(head : pNode ; i , j : integer) : pNode;

    begin
        getElement := getNode(head , getIndex(getDimension(head) , i  , j)); 
    end;

//suppose it's a square matrix
procedure printMat(head : pNode);

    var dim : integer;
        i : integer;
        current : pNode;
    
    begin   
        i := 1;
        current := head;
        dim := getDimension(head);
        
        writeln;

        while ((current <> NIL)) do
            begin
                if (i = dim + 1) then 
                    begin
                        writeln;
                        i := 1; 
                    end;
                write('| ' , current^.value , ' |');
                current := current^.next;
                i := i + 1;
            end;
        for i := 1 to 2 do 
            writeln;
    end;

procedure editValue(var head : pNode ; i , j : integer ; value : string);

    var node : pNode;

    begin
        node := getNode(head , getIndex(getDimension(head) , i , j));
        node^.value := value;
    end;

function getValue(head : pNode; i , j :integer) : string;

    begin
        getValue := getElement(head , i , j)^.value; 
    end;


procedure main();

    var head , elmnt : pNode;
        val : integer;
        i , j : integer;
        value : string;

    begin
        randomize;
        val := random(5) + 5;
        head := getList(val * val);
        printMat(head);
        
        //exo5
        // getPos(head);

        //exo6
        // writeln('the dimension is : ' , getDimension(head));
        // write('type i : ');readln(i);
        // write('type j : ');readln(j);
        // elmnt := getElement(head , i , j);
        // writeln('the element is : ' , elmnt^.value);
    

        //exo7
        write('type i : ');readln(i);
        write('type j : ');readln(j);
        write('type a string : ');readln(value);
        editValue(head , i , j  , value);
        printMat(head);

        //exo8
        // write('type i : ');readln(i);
        // write('type j : ');readln(j);
        // writeln('the value of the element is : ' , getValue(head , i , j));
        

        free(head); 
    end;

begin
    main();
end.