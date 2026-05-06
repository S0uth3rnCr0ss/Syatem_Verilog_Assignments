module tb;

    byte assoc_arr[int];
    int  assoc_arr1[*];

    typedef struct {
        int runs;
        int wickets;
        int catches;
    } stats_t;

    stats_t players[string];

    function void handle_assoc_arr();
        int i;
        int rand_key;
    begin
        for (i = 0; i < 5; i++) begin
            assoc_arr[i] = i * 10;
        end

        $display("---- assoc_arr ----");
        foreach (assoc_arr[i]) begin
            $display("Index=%0d Value=%0d", i, assoc_arr[i]);
        end

        $display("Size = %0d", assoc_arr.num());

        assoc_arr.first(rand_key);
        repeat ($urandom % assoc_arr.num()) begin
            if (!assoc_arr.next(rand_key))
                assoc_arr.first(rand_key);
        end

        $display("Random element: Index=%0d Value=%0d",
                 rand_key, assoc_arr[rand_key]);
    end
    endfunction

    function void handle_assoc_arr1();
        int i;
    begin
        for (i = 1; i <= 10; i++) begin
            if (i % 2)
                assoc_arr1[i] = i;
            else begin
                case (i)
                    2:  assoc_arr1["two"]   = i;
                    4:  assoc_arr1["four"]  = i;
                    6:  assoc_arr1["six"]   = i;
                    8:  assoc_arr1["eight"] = i;
                    10: assoc_arr1["ten"]   = i;
                endcase
            end
        end

        $display("---- assoc_arr1 ----");
        foreach (assoc_arr1[key]) begin
            $display("Index=%0s Value=%0d", key, assoc_arr1[key]);
        end

        if (assoc_arr1.exists("ten"))
            $display("Index ten Exists");
    end
    endfunction

 
    function void handle_players();
    begin
        players["Sachin"] = '{726,0,6};
        players["Sewag"]  = '{700,3,4};
        players["Raina"]  = '{424,5,6};
        players["Dhoni"]  = '{546,0,10};
        players["Yuvraj"] = '{467,9,7};
        players["Zaheer"] = '{64,12,6};
        players["Aswin"]  = '{23,15,5};

        $display("---- Player Database ----");
        foreach (players[name]) begin
            $display("%s -> Runs:%0d Wickets:%0d Catches:%0d",
                     name,
                     players[name].runs,
                     players[name].wickets,
                     players[name].catches);
        end
    end
    endfunction

    initial begin
        handle_assoc_arr();
        handle_assoc_arr1();
        handle_players();
    end

endmodule