module ifu(
  input clk,
  input rst,
  input en,
  output regm [31:0]pc
);
  
  always@(posedge clk or posedge rst)
    begin
      if (rst)
          pc<=4'b0000;
      else if(en)
      begin
        pc<=pc+4;
      end
    end
endmodule

