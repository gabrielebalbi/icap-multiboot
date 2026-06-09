# icap-multiboot

ICAP2-based firmware switching on the **Digilent CMOD A7-35T** (Artix-7 XC7A35T).

Pressing a button triggers an in-system reconfiguration via the `ICAPE2` primitive, alternating between two firmware images stored in the SPI flash at different addresses. Groundwork for scrubbing-light via multiboot.

## How it works

The top-level module `IcapConfigSequencer` implements a small FSM that:

1. Waits for the `go` button to be pressed.
2. Writes the configuration sequence to `ICAPE2`:
   - Sync word (`0xAA995566`)
   - Set `WBSTAR` (Warm Boot Start Address) to `0x00000000` or `0x001E8480`, alternating on each trigger
   - Issue `IPROG` command — the FPGA immediately reloads from the selected address
3. The ICAP clock is derived from the 12 MHz system clock divided by 256 (~46 kHz), well within the ICAPE2 limit.
4. Byte-level bit-swap is applied to all data written to `ICAPE2`, as required by UG470.

The `first` flag keeps track of which image was last booted, so consecutive button presses toggle between image 0 and image 1.

## Pin mapping (CMOD A7 rev. B)

| Signal      | Pin  | Notes                        |
|-------------|------|------------------------------|
| `flash_clk` | L17  | 12 MHz onboard oscillator    |
| `rst`       | A18  | Button 0 (active high, sync) |
| `go`        | B18  | Button 1 — triggers IPROG   |
| `icap_out`  | GPIO | 16-bit ICAP readback bus     |

## Flash layout

| Address      | Content         |
|--------------|-----------------|
| `0x00000000` | Primary bitstream  |
| `0x001E8480` | Alternate bitstream |

The file `testMulti_0x0_0x1E8480.mcs` contains both images merged and ready to be programmed via Vivado Hardware Manager.

## ILA debug core

The XDC includes an ILA connected to `icap_in[*]`, `icap_state[3:0]`, `go`, and `rst` for in-system visibility of the FSM while it runs.

## Requirements

- Vivado 2020.x or later (project file: `saltando_da_un_fw_allaltro.xpr`)
- Digilent CMOD A7-35T

## References

- Xilinx UG470 — 7 Series FPGAs Configuration User Guide (ICAPE2, WBSTAR, IPROG)
- Xilinx DS181 — Artix-7 FPGAs Data Sheet (ICAPE2 clock constraints)
