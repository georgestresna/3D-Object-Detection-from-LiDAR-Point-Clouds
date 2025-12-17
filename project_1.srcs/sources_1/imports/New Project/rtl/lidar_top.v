module lidar_top (
    input  wire        clk,
    input  wire        valid,
    input  wire [15:0] x,
    input  wire [15:0] y,
    input  wire [15:0] z,
    output wire        obstacle
);

    wire v1, v2;
    wire keep;
    wire [7:0] gx, gy;

    threshold_filter tf (
        .clk(clk),
        .valid_in(valid),
        .z(z),
        .valid_out(v1),
        .keep(keep)
    );

    bev_mapper bm (
        .clk(clk),
        .valid_in(v1),
        .x(x),
        .y(y),
        .z(z),
        .valid_out(v2),
        .gx(gx),
        .gy(gy)
    );

    occupancy_grid og (
        .clk(clk),
        .valid_in(v2),
        .keep(keep),
        .gx(gx),
        .gy(gy),
        .obstacle(obstacle)
    );

endmodule
