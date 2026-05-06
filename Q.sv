module queue();

    int Q[$];
    int Q_n[$:19];
    int D_n[];
    int Q_arr[][ $ ];
   

    //Creating Q
    function void create_queue();
        Q = {};
        for (int i = 1; i <= 10; i++) begin
            Q.push_back(i * 10);
        end

        $display("   Size     : %0d", Q.size());
        $write  ("   Elements : ");
        foreach (Q[i]) begin
            $write("%0d ", Q[i]);
        end
        $display("");
    endfunction

    //Creating Q_n, copy Q
    function void create_queue_n();
        Q_n = Q;                        // copy Q into Q_n

        for (int i = 11; i <= 20; i++) begin
            Q_n.push_back(i * 10);      // bounded queue ignores push when full
        end

        // Overflow attempt
        if (Q_n.size() < 20)
            Q_n.push_back(210);
        else
            $display("Queue is full, 210 not added");

        $display("First : %0d", Q_n[0]);
        $display("Last  : %0d", Q_n[$]);
        $display("Size  : %0d", Q_n.size());
        // $write  ("Elements : ");
        // foreach (Q_n[i]) begin
        //     $write("%0d ", Q_n[i]);
        // end
        // $display("");
    endfunction

    function void shrink_Q_n();
        while(Q_n.size()>5) begin
            Q_n.pop_back();

        end
        $display("Size : %0d", Q_n.size());
        
    endfunction

    function  void add_elements();
        // Add element at head and tail
        Q_n.push_front(0);   // head
        Q_n.push_back(60);    // tail

        // Display elements
        $display("\nAfter adding at head and tail:");
        foreach (Q_n[i]) begin
            $write("%0d ", Q_n[i]);
        end
        $display("");
        
    endfunction

    function void remove_elements();
        Q_n.pop_front();
        Q_n.pop_back();
        $display("After removing head and tail:");
        foreach(Q_n[i])begin
            $write(" ",Q_n[i]);   
        end
        $display("");

    endfunction 

    //Copying to D_n
    // function void copy_to_D_n();
    //     D_n = new[Q_n.size()];

    //     for (int i = 0; i < Q_n.size(); i++) begin
    //         D_n[i] = Q_n[i];
    //     end

    //     $display("\nDynamic Array D_n:");
    //     foreach (D_n[i]) begin
    //         $write("%0d ", D_n[i]);
    //     end
    //     $display("");
        
    // endfunction
    

    //Function Calls
    initial begin
        create_queue();
        create_queue_n();
        shrink_Q_n();
        add_elements();
        remove_elements();
        //copy_to_D_n();

        $finish;                        
    end

endmodule