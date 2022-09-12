module TinyALU (input [7:0] A,B ,
		input [2:0] OP_code,
		input clk , rst ,
		output reg done=0, start=0 ,
		output reg [15:0] result=0 );

reg flag=0, flag2= 0 , NOP = 0;

always@(negedge clk ,  posedge  rst ) begin
 if (rst ==1 ) begin
	result=0; 
	start =0;
	flag  =0;
	flag2 =0;
	done  =0;
	 end
 
 if(done == 1)begin
	done <=0;
	start = 0;
 	 end
	
 if (NOP== 1 & start == 0 ) begin
	start =1;
	 end
 else if (NOP== 1 & start ==1 ) begin
	NOP =0;
	start =0;
	 end

 if(flag == 1)begin
	flag <=0;
	start = 1;
	flag2 <=1;
	 end
 else if ( flag2 == 1 ) begin
	flag2 =0;
	 end

end


always @(OP_code , A , B)begin
 case (OP_code)
	3'b000: begin NOP <= 1 ; flag =0; $display (" **** NOP **** "); end
 	3'b001: flag <= 1 ; 
	3'b010: flag <= 1 ;
	3'b011: flag <= 1 ; 
	3'b100: flag <= 1 ;
	default : begin flag <= 0 ;
		 $display ("you entered wrong OP_code"); end
 endcase 

end



always @(negedge clk)begin
  if(flag2 == 1) begin

  case (OP_code)
	3'b000: begin result <= result ;  done <= 0 ; end 
	3'b001: begin done <= 1 ; result <= A + B ; end
	3'b010: begin done <= 1 ;result <= A & B ;end
	3'b011: begin done <= 1 ; result <= A ^ B ;end 
	3'b100: begin done <= 1 ; result <= A * B ; end
	default: done <= 0 ;
  endcase 

 end

end


endmodule
