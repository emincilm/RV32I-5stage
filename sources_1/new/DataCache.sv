`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 16:34:28
// Design Name: 
// Module Name: DataCache
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DataCache#(
    parameter  LINE_ADDR_LEN = 2,                               // line???????????line??2^LINE_ADDR_LEN?word
    parameter  SET_ADDR_LEN  = 3,                               // ????????????2^SET_ADDR_LEN?
    parameter  TAG_ADDR_LEN  = 12-LINE_ADDR_LEN-SET_ADDR_LEN,   // tag??
    parameter  WAY_CNT       = 2                                // ???????????????line
)(
    input             clk, rst,
    output            miss,         // ?CPU???miss??
    input      [31:0] addr,         // ??????
    input             rd_req,       // ?????
    output reg [31:0] rd_data,      // ???????????word
    input      [3: 0] wr_en,        // ?????, ??????byte
    input      [31:0] wr_data       // ????????????word
);

    // ????????MEM_ADDR_LEN?????=2^MEM_ADDR_LEN?line
    localparam MEM_ADDR_LEN    = TAG_ADDR_LEN + SET_ADDR_LEN; 
    // ???????????
    localparam UNUSED_ADDR_LEN = 32 - TAG_ADDR_LEN - SET_ADDR_LEN - LINE_ADDR_LEN - 2;       
    // ??line?word??????line?2^LINE_ADDR_LEN?word
    localparam LINE_SIZE       = 1 << LINE_ADDR_LEN;
    // ??????????2^SET_ADDR_LEN??         
    localparam SET_SIZE        = 1 << SET_ADDR_LEN;         

    // cache??
    reg  [               31:0]   cache_mem [SET_SIZE][WAY_CNT][LINE_SIZE]; //SET_SIZE?set, ??set?WAY_CNT?line???line?LINE_SIZE?word
    reg  [   TAG_ADDR_LEN-1:0]  cache_tags [SET_SIZE][WAY_CNT];            
    reg                              valid [SET_SIZE][WAY_CNT];            
    reg                              dirty [SET_SIZE][WAY_CNT];            
    reg  [               15:0]       count [SET_SIZE][WAY_CNT];            //??????????????           
    // ?????addr????5???
    wire [              2-1:0]   word_addr;                   
    wire [  LINE_ADDR_LEN-1:0]   line_addr;
    wire [   SET_ADDR_LEN-1:0]    set_addr;
    wire [   TAG_ADDR_LEN-1:0]    tag_addr;
    wire [UNUSED_ADDR_LEN-1:0] unused_addr;
    // ???????
    reg  [   SET_ADDR_LEN-1:0] mem_rd_set_addr = 0;
    reg  [   TAG_ADDR_LEN-1:0] mem_rd_tag_addr = 0;
    wire [   MEM_ADDR_LEN-1:0] mem_rd_addr = {mem_rd_tag_addr, mem_rd_set_addr};
    reg  [   MEM_ADDR_LEN-1:0] mem_wr_addr = 0;
    // ??????????(??line)
    reg  [               31:0] mem_wr_line [LINE_SIZE];
    wire [               31:0] mem_rd_line [LINE_SIZE];
    // ???????????
    wire  mem_gnt;    
    // ????????
    wire wr_req;

    // cache ????????
    // IDLE?????SWAP_OUT???????SWAP_IN???????SWAP_IN_OK?????????????cache???
    enum  {IDLE, SWAP_OUT, SWAP_IN, SWAP_IN_OK} cache_stat;   

    // ??32bits????
    assign {unused_addr, tag_addr, set_addr, line_addr, word_addr} = addr;  

    //??wr_en????1, ??????
    assign wr_req = |wr_en;

    // ?????address???cache???
    reg cache_hit = 1'b0;
    integer way = 0;    // ?????cache set?????way
    always @ (*) 
    begin
        // ?set???????
        for(way = 0; way < WAY_CNT; way++)
        begin
            // ??cache line?????tag???????tag??????              
            if(valid[set_addr][way] && cache_tags[set_addr][way] == tag_addr)
            begin
                cache_hit = 1'b1;
                break;
            end
            else
                cache_hit = 1'b0;
        end
    end

    integer swap_way = 0;    
    always @ (posedge clk or posedge rst) 
    begin
        if(rst) 
        begin
            cache_stat <= IDLE;
            for(integer i = 0; i < SET_SIZE; i++) 
            begin
                for(integer j = 0; j < WAY_CNT; j++)
                begin
                    dirty[i][j] = 1'b0;
                    valid[i][j] = 1'b0;
                    count[i][j] = 0;
                end
            end
            mem_wr_addr <= 0;
            for(integer k = 0; k < LINE_SIZE; k++)
                mem_wr_line[k] <= 0;
            {mem_rd_tag_addr, mem_rd_set_addr} <= 0;
            rd_data <= 0;
        end 
        else 
        begin
            case(cache_stat)
            IDLE: begin
                if(cache_hit) // ??cache??
                begin
                    if(rd_req) //???
                    begin
                        rd_data <= cache_mem[set_addr][way][line_addr];
                        //??valid??count????
                        for(integer i = 0; i < WAY_CNT; i++)
                            if(valid[set_addr][i])
                                count[set_addr][i] <= {1'b0, count[set_addr][i][15:1]};
                        count[set_addr][way][15] <= 1'b1;  //???, ????1
                    end 
                    else if(wr_req) //???
                    begin
                        // write data in bytes
                        if (wr_en[0])
                            cache_mem[set_addr][way][line_addr][7:0] <= wr_data[7:0];
                        if (wr_en[1])
                            cache_mem[set_addr][way][line_addr][15:8] <= wr_data[15:8];
                        if (wr_en[2])
                            cache_mem[set_addr][way][line_addr][23:16] <= wr_data[23:16];
                        if (wr_en[3])
                            cache_mem[set_addr][way][line_addr][31:24] <= wr_data[31:24];
                        
                        dirty[set_addr][way] <= 1'b1;               //???
                        //??valid??count????
                        for(integer i = 0; i < WAY_CNT; i++)
                            if(valid[set_addr][i])
                                count[set_addr][i] <= {1'b0, count[set_addr][i][15:1]};
                        count[set_addr][way][15] <= 1'b1;           //???, ????1
                    end 
                end 
                else // ??cache???
                begin
                    if(wr_req | rd_req) //?????????????
                    begin
                        // ??????????
                        for(swap_way = 0; swap_way < WAY_CNT; swap_way++)
                            // ???????????, ???????
                            if(!valid[set_addr][swap_way] || !dirty[set_addr][swap_way])             
                                break;
                        
                        if(swap_way < WAY_CNT) //????
                            cache_stat <= SWAP_IN;
                        else //???????????????way, ???LRU?????
                        begin
                            //??????????
                            automatic integer min = 16'hffff;
                            for(integer i = 0; i < WAY_CNT; i++)
                                if(valid[set_addr][i] && count[set_addr][i] <= min)
                                begin
                                    min = count[set_addr][i];
                                    swap_way = i;
                                end
                            cache_stat  <= SWAP_OUT;
                            mem_wr_addr <= {cache_tags[set_addr][swap_way], set_addr};
                            mem_wr_line <= cache_mem[set_addr][swap_way];
                        end 
                        // ?????
                        {mem_rd_tag_addr, mem_rd_set_addr} <= {tag_addr, set_addr};
                    end
                end
            end
            SWAP_OUT: begin
                if(mem_gnt)
                // ???????????????????????? 
                begin           
                    cache_stat <= SWAP_IN;
                end
            end
            SWAP_IN: begin
                if(mem_gnt) 
                // ????????????????????????
                begin           
                    cache_stat <= SWAP_IN_OK;
                end
            end
            SWAP_IN_OK: begin  
                // ???????????????????line??cache         
                for(integer i = 0; i < LINE_SIZE; i++)  
                    cache_mem[mem_rd_set_addr][swap_way][i] <= mem_rd_line[i];
                //???????
                cache_tags[mem_rd_set_addr][swap_way] <= mem_rd_tag_addr;       // ??tag
                valid     [mem_rd_set_addr][swap_way] <= 1'b1;                  // ?valid
                dirty     [mem_rd_set_addr][swap_way] <= 1'b0;                  // ??dirty
                count     [mem_rd_set_addr][swap_way] <= 16'h8000;              //???, ????1
                cache_stat                            <= IDLE;                  // ??????
                
                //??valid??count????
                for(integer i = 0; i < WAY_CNT; i++)
                    if(valid[mem_rd_set_addr][i])
                        count[mem_rd_set_addr][i] <= {1'b0, count[mem_rd_set_addr][i][15:1]};
            end
            endcase
        end
    end

    wire mem_rd_req = (cache_stat == SWAP_IN ); // ?????
    wire mem_wr_req = (cache_stat == SWAP_OUT); // ?????
    // ??????
    wire [MEM_ADDR_LEN-1 :0] mem_addr = mem_rd_req ? mem_rd_addr : ( mem_wr_req ? mem_wr_addr : 0);

    // ??????????cache?????(IDLE)??????????miss=1
    assign miss = (rd_req | wr_req) & ~(cache_hit && cache_stat==IDLE) ;     

    // ????????line ???
    main_mem #(     
        .LINE_ADDR_LEN  ( LINE_ADDR_LEN          ),
        .ADDR_LEN       ( MEM_ADDR_LEN           )
    ) main_mem_instance (
        .clk            ( clk                    ),
        .rst            ( rst                    ),
        .gnt            ( mem_gnt                ),
        .addr           ( mem_addr               ),
        .rd_req         ( mem_rd_req             ),
        .rd_line        ( mem_rd_line            ),
        .wr_req         ( mem_wr_req             ),
        .wr_line        ( mem_wr_line            )
    );
endmodule
