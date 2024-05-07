unit TREEF;

interface 

    uses MATHF;

    type node_t = ^node_type;
        node_type = record 
            value: integer;
            left, right: node_t;
        end;
    
    function tree_init(level: integer): node_t;
    procedure tree_remove(var root: node_t);

    procedure dfs_in(root: node_t);
    procedure dfs_pre(root: node_t);
    procedure dfs_post(root: node_t);

    procedure add_childs(root: node_t);
    procedure search_with_depth(root: node_t; value: integer);

    procedure delete_childs(root: node_t);

    function search(root: node_t; value: integer): boolean;

    function get_max(root: node_t): integer;
    function get_min(root: node_t): integer;

    function get_sum(root: node_t): integer;

implementation

function node_init(value: integer): node_t;

    var result: node_t;

    begin
        new(result);
        result^.value := value;
        result^.left := NIL;
        result^.right := NIL;
        node_init := result;
        result := NIL; 
    end;

function get_tree(var root: node_t; level: integer): node_t;

    begin
        if (level = 0) then 
            begin 
                get_tree := NIL;
                exit();
            end;
        
        root := node_init(random(100));
        root^.left := get_tree(root^.left, level - 1);
        root^.right := get_tree(root^.right, level - 1);

        get_tree := root;
    end;

function tree_init(level: integer): node_t;

    var root: node_t;

    begin
        root := NIL;
        tree_init := get_tree(root, level);
        root := NIL;
    end;

procedure tree_remove(var root: node_t);

    var left, right: node_t;

    begin
        if (root = NIL) then exit();

        left := root^.left;
        right := root^.right;

        dispose(root);
        root := NIL;

        tree_remove(left);
        tree_remove(right);
    end;

function search(root: node_t; value: integer): boolean;

    begin
        if (root = NIL) then 
            begin
                search := FALSE;
                exit(); 
            end; 
        
        if (root^.value = value) then 
            begin
                search := TRUE;
                exit(); 
            end;
        
        search := search(root^.left, value);

        if (not search) then 
            search := search(root^.right, value);
    end;

function get_max_value(root: node_t; root_value: integer): integer;

    begin
        if (root = NIL) then 
            begin 
                get_max_value := root_value;
                exit();
            end;
        
        get_max_value := max(root^.value, get_max_value(root^.left, root_value), get_max_value(root^.right, root_value));
    end;

function get_max(root: node_t): integer;

    begin
        get_max := get_max_value(root, root^.value); 
    end;

function get_min_value(root: node_t; root_value: integer): integer;

    begin
        if (root = NIL) then 
            begin
                get_min_value := root_value;
                exit(); 
            end; 
        
        get_min_value := min(root^.value, get_min_value(root^.left, root_value), get_min_value(root^.right, root_value));
    end;
    

function get_min(root: node_t): integer;

    begin
        get_min := get_min_value(root, root^.value); 
    end;

function get_sum(root: node_t): integer;

    begin 
        if (root = NIL) then 
            begin
                get_sum := 0;
                exit(); 
            end;

        get_sum := root^.value + get_sum(root^.left) + get_sum(root^.right);
    end;

procedure dfs_in(root: node_t);

    begin
        if (root = NIL) then exit();

        dfs_in(root^.left);
        writeln(root^.value);
        dfs_in(root^.right);
    end;

procedure dfs_pre(root: node_t);

    begin
        if (root = NIL) then exit();

        writeln(root^.value);
        dfs_pre(root^.left);
        dfs_pre(root^.right); 
    end;

procedure dfs_post(root: node_t);

    begin
        if (root = NIL) then exit();

        dfs_post(root^.left);
        dfs_post(root^.right);
        writeln(root^.value); 
    end;

function is_leaf(root: node_t): boolean;

    begin
        is_leaf := (root^.left = NIL) and (root^.right = NIL); 
    end;

// LEFT_OR_RIGHT = TRUE => RIGHT
procedure add_childs(root: node_t; LEFT_OR_RIGHT: boolean);

    begin
        if (LEFT_OR_RIGHT) then 
            begin
                if (is_leaf(root)) then 
                    begin 
                        root^.left := node_init(9); 
                        exit();
                    end;
                
                add_childs(root^.right, LEFT_OR_RIGHT);
            end
        else 
            begin
                if (is_leaf(root)) then 
                    begin 
                        root^.right := node_init(22);
                        exit();
                    end;

                add_childs(root^.left, LEFT_OR_RIGHT); 
            end;
    end;

procedure add_childs(root: node_t);

    begin
        add_childs(root, TRUE);
        add_childs(root, FALSE); 
    end;


function search(root: node_t; value: integer; var depth: integer): boolean;

    begin 
        if (root = NIL) then 
            begin 
                search := FALSE;
                exit();
            end;
        
        search := (root^.value = value);

        if (search) then 
            exit();

        inc(depth);
        search := search(root^.left, value, depth);

        if (search) then exit();

        dec(depth);

        search := search(root^.right, value, depth);
    end;


procedure search_with_depth(root: node_t; value: integer);

    var depth: integer;
        SEARCH_RESULT: boolean;

    begin
        depth := 0;
        SEARCH_RESULT := search(root, value, depth);

        if (SEARCH_RESULT) then 
            writeln('FOUND AT DEPTH: ', depth)
        else 
            writeln('NOT FOUND!'); 
    end;

procedure delete_node(parent, root: node_t; LEFT_OR_RIGHT: boolean);    

    begin
        if (LEFT_OR_RIGHT) then 
            begin
                if (is_leaf(root)) then 
                    if (parent <> NIL) then 
                        begin
                            dispose(root);
                            root := NIL;
                            parent^.right := NIL; 
                        end
                    else 
                        tree_remove(root)
                else 
                    delete_node(root, root^.right, LEFT_OR_RIGHT);
            end
        else 
            begin
                if (is_leaf(root)) then 
                    if (parent <> NIL) THEN 
                        begin
                            dispose(root);
                            root := NIL;
                            parent^.left := NIL; 
                        end
                    else 
                        tree_remove(root)
                else 
                    delete_node(root, root^.left, LEFT_OR_RIGHT);
            end;
    end;


procedure delete_childs(root: node_t);

    begin
        delete_node(NIL, root, TRUE);
        delete_node(NIL, root, FALSE); 
    end;


begin 
end.

