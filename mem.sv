module memory_tb;
-
  logic [31:0] mem [0:255];

  // Semaphore — 1 key = only 1 task can access mem
  semaphore mem_lock;

  // Event — ensures READ happens AFTER WRITE

  event write_done;

  // Shared variables (write sets, read uses)
  logic [7:0]  shared_addr;
  logic [31:0] shared_data;

  // WRITE TASK
  task write_task();
    logic [7:0]  rand_addr;
    logic [31:0] rand_data;

    // Generate random address and data
    rand_addr = $urandom_range(0, 255);
    rand_data = $urandom();

    $display("[%0t] WRITE: Requesting memory lock...", $time);

    mem_lock.get(1);          // acquire semaphore (lock memory)

    $display("[%0t] WRITE: Lock acquired. Writing addr=0x%0h data=0x%0h",
              $time, rand_addr, rand_data);

    #5;                       // simulate write delay
    mem[rand_addr] = rand_data;

    // Store in shared variables so read_task can use them
    shared_addr = rand_addr;
    shared_data = rand_data;

    $display("[%0t] WRITE: Done. Releasing lock.", $time);

    mem_lock.put(1);          // release semaphore (unlock memory)

    -> write_done;            // signal that write is complete
  endtask

  // READ TASK
  task read_task();
    logic [7:0]  addr_to_read;
    logic [31:0] data_read;

    // Wait for write to finish before attempting read
    @(write_done);

    $display("[%0t] READ:  Requesting memory lock...", $time);

    mem_lock.get(1);          // acquire semaphore (lock memory)

    addr_to_read = shared_addr;   // use same addr written by write_task

    $display("[%0t] READ:  Lock acquired. Reading addr=0x%0h",
              $time, addr_to_read);

    #3;                       // simulate read delay
    data_read = mem[addr_to_read];

    $display("[%0t] READ:  Data read = 0x%0h", $time, data_read);

    // Verify correctness
    if (data_read === shared_data)
      $display("[%0t] READ:  PASS — data matches written value 0x%0h",
                $time, shared_data);
    else
      $display("[%0t] READ:  FAIL — expected 0x%0h got 0x%0h",
                $time, shared_data, data_read);

    $display("[%0t] READ:  Done. Releasing lock.", $time);

    mem_lock.put(1);          // release semaphore (unlock memory)
  endtask

  //Run write and read in parallel
  initial begin
    // Initialize semaphore with 1 key
    mem_lock = new(1);

    $display("Memory R/W Simulation Start");

    // Run multiple iterations
    repeat(3) begin
      fork
        write_task();   // runs in parallel
        read_task();    // waits internally for write_done event
      join              // wait for both to complete before next iteration

      #10;              // gap between iteration
    end
    $finish;
  end

endmodule