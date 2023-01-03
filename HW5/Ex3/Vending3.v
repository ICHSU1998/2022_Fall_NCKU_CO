`define PRODUCTNUM 2'd3
`define SET 2'b00
`define RUN 2'b01

module Vending(
    clk,
    rst,
    DI,
    MI,
    sel,
    re,
    MO,
    PO,
    empty
);
    input clk;
    input rst;
    input [7:0] DI;
    input [7:0] MI;
    input [1:0] sel;
    input       re;
    output reg [7:0] MO;
    output reg [1:0] PO;
    output reg       empty;

    reg [1:0] state;
    reg [1:0] nstate;
    reg [7:0] money;
    reg [2:0] counter;
    reg [7:0] prize [2:0];
    reg [2:0] quantity [2:0];
    reg [1:0] selection;
    reg [7:0] change;
    reg       refund;
    
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
            quantity[0] <= 3'd0;
            quantity[1] <= 3'd0;
            quantity[2] <= 3'd0;
            selection <= 2'd0;
            change <= 0;
        end
        else 
        begin
            state <= nstate;
            if (state == `SET)
            begin
                if (counter[0])
                begin
                    quantity[counter[2:1]] <= DI;
                end
                else 
                begin
                    prize[counter[2:1]] <= DI;
                end
                counter <= counter + 1;
                money <= money;
            end
            else if (state == `RUN)
            begin
                if (re || empty) 
                begin
                    refund <= 1;
                    money <= 0;
                    change <= money + MI;
                    selection <= 0;
                end
                else 
                begin
                    refund <= 0;
                    if (sel != 2'd0)
                    begin
                        if ((money + MI) >= prize[sel - 1] && quantity[sel - 1] > 3'd0)
                        begin
                            money <= 0;
                            change <= money + MI - prize[sel - 1];
                            selection <= sel;
                            quantity[sel - 1] <= quantity[sel - 1] - 1;
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
    end
    // Next State Logic
    always @(*)
    begin
        case (state)
            `SET:
            begin
                if (counter < (`PRODUCTNUM * 2 - 1))
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
                empty = 1'd0;
            end
            `RUN:
            begin
                if (empty || refund)
                begin
                    MO = change;
                    PO = 2'd0;
                end
                else 
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
                // Empty
                if (quantity[0] == 0 && quantity[1] == 0 && quantity[2] == 0) 
                begin
                    empty = 1'd1;
                end
                else 
                begin
                    empty = 1'd0;    
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