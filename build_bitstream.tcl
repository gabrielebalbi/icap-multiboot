# build_bitstream.tcl
# Apre il progetto icap-multiboot, esegue sintesi + implementazione e genera il bitstream.
# Uso: vivado -mode batch -source build_bitstream.tcl

set script_dir [file dirname [file normalize [info script]]]
set project_file "$script_dir/saltando_da_un_fw_allaltro.xpr"
set output_dir   "$script_dir/output"

file mkdir $output_dir

puts "==> Apertura progetto: $project_file"
open_project $project_file

# ---------------------------------------------------------------------------
# Sintesi
# ---------------------------------------------------------------------------
set synth_status [get_property STATUS [get_runs synth_1]]
puts "==> Stato sintesi: $synth_status"
if {$synth_status ne "synth_design Complete!"} {
    puts "==> Avvio sintesi..."
    reset_run synth_1
    launch_runs synth_1 -jobs 4
    wait_on_run synth_1
    set synth_status [get_property STATUS [get_runs synth_1]]
    puts "==> Sintesi completata: $synth_status"
} else {
    puts "==> Sintesi già presente, salto."
}

# ---------------------------------------------------------------------------
# Implementazione + bitstream
# ---------------------------------------------------------------------------
puts "==> Reset e avvio implementazione..."
reset_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1
set impl_status [get_property STATUS [get_runs impl_1]]
puts "==> Implementazione completata: $impl_status"

# ---------------------------------------------------------------------------
# Copia output
# ---------------------------------------------------------------------------
set impl_dir [get_property DIRECTORY [get_runs impl_1]]
set src_bit  [glob -nocomplain "$impl_dir/*.bit"]
if {$src_bit eq ""} {
    puts "ERRORE: bitstream non trovato in $impl_dir"
    exit 1
}
set dst_bit "$output_dir/icap_multiboot.bit"
file copy -force [lindex $src_bit 0] $dst_bit
puts "==> Bitstream copiato in: $dst_bit"
puts "==> Build completata."
