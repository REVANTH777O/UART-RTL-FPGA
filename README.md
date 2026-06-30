# UART-RTL-FPGA

A synthesizable UART (Universal Asynchronous Receiver Transmitter) implemented in **Verilog HDL** and verified using **Xilinx Vivado**.

This project demonstrates RTL design methodology, finite state machine (FSM) implementation, baud rate generation, functional verification, and complete UART loopback communication.

---

# Project Overview

UART (Universal Asynchronous Receiver Transmitter) is one of the most widely used asynchronous serial communication protocols.

Unlike SPI or I2C, UART does not require a shared clock between the transmitter and receiver. Instead, both transmitter and receiver independently generate timing from an agreed baud rate.

This project implements:

- UART Transmitter
- UART Receiver
- Baud Rate Generator
- UART Top Module
- Self-checking Testbench
- Loopback Verification

---

# Features

- Synthesizable Verilog RTL
- FSM Based UART Transmitter
- FSM Based UART Receiver
- 100 MHz System Clock
- 9600 Baud Communication
- 16× Receiver Oversampling
- 8-bit Data Transfer
- Start Bit Detection
- Stop Bit Detection
- Vivado Functional Simulation
- Self-checking Testbench
- FPGA Ready Design

---

# Project Architecture

```

+----------------------+
| Baud Rate Generator |
+----------+-----------+
|
tx_enb rx_enb
|
+-------------------+-------------------+
| |
▼ ▼

+-------------------+ +-------------------+
| UART Transmitter | ----Serial-------> | UART Receiver |
+-------------------+ +-------------------+

```

---

# Folder Structure

```

UART-RTL-FPGA

├── rtl
│ ├── baud_rate_generator.v
│ ├── transmitter.v
│ ├── receiver.v
│ └── uart_top.v
│
├── tb
│ └── uart_tb.v
│
├── docs
│ └── UART_RTL_Design_Handbook.pdf
│
├── images
│ ├── uart_architecture.png
│ ├── tx_fsm.png
│ ├── rx_fsm.png
│ ├── tx_waveform.png
│ ├── rx_waveform.png
│ └── loopback_waveform.png
│
├── LICENSE
│
└── README.md

```

---

# UART Frame Format

```

Idle

↓

Start Bit (0)

↓

Bit0

↓

Bit1

↓

Bit2

↓

Bit3

↓

Bit4

↓

Bit5

↓

Bit6

↓

Bit7

↓

Stop Bit (1)

↓

Idle

```

Frame Size

```

1 Start Bit

8 Data Bits

1 Stop Bit

Total = 10 Bits

```

---

# Baud Rate Calculation

System Clock

```

100 MHz

```

UART Baud Rate

```

9600

```

Transmitter Clock Divider

```

Clock Frequency / Baud Rate

100000000 / 9600

≈ 10416

```

Receiver Oversampling

```

16 × Baud Rate

16 × 9600

153600 Hz

```

Receiver Divider

```

100000000 / 153600

≈ 651

```

---

# Module Description

## 1. Baud Rate Generator

### Inputs

- clk
- reset

### Outputs

- tx_enb
- rx_enb

Purpose

Generates baud enable pulses for both transmitter and receiver.

---

## 2. UART Transmitter

### Inputs

- clk
- reset
- wr_en
- tx_enb
- d_in

### Outputs

- tx_serial_out
- busy

Purpose

Converts 8-bit parallel data into serial UART frames.

---

## 3. UART Receiver

### Inputs

- clk
- reset
- rx_enb
- rx_in

### Outputs

- data_out
- ready

Purpose

Converts serial UART frames back into parallel data.

---

## 4. UART Top

Integrates

- Baud Rate Generator
- UART Transmitter
- UART Receiver

---

# Transmitter FSM

```

IDLE

↓

START

↓

DATA

↓

STOP

↓

IDLE

```

---

# Receiver FSM

```

IDLE

↓

START

↓

DATA

↓

STOP

↓

IDLE

```

---

# Functional Verification

Verified Using Vivado Simulation

✔ Reset Verification

✔ UART Loopback

✔ Start Bit Detection

✔ Stop Bit Detection

✔ Multiple Test Vectors

✔ Busy Signal

✔ Ready Signal

✔ FSM State Transition

✔ Baud Generator

---

# Test Cases

| Input | Expected Output | Result |
|--------|-----------------|--------|
| A5 | A5 | PASS |
| 3C | 3C | PASS |
| 81 | 81 | PASS |
| 55 | 55 | PASS |

---

# Simulation Results

Simulation waveforms demonstrate

- Correct Start Bit
- Correct Data Transmission
- Correct Stop Bit
- Proper FSM Transition
- Successful Loopback
- Accurate Data Reconstruction

---

# Skills Demonstrated

- Verilog HDL
- RTL Design
- FSM Design
- UART Protocol
- Digital Logic Design
- Functional Verification
- Testbench Development
- Vivado Simulation
- FPGA Design

---

# Future Improvements

- UART with Parity
- Configurable Baud Rate
- FIFO Integration
- AXI Interface
- DMA Support
- Interrupt Support
- FPGA Hardware Validation
- UART Lite Peripheral

---

# Author

**Revanth Roy**

B.Tech Computer and Communication Engineering

FPGA | RTL Design | Digital Design | Embedded Systems

---

If you found this project useful, feel free to ⭐ the repository.
