module mux_2_1
(
  input  [3:0] d0, d1,
  input        sel,
  output [3:0] y
);
  assign y = sel ? d1 : d0;
endmodule
//----------------------------------------------------------------------------
module mux_4_1
(
  input  [3:0] d0, d1, d2, d3,
  input  [1:0] sel,
  output [3:0] y
);
wire [3:0] y0;
wire [3:0] y1;
wire [3:0] y2;

// instantiating similar module                                             
mux_2_1 inst_0 (.d0 (d0), .d1(d1),.y(y0 [3:0]), .sel()),   
        inst_1 (.d0 (d2), .d1(d3),.y(y1[3:0]), .sel()),                           
        inst_2 (.d0 (y0 [3:0]), .d1(y1 [3:0]),.y(y2 [3:0]), .sel());                             

      assign y = y2 [3:0];


//by sisa how to manage sel for 



  // Implement mux_4_1 using three instances of mux_2_1
endmodule
//----------------------------------------------------------------------------
module testbench;
  logic [3:0] d0, d1, d2, d3;
  logic [1:0] sel;
  logic [3:0] y;
  mux_4_1 inst
  (
    .d0  (d0), .d1 (d1), .d2 (d2), .d3 (d3),
    .sel (sel),
    .y   (y)
  );
  task test
    (
      input [3:0] td0, td1, td2, td3,
      input [1:0] tsel,
      input [3:0] ty
    );
    { d0, d1, d2, d3, sel } = { td0, td1, td2, td3, tsel };
    # 1;
    $display ("TEST d { %h %h %h %h } sel %d y %h",
        d0, d1, d2, d3, sel, y);
    if (y !== ty)
      begin
        $display ("%s FAIL: %h EXPECTED", `__FILE__, ty);
        $finish;
      end
  endtask
  initial
    begin
      test ('ha, 'hb, 'hc, 'hd, 0, 'ha);
      test ('ha, 'hb, 'hc, 'hd, 1, 'hb);
      test ('ha, 'hb, 'hc, 'hd, 2, 'hc);
      test ('ha, 'hb, 'hc, 'hd, 3, 'hd);
      test (7, 10, 3, 'x, 0, 7);
      test (7, 10, 3, 'x, 1, 10);
      test (7, 10, 3, 'x, 2, 3);
      test (7, 10, 3, 'x, 3, 'x);
      $display ("%s PASS", `__FILE__);
      $finish;
    end
endmodule
