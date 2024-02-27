program TP4;

uses dll;

procedure main();

    var head, tail : pNode;
        number : integer;

    begin
        randomize;

        head := NIL;
        tail := NIL;

        getRandomList(head , tail , 10);

        print(head);

        bubbleSort(head , tail);

        // insertionSort(head);

        print(head);

        twoSum(head , 30);

        free(head , tail);
    end;

begin 
    main();
end.