module tb;
    //declaration
    int D_arr[];
    int D_arr_n[];

    int sum, sum_n;

    int rand_index;
    int temp;

    //D_arr initialization
    initial begin
        //D_arr initialization
        D_arr = new[100];
        
        for(int i=0; i<100; i++) begin
            D_arr[i] = i;
        end
        //Displaying
        // for(int i=1; i<=100; i++) begin
        //     $write("%0d ", D_arr[i]);
        // end
        // $display("");
        // $finish;

        //D_arr_n initialization

        D_arr_n = new[150];

        for(int i=0; i<100; i++) begin
            D_arr_n[i] = D_arr[i]; //Copying 100 elements to D_arr_n
        end

        //Add the remaining elements
        for(int i=100; i<150; i++) begin
            D_arr_n[i] = i;
        end

        //Display sizes
        $display("Sum of D_arr   = %0d", sum);
        $display("Sum of D_arr_n = %0d", sum_n);

        //Picking random values
        rand_index = $urandom % 150;
        $display("Index = %0d, value = %0d", rand_index, D_arr_n[rand_index]);

        //Sum of all elements in both the arrays
        for(int i=0; i<D_arr.size(); i++) begin
            sum += D_arr[i];
        end

        for(int i=0; i<D_arr_n.size(); i++) begin
            sum_n += D_arr_n[i];
        end
        
        //Displaying sum 
        $display("Sum of D_arr_n = %0d", sum);
        $display("Sum of D_arr_n = %0d", sum_n);

        //Reverse D_arr_n
        
        // for(int i=0; i<D_arr_n.size(); i++) begin
        //     temp = D_arr_n[0];
        //     D_arr_n[0] = D_arr_n[D_arr_n.size()-1];
        //     D_arr_n[D_arr_n.size()-1] = temp;
        // end

        for (int i = 0; i < D_arr_n.size()/2; i++) begin
            temp = D_arr_n[i];
            D_arr_n[i] = D_arr_n[D_arr_n.size()-1-i];
            D_arr_n[D_arr_n.size()-1-i] = temp;
        end

        $display("Reverses Array");
        for(int i=0; i<D_arr_n.size(); i++) begin
            $write("%0d ", D_arr_n[i]);
        end
        $display("");

        //Delete all elements of D_arr
        D_arr.delete();
        $display("After delete, size of D_arr = %0d", D_arr.size());
        $finish;

    end


endmodule