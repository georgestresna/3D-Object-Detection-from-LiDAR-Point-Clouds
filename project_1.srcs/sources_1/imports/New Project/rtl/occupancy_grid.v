module occupancy_grid (
    input  wire        clk,
    input  wire        valid_in,
    input  wire        keep,
    input  wire [7:0]  gx,
    input  wire [7:0]  gy,
    output reg         obstacle
);

    reg grid [0:255][0:255];

    always @(posedge clk) begin
        obstacle <= 1'b0;
        if (valid_in && keep) begin
            grid[gx][gy] <= 1'b1;
            obstacle <= 1'b1;
        end
    end
endmodule
