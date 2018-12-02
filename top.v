module top(
           input clk,
           input rst_n,
           output [7:0] led,
           output lcd_rs,
           output lcd_rw,
           output lcd_clk,
           output [7:0] lcd_data
           );

   reg [16:0]    clkdiv;
   reg           clk_1mhz;

   always @ (negedge clk)
     begin
        if (clkdiv > 16'd12)
          begin
             clk_1mhz <= ~clk_1mhz;
             clkdiv <= 0;
          end
        else
          begin
             clkdiv <= clkdiv + 1;
          end
     end // always @ (negedge clk, negedge rst_n)

   hd44780 hd44780_ctrl (.clk(clk_1mhz),
                         .rst_n(rst_n),
                         .lcd_rs(lcd_rs),
                         .lcd_rw(lcd_rw),
                         .lcd_clk(lcd_clk),
                         .lcd_data(lcd_data));

   assign led = ~lcd_data;
endmodule
