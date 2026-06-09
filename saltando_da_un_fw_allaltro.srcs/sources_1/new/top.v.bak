`timescale 1ns / 1ps

module IcapConfigSequencer (
    // Clock and Reset
    input flash_clk,           // Clock for the counter (e.g., system clock)
    input rst,                 // Synchronous Reset

    // External Control
    input go, // Go command trigger (compared to 256)

    // ICAP Interface (Output)
    output [15:0] icap_out     // ICAP Data Output (Readback data)
);

	
	wire [31:0] icap_out_i;
	
    // ===========================================================================
    // Clock Divider Logic
    // ===========================================================================
    wire flash_clk_div;
    reg [7:0] flash_clk_div_count;

    // Counter incremented on the rising edge of the main clock
    always@(posedge flash_clk) begin
        if (rst) begin
            flash_clk_div_count <= 8'h00;
        end else begin
            // Non-blocking assignment for sequential logic
            flash_clk_div_count <= flash_clk_div_count + 1;
        end
    end

    // Clock division by 256. The frequency of flash_clk_div is flash_clk / 256.
    // Must be less than 100 MHz or 70 MHz depending on the speed grade.
    // The reconfig can be slow. Per DS181 pg 59
    assign flash_clk_div = flash_clk_div_count[7];

    // ===========================================================================
    // ICAP State Machine and Data Registers
    // ===========================================================================
    // remote configuration AND setting of next boot address WBSTAR)
    // icap_out: Connesso all'output O del blocco ICAPE2.
    // icap_in: Registro per i dati inviati al blocco ICAPE2 (nel dominio di flash_clk_div)
    reg [31:0] icap_in;
    wire [31:0] icap_in_swap;
    
    // Control wires for ICAPE2 primitive
    wire CSIB;
    wire RDWRB;
    reg [7:0] icap_state;

    // FSM clocked by the divided flash clock
    always@(posedge flash_clk_div) begin
        if (rst) begin
            icap_state <= 8'h00;
            icap_in <= 32'hFFFFFFFF; // Default fill word
        end else begin
            // note,we need to bitswap the data bytes
            case (icap_state[7:0])
                8'h00 : begin // watch for go command
                    if (go == 1'b1) begin 
                        icap_state <= 8'h01;
                        icap_in <= 32'hFFFFFFFF;
                    end else begin
                        icap_state <= 8'h00;
                        icap_in <= 32'hFFFFFFFF;
                    end
                end 
                8'h01 : begin // sync word (Part 1)
                    icap_in <= 32'hFFFFFFFF;
                    icap_state <= 8'h02;  
                end 
                8'h02 : begin // sync word (Part 2)
                    icap_in <= 32'hAA995566;
                    icap_state <= 8'h03;  
                end 
                8'h03 : begin // type 1 NO OP instruction
                    icap_in <= 32'h20000000;
                    icap_state <= 8'h04;  
                end 
                8'h04 : begin // type 1 write 1 WBSTAR instruction
                    icap_in <= 32'h30020001;
                    icap_state <= 8'h05;  
                end 
                8'h05 : begin // WBSTAR register value (0x00000000 for primary boot)
                    icap_in <= 32'h00000000;
                    icap_state <= 8'h06;    
                end    
                8'h06 : begin // type 1 write 1 words to CMD register
                    icap_in <= 32'h30008001;
                    icap_state <= 8'h07;    
                end    
                8'h07 : begin // IPROG Command (starts the reconfiguration)
                    icap_in <= 32'h0000000F;
                    icap_state <= 8'h08;    
                end    
                8'h08 : begin // Type 1 No Op instruction (Fill word for safe exit)
                    icap_in <= 32'h20000000;
                    icap_state <= 8'h09;    
                end    
                default: begin
                    icap_in <= 32'hFFFFFFFF;
                    icap_state <= 8'h00; // Return to IDLE state
                end
            endcase
        end
    end

    // ===========================================================================
    // ICAP Control Signals
    // ===========================================================================
    // The ICAP primitive should be active when the state machine is running (icap_state > 0).
    // The state 8'h00 is the idle state. CSIB and RDWRB are typically active low.
    assign CSIB  = (icap_state==8'h00) ? 1'b1 : 1'b0; // Active low Enable (Asserted when state is not IDLE)
    assign RDWRB = (icap_state==8'h00) ? 1'b1 : 1'b0; // Active low Write Enable (Asserted when state is not IDLE - performing a write operation)

    // ===========================================================================
    // Bit Swap Logic
    // ===========================================================================
    // Bit swap per byte per Xilinx UG470 pg 77, required for serial configuration data
    assign icap_in_swap[31:24] = {icap_in[24], icap_in[25], icap_in[26], icap_in[27], icap_in[28], icap_in[29], icap_in[30], icap_in[31]};
    assign icap_in_swap[23:16] = {icap_in[16], icap_in[17], icap_in[18], icap_in[19], icap_in[20], icap_in[21], icap_in[22], icap_in[23]};
    assign icap_in_swap[15:8]  = {icap_in[8],  icap_in[9],  icap_in[10], icap_in[11], icap_in[12], icap_in[13], icap_in[14], icap_in[15]};
    assign icap_in_swap[7:0]   = {icap_in[0],  icap_in[1],  icap_in[2],  icap_in[3],  icap_in[4],  icap_in[5],  icap_in[6],  icap_in[7]};

    // ===========================================================================
    // ICAPE2 Primitive Instantiation
    // ===========================================================================
    // ICAP for 7 Series FPGAs
    ICAPE2 #(
      .DEVICE_ID(32'h3651093),    // Specifies the pre-programmed Device ID value to be used for simulation.
      .ICAP_WIDTH("X32"),         // Specifies the input and output data width (32-bit).
      .SIM_CFG_FILE_NAME("NONE")  // Specifies the Raw Bitstream (RBT) file for simulation.
    )
    ICAPE2_inst (
      .O(icap_out_i),         // 32-bit output: Configuration data output bus (connected to the module output)
      .CLK(flash_clk_div),  // 1-bit input: Clock Input (the divided clock)
      .CSIB(CSIB),          // 1-bit input: Active-Low ICAP Enable
      .I(icap_in_swap),     // 32-bit input: Configuration data input bus (bit-swapped data)
      .RDWRB(RDWRB)         // 1-bit input: Read/Write Select input (Active-Low Write)
    );


	assign icap_out =icap_out_i[15:0];
endmodule