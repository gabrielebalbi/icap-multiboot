# icap-multiboot

Cambio firmware in-system tramite la primitiva `ICAPE2` sulla scheda **Digilent CMOD A7-35T** (Artix-7 XC7A35T).

La pressione di un pulsante avvia una riconfigurazione interna, alternando tra due immagini firmware memorizzate nella flash SPI a indirizzi diversi. Base di partenza per uno scrubbing semplificato via multiboot.

## Come funziona

Il modulo top-level `IcapConfigSequencer` implementa una FSM che:

1. Attende la pressione del pulsante `go`.
2. Scrive la sequenza di configurazione su `ICAPE2`:
   - Parola di sincronizzazione (`0xAA995566`)
   - Imposta `WBSTAR` (Warm Boot Start Address) a `0x00000000` oppure `0x001E8480`, alternando ad ogni pressione
   - Invia il comando `IPROG` — l'FPGA si ricarica immediatamente dall'indirizzo selezionato
3. Il clock di ICAP è derivato dal clock di sistema da 12 MHz diviso per 256 (~46 kHz), entro i limiti del primitivo ICAPE2.
4. Viene applicato il bit-swap per byte su tutti i dati scritti su `ICAPE2`, come richiesto da UG470.

Il flag `first` tiene traccia dell'ultima immagine avviata, così le pressioni successive alternano tra immagine 0 e immagine 1.

## Mappatura pin (CMOD A7 rev. B)

| Segnale     | Pin  | Note                              |
|-------------|------|-----------------------------------|
| `flash_clk` | L17  | Oscillatore onboard da 12 MHz     |
| `rst`       | A18  | Pulsante 0 (reset sincrono)       |
| `go`        | B18  | Pulsante 1 — avvia IPROG          |
| `icap_out`  | GPIO | Bus di readback ICAP a 16 bit     |

## Layout della flash

| Indirizzo    | Contenuto              |
|--------------|------------------------|
| `0x00000000` | Bitstream primario     |
| `0x001E8480` | Bitstream alternativo  |

Il file `testMulti_0x0_0x1E8480.mcs` contiene entrambe le immagini unite, pronto per la programmazione tramite Vivado Hardware Manager.

## Core ILA

Il file XDC include un core ILA collegato a `icap_in[*]`, `icap_state[3:0]`, `go` e `rst`, per la visibilità in-system della FSM durante l'esecuzione.

## Build

Per rigenerare il bitstream da riga di comando (Vivado 2020.2):

```
vivado -mode batch -source build_bitstream.tcl
```

Il bitstream viene salvato in `output/icap_multiboot.bit`.

## Requisiti

- Vivado 2020.2 o successivo (file progetto: `saltando_da_un_fw_allaltro.xpr`)
- Digilent CMOD A7-35T

## Riferimenti

- Xilinx UG470 — 7 Series FPGAs Configuration User Guide (ICAPE2, WBSTAR, IPROG)
- Xilinx DS181 — Artix-7 FPGAs Data Sheet (vincoli di clock ICAPE2)
