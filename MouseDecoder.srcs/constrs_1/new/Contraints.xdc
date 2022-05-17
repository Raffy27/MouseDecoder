# Clock signal
set_property PACKAGE_PIN W5 [get_ports Clock]
    set_property IOSTANDARD LVCMOS33 [get_ports Clock]
set_property PACKAGE_PIN W19 [get_ports Reset]
    set_property IOSTANDARD LVCMOS33 [get_ports Reset]

# USB HID (PS/2)
set_property PACKAGE_PIN C17 [get_ports MouseClock]                        
    set_property IOSTANDARD LVCMOS33 [get_ports MouseClock]
    set_property PULLUP true [get_ports MouseClock]
set_property PACKAGE_PIN B17 [get_ports MouseData]                    
    set_property IOSTANDARD LVCMOS33 [get_ports MouseData]    
    set_property PULLUP true [get_ports MouseData]
    
# Debug I/O and LEDs
set_property PACKAGE_PIN R2 [get_ports DebugSw]
    set_property IOSTANDARD LVCMOS33 [get_ports DebugSw]
set_property PACKAGE_PIN V17 [get_ports ReverseSw]
    set_property IOSTANDARD LVCMOS33 [get_ports ReverseSw] 

set_property PACKAGE_PIN U16 [get_ports {LED[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[0]}]
set_property PACKAGE_PIN E19 [get_ports {LED[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[1]}]
set_property PACKAGE_PIN U19 [get_ports {LED[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[2]}]
set_property PACKAGE_PIN V19 [get_ports {LED[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[3]}]
set_property PACKAGE_PIN W18 [get_ports {LED[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[4]}]
set_property PACKAGE_PIN U15 [get_ports {LED[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[5]}]
set_property PACKAGE_PIN U14 [get_ports {LED[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[6]}]
set_property PACKAGE_PIN V14 [get_ports {LED[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[7]}]
set_property PACKAGE_PIN V13 [get_ports {LED[8]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[8]}]
set_property PACKAGE_PIN V3 [get_ports {LED[9]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[9]}]
set_property PACKAGE_PIN W3 [get_ports {LED[10]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[10]}]
set_property PACKAGE_PIN U3 [get_ports {LED[11]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[11]}]
set_property PACKAGE_PIN P3 [get_ports {LED[12]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[12]}]
set_property PACKAGE_PIN N3 [get_ports {LED[13]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[13]}]
set_property PACKAGE_PIN P1 [get_ports {LED[14]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[14]}]
set_property PACKAGE_PIN L1 [get_ports {LED[15]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED[15]}]                                                                                

# Seven Segment Display
set_property PACKAGE_PIN W7 [get_ports {Segments[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Segments[6]}]
set_property PACKAGE_PIN W6 [get_ports {Segments[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Segments[5]}]
set_property PACKAGE_PIN U8 [get_ports {Segments[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Segments[4]}]
set_property PACKAGE_PIN V8 [get_ports {Segments[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Segments[3]}]
set_property PACKAGE_PIN U5 [get_ports {Segments[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Segments[2]}]
set_property PACKAGE_PIN V5 [get_ports {Segments[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Segments[1]}]
set_property PACKAGE_PIN U7 [get_ports {Segments[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Segments[0]}]
set_property PACKAGE_PIN U2 [get_ports {Anodes[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Anodes[0]}]
set_property PACKAGE_PIN U4 [get_ports {Anodes[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Anodes[1]}]
set_property PACKAGE_PIN V4 [get_ports {Anodes[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Anodes[2]}]
set_property PACKAGE_PIN W4 [get_ports {Anodes[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Anodes[3]}]