unit MATHF;

interface 

    function max(a, b, c: integer): integer;
    function min(a, b, c: integer): integer;

implementation

function max(a, b, c: integer): integer;

    begin
        if (a > b) then 
            if (b > c) then max := a
            else
                if (a > c) then max := a
                else 
                    max := c 
        else 
            if (a > c) then max := b 
            else 
                if (c > b) then max := c 
                else 
                    max := b;
    end;

function min(a, b, c: integer): integer;

    begin
        if (a < b) then 
            if (b < c) then min := a
            else
                if (a > c) then min := c
                else 
                    min := a 
        else 
            if (a > c) then min := c 
            else 
                if (c > b) then min := b
                else 
                    min := c; 
    end;

begin 
end.