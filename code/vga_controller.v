module vga_controller(iRST_n,
                      iVGA_CLK,
                      oBLANK_n,
                      oHS,
                      oVS,
                      b_data,
                      g_data,
                      r_data,
							 left,
							 right,
							 up,
							 down);

	
	
	
input up,down,
							 left,
							 right	;
	
	
input iRST_n;
input iVGA_CLK;
output reg oBLANK_n;
output reg oHS;
output reg oVS;
output [7:0] b_data;
output [7:0] g_data;  
output [7:0] r_data;                        
///////// ////                     
reg [18:0] ADDR;
reg [23:0] bgr_data;
wire VGA_CLK_n;
wire [7:0] index;
wire [23:0] bgr_data_raw;
wire cBLANK_n,cHS,cVS,rst;
////
assign rst = ~iRST_n;
video_sync_generator LTM_ins (.vga_clk(iVGA_CLK),
                              .reset(rst),
                              .blank_n(cBLANK_n),
                              .HS(cHS),
                              .VS(cVS));
////
////Addresss generator
always@(posedge iVGA_CLK,negedge iRST_n)
begin
  if (!iRST_n)
     ADDR<=19'd0;
  else if (cHS==1'b0 && cVS==1'b0)
     ADDR<=19'd0;
  else if (cBLANK_n==1'b1)
     ADDR<=ADDR+1;
end
//////////////////////////
//////INDEX addr.
assign VGA_CLK_n = ~iVGA_CLK;
img_data	img_data_inst (
	.address ( ADDR ),
	.clock ( VGA_CLK_n ),
	.q ( index )
	);
	
/////////////////////////
//////Add switch-input logic here
	
//////Color table output
img_index	img_index_inst (
	.address ( index ),
	.clock ( iVGA_CLK ),
	.q ( bgr_data_raw)
	);	
//////
//////latch valid data at falling edge;
wire[31:0]  pic1, pic2;

reg [31:0] pos1, pos2;

initial begin
pos1 <= 200;
pos2 <= 200;
end


reg[23:0] counter;


always@(negedge VGA_CLK_n) begin
if(counter< 23'd40000)
 counter <= counter + 1;
 else begin
 counter <= 24'd0;
 
 if(~up) pos2 <= pos2-1;
 if(~down) pos2 <= pos2+1; 
  if(~right) pos1 <= pos1+1;
 if(~left) pos1 <= pos1-1; 
 end


end



assign pic1 = ADDR / 32'd640;
assign pic2 = ADDR % 32'd640;


wire is_pac;

pac_fig pac_fig_ins(pos1, pos2, pic1, pic2, is_pac,~up,~left,~down, ~right);

wire tur; 
//assign tur = ((pic1-pos1) < 100) & ((pic1-pos1) > (-1*100)) & ((pic2-pos2) < 100) & ((pic2-pos2) >  (-1*100));

assign tur = ((pic1-pos1) * (pic1-pos1) + (pic2-pos2) * (pic2-pos2)) < 10000;

wire[23:0] color_to_show; 
assign color_to_show = is_pac? 24'b111111111111111100000000 : bgr_data_raw;

//assign color_to_show = tur? 24'b111111111111111100000000 : bgr_data_raw;



always@(posedge VGA_CLK_n) bgr_data <= color_to_show;





assign b_data = bgr_data[23:16];
assign g_data = bgr_data[15:8];
assign r_data = bgr_data[7:0]; 
///////////////////
//////Delay the iHD, iVD,iDEN for one clock cycle;
always@(negedge iVGA_CLK)
begin
  oHS<=cHS;
  oVS<=cVS;
  oBLANK_n<=cBLANK_n;
end

endmodule
 	















