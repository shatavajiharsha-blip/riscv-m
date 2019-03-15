set sdc_version 2.0
current_design top_module
set_unit -capacitance 1000.00fF
set_units -time 1000.00ps
create_clock -name clk -period 1 -waveform {0 0.5} [get_ports clk ]
create_clock -name VCLK -period 1 -waveform {0 0.5}

set_clock_uncertainty -setup  0.40 [get_ports clk ]


set_input_delay -clock VCLK -max 0.6 [all_inputs]
set_input_delay -clock VCLK -min 0.2 [all_inputs]  
set_output_delay -clock VCLK -max 0.4 [all_output]
set_output_delay -clock VCLK -min 0.1 [all_output] 

set_max_fanout 30.00 [current_design]
