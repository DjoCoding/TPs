unit BFSF;

interface

    uses TREEF, QUEUEF;
    
    procedure bfs(root: node_t);
    
implementation

procedure bfs(root: node_t);

    var current: node_t;
        num_nodes_in_level: integer;
        count: integer;

    begin 
        queue_init();
        enqueue(root);
        num_nodes_in_level := 1;
        count := 0;

        while (not (queue_empty())) do 
            begin
                current := dequeue();
                write(current^.value, '  ');
                inc(count);
                
                if (count = num_nodes_in_level) then 
                    begin
                        writeln();
                        num_nodes_in_level := num_nodes_in_level * 2;
                        count := 0; 
                    end;

                enqueue(current^.left);
                enqueue(current^.right); 
            end;
        
        current := NIL;
    end;

begin 
end.