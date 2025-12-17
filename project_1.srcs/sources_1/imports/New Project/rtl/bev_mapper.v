module bev_mapper (
    input  wire        clk,
    input  wire        valid_in,
    input  wire [15:0] x,
    input  wire [15:0] y,
    input  wire [15:0] z,
    output reg         valid_out,
    output reg  [7:0]  gx,
    output reg  [7:0]  gy
);

    parameter X_MIN = 16'd0;
    parameter Y_MIN = 16'd0;
    parameter RES   = 16'd10; // 0.1 m

    always @(posedge clk) begin
        valid_out <= valid_in;
        if (valid_in) begin
            gx <= (x - X_MIN) / RES;
            gy <= (y - Y_MIN) / RES;
        end
    end
endmodule
