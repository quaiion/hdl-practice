module Act_Pt ( input [1:0] pt, output wire act_pt,
               input [1:0] adr_dig );

        assign act_pt = (pt == adr_dig) ;

endmodule
