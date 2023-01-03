`define PRODUCTNUM 2'd3
`define SET 2'b00
`define RUN 2'b01

module Vending(
    clk,
    rst,
    DI,
    MI,
    sel,
    MO,
    PO
);
    input clk;
    input rst;
    input [7:0] DI;
    input [7:0] MI;
    input [1:0] sel;
    output reg [7:0] MO;
    output reg [1:0] PO;

    reg [1:0] state;
    reg [1:0] nstate;
    reg [7:0] money;
    reg [1:0] counter;
    reg [7:0] prize [2:0];
    reg [1:0] selection;
    reg [7:0] change;
    
    // State Register
    always @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            state <= `SET;
            money <= 8'd0;
            counter <= 2'd0;
            prize[0] <= 8'd0;
            prize[1] <= 8'd0;
            prize[2] <= 8'd0;
            selection <= 2'd0;
            change <= 0;
        end
        else 
        begin
            state <= nstate;
            if (state == `SET)
            begin
                prize[counter] <= DI;
                counter <= counter + 1;
                money <= money;
            end
            else if (state == `RUN)
            begin
                if (sel != 2'd0)
                begin
                    if ((money + MI) >= prize[sel - 1])
                    begin
                        money <= 0;
                        change <= money + MI - prize[sel - 1];
                        selection <= sel;
                    end
                    else 
                    begin
                        money <= money + MI;
                        change <= 0;
                        selection <= 0;
                    end
                end
                else 
                begin
                    money <= money + MI;
                    change <= 0;
                    selection <= 0;
                end
            end
        end
    end
    // Next State Logic
    always @(*)
    begin
        case (state)
            `SET:
            begin
                if (counter < (`PRODUCTNUM - 1))
                begin
                    nstate = `SET;
                end
                else 
                begin
                    nstate = `RUN;
                end
            end
            `RUN:
            begin
                nstate = `RUN;
            end
            default: 
            begin
                nstate = `SET;
            end
        endcase
    end
    // Output Logic
    always @(*)
    begin
        case (state)
            `SET:
            begin
                MO = 8'd0;
                PO = 2'd0;
            end
            `RUN:
            begin
                if (selection != 0)
                begin
                    MO = change;
                    PO = selection;
                end
                else 
                begin
                    MO = 8'd0;
                    PO = 2'd0;
                end
            end
            default: 
            begin
                MO = 8'd0;
                PO = 2'd0;
            end
        endcase
    end
endmodule