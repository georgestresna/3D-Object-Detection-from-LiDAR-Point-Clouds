module tb_lidar_top;

    reg clk = 0;
    reg valid;
    reg [15:0] x, y, z;
    wire obstacle;

    lidar_top dut (
        .clk(clk),
        .valid(valid),
        .x(x),
        .y(y),
        .z(z),
        .obstacle(obstacle)
    );

    always #5 clk = ~clk;

    initial begin
        valid = 0;
        #20;

        valid = 1;
        x = 16'd100; y = 16'd200; z = 16'd100; // ground
        #10;

        x = 16'd120; y = 16'd210; z = 16'd500; // obstacle
        #10;

        x = 16'd130; y = 16'd220; z = 16'd600; // obstacle
        #10;

        valid = 0;
        #50;
        $finish;
    end
endmodule
