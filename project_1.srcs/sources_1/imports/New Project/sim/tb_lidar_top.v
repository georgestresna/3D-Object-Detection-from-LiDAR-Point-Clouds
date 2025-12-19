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

    // 100 MHz clock
    always #5 clk = ~clk;

    task send_point(input [15:0] px, input [15:0] py, input [15:0] pz);
        begin
            x = px;
            y = py;
            z = pz;
            valid = 1;
            #10;
        end
    endtask

    initial begin
        // init
        valid = 0;
        x = 0; y = 0; z = 0;
        #20;

        // ----------------------------
        // Ground points (ignored)
        // ----------------------------
        send_point(16'd100, 16'd100, 16'd50);
        send_point(16'd110, 16'd105, 16'd40);
        send_point(16'd120, 16'd110, 16'd60);

        // ----------------------------
        // Obstacle 1: small object
        // cluster around (200, 200)
        // ----------------------------
        send_point(16'd200, 16'd200, 16'd500);
        send_point(16'd202, 16'd198, 16'd520);
        send_point(16'd198, 16'd201, 16'd510);
        send_point(16'd201, 16'd203, 16'd530);

        // gap
        valid = 0;
        #20;

        // ----------------------------
        // Obstacle 2: large object
        // spread cluster around (400, 350)
        // ----------------------------
        send_point(16'd390, 16'd340, 16'd600);
        send_point(16'd395, 16'd345, 16'd620);
        send_point(16'd400, 16'd350, 16'd650);
        send_point(16'd405, 16'd355, 16'd630);
        send_point(16'd410, 16'd360, 16'd610);
        send_point(16'd415, 16'd365, 16'd640);
        send_point(16'd420, 16'd370, 16'd660);

        // end of frame
        valid = 0;
        #50;

        $finish;
    end

endmodule
