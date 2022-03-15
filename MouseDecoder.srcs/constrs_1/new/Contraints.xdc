# Clock signal
#set_property PACKAGE_PIN W5 [get_ports CLK100MHZ]							
#	set_property IOSTANDARD LVCMOS33 [get_ports CLK100MHZ]
#	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK100MHZ]


# Switches
set_property PACKAGE_PIN V17 [get_ports {BCD[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {BCD[0]}]
set_property PACKAGE_PIN V16 [get_ports {BCD[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {BCD[1]}]
set_property PACKAGE_PIN W16 [get_ports {BCD[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {BCD[2]}]
set_property PACKAGE_PIN W17 [get_ports {BCD[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {BCD[3]}]


# LEDs
#set_property PACKAGE_PIN U16 [get_ports {LED[0]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {LED[0]}]
#set_property PACKAGE_PIN E19 [get_ports {LED[1]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {LED[1]}]
#set_property PACKAGE_PIN U19 [get_ports {LED[2]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {LED[2]}]
#set_property PACKAGE_PIN V19 [get_ports {LED[3]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {LED[3]}]


#7 segment display
set_property PACKAGE_PIN W7 [get_ports {DISPLAY[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {DISPLAY[0]}]
set_property PACKAGE_PIN W6 [get_ports {DISPLAY[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {DISPLAY[1]}]
set_property PACKAGE_PIN U8 [get_ports {DISPLAY[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {DISPLAY[2]}]
set_property PACKAGE_PIN V8 [get_ports {DISPLAY[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {DISPLAY[3]}]
set_property PACKAGE_PIN U5 [get_ports {DISPLAY[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {DISPLAY[4]}]
set_property PACKAGE_PIN V5 [get_ports {DISPLAY[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {DISPLAY[5]}]
set_property PACKAGE_PIN U7 [get_ports {DISPLAY[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {DISPLAY[6]}]

#set_property PACKAGE_PIN V7 [get_ports dp]							
#	set_property IOSTANDARD LVCMOS33 [get_ports dp]

#set_property PACKAGE_PIN U2 [get_ports {an[0]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
#set_property PACKAGE_PIN U4 [get_ports {an[1]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
#set_property PACKAGE_PIN V4 [get_ports {an[2]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
#set_property PACKAGE_PIN W4 [get_ports {an[3]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]