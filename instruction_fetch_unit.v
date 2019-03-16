module pc(
  input clk,
  input rst,
  input en,
  output [31:0]inst_addr
);
  reg [31:0] temp;
  
  always@(posedge clk or posedge rst)
    begin
      if (rst)begin
          temp<=4'b0000;
        end
        else begin
        if(en)
      
        temp<=temp+'d4;
      end
    end

    assign inst_addr=temp >> 2;
endmodule



























/*module ifu(
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
endmodule*/

