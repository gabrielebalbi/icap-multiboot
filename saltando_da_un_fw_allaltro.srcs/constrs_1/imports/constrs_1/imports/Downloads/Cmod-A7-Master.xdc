## This file is a general .xdc for the CmodA7 rev. B
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project


set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]


## 12 MHz Clock Signal
set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS33} [get_ports flash_clk]
create_clock -period 83.330 -name sys_clk_pin -waveform {0.000 41.660} -add [get_ports flash_clk]

## LEDs
#set_property -dict {PACKAGE_PIN A17 IOSTANDARD LVCMOS33} [get_ports {led_2bits_tri_io[0]}]
#set_property -dict {PACKAGE_PIN C16 IOSTANDARD LVCMOS33} [get_ports {led_2bits_tri_io[1]}]

## RGB LED
#set_property -dict {PACKAGE_PIN B17 IOSTANDARD LVCMOS33} [get_ports {rgb_led_tri_io[0]}]
#set_property -dict {PACKAGE_PIN B16 IOSTANDARD LVCMOS33} [get_ports {rgb_led_tri_io[1]}]
#set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS33} [get_ports {rgb_led_tri_io[2]}]

## Buttons
set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports rst]
set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports go]

## Pmod Header JA
## Pmod Header JA
#set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports {spi_bus_ss_io[0]}]
#set_property -dict {PACKAGE_PIN G19 IOSTANDARD LVCMOS33} [get_ports spi_bus_io0_io] ; # MOSI
#set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports spi_bus_io1_io] ; # MISO
#set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports spi_bus_sck_io]
#set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { ja[3] }]; #IO_L8P_T1_D11_14 Sch=ja[4]
#set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { ja[4] }]; #IO_L5P_T0_D06_14 Sch=ja[7]
#set_property -dict { PACKAGE_PIN H19   IOSTANDARD LVCMOS33 } [get_ports { ja[5] }]; #IO_L4P_T0_D04_14 Sch=ja[8]
#set_property -dict { PACKAGE_PIN J19   IOSTANDARD LVCMOS33 } [get_ports { ja[6] }]; #IO_L6N_T0_D08_VREF_14 Sch=ja[9]
#set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { ja[7] }]; #IO_L8N_T1_D12_14 Sch=ja[10]



## Analog XADC Pins
## Only declare these if you want to use pins 15 and 16 as single ended analog inputs. pin 15 -> vaux4, pin16 -> vaux12
#set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports Vaux4_0_v_n]
#set_property -dict {PACKAGE_PIN G3 IOSTANDARD LVCMOS33} [get_ports Vaux4_0_v_p]
#set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports Vaux12_0_v_n]
#set_property -dict {PACKAGE_PIN H2 IOSTANDARD LVCMOS33} [get_ports Vaux12_0_v_p]

## GPIO Pins
## Pins 15 and 16 should remain commented if using them as analog inputs
set_property -dict {PACKAGE_PIN M3 IOSTANDARD LVCMOS33} [get_ports {icap_out[0]}]
set_property -dict {PACKAGE_PIN L3 IOSTANDARD LVCMOS33} [get_ports {icap_out[1]}]
set_property -dict {PACKAGE_PIN A16 IOSTANDARD LVCMOS33} [get_ports {icap_out[2]}]
set_property -dict {PACKAGE_PIN K3 IOSTANDARD LVCMOS33} [get_ports {icap_out[3]}]
set_property -dict {PACKAGE_PIN C15 IOSTANDARD LVCMOS33} [get_ports {icap_out[4]}]
set_property -dict {PACKAGE_PIN H1 IOSTANDARD LVCMOS33} [get_ports {icap_out[5]}]
set_property -dict {PACKAGE_PIN A15 IOSTANDARD LVCMOS33} [get_ports {icap_out[6]}]
set_property -dict {PACKAGE_PIN B15 IOSTANDARD LVCMOS33} [get_ports {icap_out[7]}]
set_property -dict {PACKAGE_PIN A14 IOSTANDARD LVCMOS33} [get_ports {icap_out[8]}]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {icap_out[9]}]
set_property -dict {PACKAGE_PIN J1 IOSTANDARD LVCMOS33} [get_ports {icap_out[10]}]
set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports {icap_out[11]}]
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports {icap_out[12]}]
set_property -dict {PACKAGE_PIN L2 IOSTANDARD LVCMOS33} [get_ports {icap_out[13]}]
set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVCMOS33} [get_ports {icap_out[14]}]
set_property -dict {PACKAGE_PIN N3 IOSTANDARD LVCMOS33} [get_ports {icap_out[15]}]

#set_property -dict { PACKAGE_PIN P3    IOSTANDARD LVCMOS33 } [get_ports { pio19 }]; #IO_L12N_T1_MRCC_35 Sch=pio[19]
#set_property -dict { PACKAGE_PIN M2    IOSTANDARD LVCMOS33 } [get_ports { pio20 }]; #IO_L9P_T1_DQS_AD7P_35 Sch=pio[20]
#set_property -dict { PACKAGE_PIN N1    IOSTANDARD LVCMOS33 } [get_ports { pio21 }]; #IO_L10N_T1_AD15N_35 Sch=pio[21]
########set_property -dict { PACKAGE_PIN N2    IOSTANDARD LVCMOS33 } [get_ports { pio22 }]; #IO_L10P_T1_AD15P_35 Sch=pio[22]
########set_property -dict { PACKAGE_PIN P1    IOSTANDARD LVCMOS33 } [get_ports { pio23 }]; #IO_L19N_T3_VREF_35 Sch=pio[23]
#set_property -dict { PACKAGE_PIN R3    IOSTANDARD LVCMOS33 } [get_ports { pio26 }]; #IO_L2P_T0_34 Sch=pio[26]
#set_property -dict { PACKAGE_PIN T3    IOSTANDARD LVCMOS33 } [get_ports { pio27 }]; #IO_L2N_T0_34 Sch=pio[27]
#set_property -dict { PACKAGE_PIN R2    IOSTANDARD LVCMOS33 } [get_ports { pio28 }]; #IO_L1P_T0_34 Sch=pio[28]
#set_property -dict { PACKAGE_PIN T1    IOSTANDARD LVCMOS33 } [get_ports { pio29 }]; #IO_L3P_T0_DQS_34 Sch=pio[29]
#set_property -dict { PACKAGE_PIN T2    IOSTANDARD LVCMOS33 } [get_ports { pio30 }]; #IO_L1N_T0_34 Sch=pio[30]
#set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33 } [get_ports { pio31 }]; #IO_L3N_T0_DQS_34 Sch=pio[31]
#set_property -dict { PACKAGE_PIN W2    IOSTANDARD LVCMOS33 } [get_ports { pio32 }]; #IO_L5N_T0_34 Sch=pio[32]
#set_property -dict { PACKAGE_PIN V2    IOSTANDARD LVCMOS33 } [get_ports { pio33 }]; #IO_L5P_T0_34 Sch=pio[33]
#set_property -dict { PACKAGE_PIN W3    IOSTANDARD LVCMOS33 } [get_ports { pio34 }]; #IO_L6N_T0_VREF_34 Sch=pio[34]
#set_property -dict { PACKAGE_PIN V3    IOSTANDARD LVCMOS33 } [get_ports { pio35 }]; #IO_L6P_T0_34 Sch=pio[35]
#set_property -dict { PACKAGE_PIN W5    IOSTANDARD LVCMOS33 } [get_ports { pio36 }]; #IO_L12P_T1_MRCC_34 Sch=pio[36]
#set_property -dict { PACKAGE_PIN V4    IOSTANDARD LVCMOS33 } [get_ports { pio37 }]; #IO_L11N_T1_SRCC_34 Sch=pio[37]

#set_property -dict { PACKAGE_PIN U4    IOSTANDARD LVCMOS33 } [get_ports { pio38 }]; #IO_L11P_T1_SRCC_34 Sch=pio[38]

#set_property -dict {PACKAGE_PIN V5 IOSTANDARD LVCMOS33} [get_ports Ext_trigger]

#set_property -dict {PACKAGE_PIN W4 IOSTANDARD LVCMOS33} [get_ports {gpio_io_o_0[0]}]
#set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports {gpio_io_o_0[1]}]
#set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {gpio_io_o_0[2]}]
#set_property -dict {PACKAGE_PIN W6 IOSTANDARD LVCMOS33} [get_ports {gpio_io_o_0[3]}]
#


########################################################################
## PWMs outputs

##set_property -dict {PACKAGE_PIN U3 IOSTANDARD LVCMOS33} [get_ports pwm_general]

#set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports pwm_motor1_n]
#set_property -dict {PACKAGE_PIN W7 IOSTANDARD LVCMOS33} [get_ports pwm_motor1_p]
#set_property -dict {PACKAGE_PIN U8 IOSTANDARD LVCMOS33} [get_ports pwm_motor2_n]
#set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVCMOS33} [get_ports pwm_motor2_p]

## END PWMs outputs
########################################################################



## UART
#set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports usb_uart_txd]
#set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports usb_uart_rxd]

## Crypto 1 Wire Interface
#set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports { crypto_sda }]; #IO_0_14 Sch=crypto_sda

## QSPI
#set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports { qspi_cs    }]; #IO_L6P_T0_FCS_B_14 Sch=qspi_cs
#set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[0] }]; #IO_L1P_T0_D00_MOSI_14 Sch=qspi_dq[0]
#set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[1] }]; #IO_L1N_T0_D01_DIN_14 Sch=qspi_dq[1]
#set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[2] }]; #IO_L2P_T0_D02_14 Sch=qspi_dq[2]
#set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[3] }]; #IO_L2N_T0_D03_14 Sch=qspi_dq[3]

## Cellular RAM
#set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[0]}]
#set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[1]}]
#set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[2]}]
#set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[3]}]
#set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[4]}]
#set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[5]}]
#set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[6]}]
#set_property -dict {PACKAGE_PIN W19 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[7]}]
#set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[8]}]
#set_property -dict {PACKAGE_PIN V19 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[9]}]
#set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[10]}]
#set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[11]}]
#set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[12]}]
#set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[13]}]
#set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[14]}]
#set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[15]}]
#set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[16]}]
#set_property -dict {PACKAGE_PIN W17 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[17]}]
#set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_addr[18]}]
#set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_dq_io[0]}]
#set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_dq_io[1]}]
#set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_dq_io[2]}]
#set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_dq_io[3]}]
#set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_dq_io[4]}]
#set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_dq_io[5]}]
#set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_dq_io[6]}]
#set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {cellular_ram_dq_io[7]}]
#set_property -dict {PACKAGE_PIN P19 IOSTANDARD LVCMOS33} [get_ports cellular_ram_oen]
#set_property -dict {PACKAGE_PIN R19 IOSTANDARD LVCMOS33} [get_ports cellular_ram_wen]
#set_property -dict {PACKAGE_PIN N19 IOSTANDARD LVCMOS33} [get_ports cellular_ram_ce_n]



###################################################################################################
## OUTPUT CLOCKs

# I banchi HR alimentati a 3.3V non ammettono uscite LVDS_25. SOLO INPUT!
## set_property -dict { PACKAGE_PIN P3    IOSTANDARD LVCMOS33 } [get_ports { clk_out1_0_n }]; #IO_L12N_T1_MRCC_35 Sch=pio[19]
## set_property -dict {PACKAGE_PIN B15 IOSTANDARD LVCMOS33} [clk_out2_0_n}]

#set_property PACKAGE_PIN N3 [get_ports clk_out1_0]
#set_property IOSTANDARD LVCMOS33 [get_ports clk_out1_0]
#set_property PACKAGE_PIN C15 [get_ports clk_out2_0]
#set_property IOSTANDARD LVCMOS33 [get_ports clk_out2_0]


#set_property -dict {PACKAGE_PIN N3 IOSTANDARD LVCMOS33} [get_ports {clk_out1_0}]
#create_clock -period 25.000 -name oclk_pin1 -waveform {0.000 12.500} -add [get_ports clk_out1_0]

#set_property -dict {PACKAGE_PIN C15 IOSTANDARD LVCMOS33} [get_ports {clk_out2_0}]
#create_clock -period 25.000 -name oclk_pin2 -waveform {0.000 12.500} -add [get_ports clk_out2_0]




## END OUTPUT CLOCKs
###################################################################################################

###################################################################################################
## I2C interface

#set_property -dict {PACKAGE_PIN N2 IOSTANDARD LVCMOS33} [get_ports iic_rtl_scl_io]
#set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS33} [get_ports iic_rtl_sda_io]
#
#
#set_property PULLUP true [get_ports iic_rtl_scl_io]
#set_property PULLUP true [get_ports iic_rtl_sda_io]

###################################################################################################



create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list flash_clk_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 11 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {icap_in[0]} {icap_in[1]} {icap_in[3]} {icap_in[15]} {icap_in[17]} {icap_in[18]} {icap_in[19]} {icap_in[24]} {icap_in[25]} {icap_in[28]} {icap_in[29]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 4 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {icap_state[0]} {icap_state[1]} {icap_state[2]} {icap_state[3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list go_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list rst_IBUF]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets flash_clk_IBUF_BUFG]
