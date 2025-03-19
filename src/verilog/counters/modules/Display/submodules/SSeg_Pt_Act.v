module SSeg_Pt_Act ( input [1:0]pt, output wire act_pt,
                     input [1:0]dig );

        assign act_pt = (pt == dig) ;

endmodule
