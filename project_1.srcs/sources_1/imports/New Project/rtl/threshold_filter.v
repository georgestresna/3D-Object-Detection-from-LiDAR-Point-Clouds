module threshold_filter (
    input  wire        clk,
    input  wire        valid_in,
    input  wire [15:0] z,
    output reg         valid_out,
    output reg         keep
);

    parameter Z_THRESH = 16'd300; // 0.3 m

    always @(posedge clk) begin
        valid_out <= valid_in;
        keep <= (z > Z_THRESH);
    end
endmodule
