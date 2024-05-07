uses TREEF, QUEUEF, BFSF;    

procedure main();

    var root: node_t;
        value: integer;

    begin
        randomize();

        root := tree_init(3);
        bfs(root);


        writeln('------------------------');

        // writeln(get_max(root));
        // writeln(get_min(root));

        writeln(get_sum(root));
        
        tree_remove(root); 
    end;

begin
    main();
end.