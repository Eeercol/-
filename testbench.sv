`include "master.sv"
`include "slave.sv"

module testbench;

reg [0:0] PCLK;
reg [0:0] PRESET;
//reg [0:0] mready;

reg [0:0] PSEL;
reg [0:0] transfer;
reg [0:0] r;
reg [0:0] PWRITE;

reg [31:0] PADDR;
reg [31:0] PDATA;

wire [0:0] PENABLE;
wire [31:0] PRWDATA;
wire [31:0] PRWADDR;

wire [31:0] PRDATA1;
wire [0:0] PREADY;

master m (
    .PCLK(PCLK),
    .PRESET(PRESET),
    .PSEL(PSEL),
    .PREADY(PREADY),
    .transfer(transfer),
    .PWRITE(PWRITE),      
    .PADDR(PADDR),
    .PDATA(PDATA),

    .PENABLE(PENABLE),
    .PRWDATA(PRWDATA),
    .PRWADDR(PRWADDR)
);

slave s (
    .PCLK(PCLK),
    .PRESET(PRESET),
    .PSEL(PSEL),
    .PENABLE(PENABLE),
    .PWRITE(PWRITE),

    .PRWDATA(PRWDATA),  // master out, slave in data
    .PRWADDR(PRWADDR),  // master out, slava in addr

    .PRDATA1(PRDATA1),        // slave out data
    .PREADY(PREADY)        
);


// сначала делаем чтение в мастере,
// потом делаем передачу в слейв, где мы читаем память и изменяем
// в соответствии с заданием


initial begin

    $display("start");
    $dumpfile("testbench.vcd");
    $dumpvars(0,testbench);
    PADDR = 32'b00000000000000000000000000000000;
    PDATA = 32'h00000309;
    //out_data = 32'b00000000000000000000000000000000;
               //32'b00000000000000000000000000000000s
    //sin_data = 32'b10000000000000000000000000000011;

    PWRITE = 1'b1;
    
    PCLK = 1'b0;
    PRESET = 0;
    PSEL = 0;
    //enable = 0;
    transfer = 1'b1;
    //ready = 0;
    //mready = 1'b0;

    PRESET = 1;
    #10;
    $display("11");

    PRESET = 0;
    PSEL = 1;
    #10;
    $display("12");

    //enable = 1;
    #10;
    $display("13");

    //mready = 1;
    #10;
    $display("14");
    $display(PENABLE);
    $display(PSEL);
    $display(PREADY);
    $display(PRWDATA);
    $display(PRDATA1);



    //mready = 0;
    #10;
    $display("15");
    $display(PRDATA1);


    PSEL = 0;
    #10;
    $display("16");

    //enable = 0;
    #10;
    $display("17");

    // PRESET = 1;
    // #10;
    // $display("18");

    // PRESET = 0;
    // #10;
    // $display("19");

    PADDR = 32'b00000000000000000000000000000001;
    PDATA = 32'h014122023;
    PSEL = 1;
    #40;
    PSEL = 0;
    #20;

    PADDR = 32'b00000000000000000000000000000010;
    PDATA = 32'h534d4f4c;
    PSEL = 1;
    #40;
    PSEL = 0;
    #20;

    PADDR = 32'b0000000000000000000000000000011;
    PDATA = 32'h4956414e;
    PSEL = 1;
    #40;
    PSEL = 0;
    #20;




    $display("end");
    $finish;
end

always begin
    #5 PCLK = ~PCLK;
end

endmodule