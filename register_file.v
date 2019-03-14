module register_file(
input clk,
input [4:0]rs1,
input [4:0]rs2,
input [4:0]rd,
input rs1_rd_en,
input rs2_rd_en,
input rd_wd_en,
input[31:0]rD,
output wire [31:0]rS1,
output wire [31:0]rS2
);

reg[31:0] memory [31:0];

initial
begin
memory[0]=32'b0;
memory[1]=32'b1;
memory[2]=32'b10;
memory[3]=32'b11;
memory[4]=32'b100;
memory[5]=32'b101;
memory[6]=32'b110;
memory[7]=32'b111;
memory[8]=32'b1000;
memory[9]=32'b1001;
memory[10]=32'b1010;
memory[11]=32'b1011;
memory[12]=32'b1100;
memory[13]=32'b1101;
memory[14]=32'b1110;
memory[15]=32'b1111;
memory[16]=32'b10000;
memory[17]=32'b10001;
memory[18]=32'b10010;
memory[19]=32'b10011;
memory[20]=32'b10100;
memory[21]=32'b10101;
memory[22]=32'b10110;
memory[23]=32'b10111;
memory[24]=32'b11000;
memory[25]=32'b11001;
memory[26]=32'b11010;
memory[27]=32'b11011;
memory[28]=32'b11100;
memory[29]=32'b11101;
memory[30]=32'b11110;
memory[31]=32'b11111;
memory[32]=32'b100000;



end

/*initial begin
  $readmemh("mem.hex" ,memory);
end
*/
always@(posedge clk)
begin
if(rd_wd_en)
memory[rd]<=rD;
end

assign rS1=rs1_rd_en ? memory[rs1]:32'b0;
assign rS2=rs2_rd_en ? memory[rs2]:32'b0;

endmodule
