//-------------------------------------------------------------------
//
//  COPYRIGHT (C) 2023, devin
//  balddonkey@outlook.com
//
//-------------------------------------------------------------------
// Title       : rv_dpram.V
// Author      : Devin
// Editor      : VIM
// Created     :
// Description : Dual ports block memory model.
//
// $Id$
//-------------------------------------------------------------------

`timescale 1ns / 1ps

module rv_dpram #(
    parameter WIDTH = 32,
    parameter DEPTH = 1024
) (
    input                           clk,
    input                           wena,   // write port
    input       [clog2(DEPTH)-1:0]  addra,
    input       [WIDTH-1:0]         dina,
    input                           renb,   // read port
    input       [clog2(DEPTH)-1:0]  addrb,
    output  reg [WIDTH-1:0]         doutb
);


//------------------------ SIGNALS ------------------------//

reg [WIDTH-1:0] BRAM [DEPTH-1:0];

//------------------------ PROCESS ------------------------//

always @(posedge clk) begin
    if(wena) begin
        BRAM[addra] <= dina;
    end
    if(renb) begin
        doutb <= BRAM[addrb];
    end
end

//------------------------ INST ------------------------//

function    integer clog2;
    input   integer depth;
    begin
        depth = depth-1;
        for(clog2=0; depth>0; clog2=clog2+1) begin
            depth = depth >> 1;
        end
    end
endfunction

endmodule