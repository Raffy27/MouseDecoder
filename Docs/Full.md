# Mouse Interfacing
> A18 - FPGA and mouse application

## Problem Statement
Implement an application that allows the user to count the number of mouse clicks.
Functional requirements:
* Extisting RESET button that will clear the SSD display (status "0000")
* The current status is displayed on the SSD
* Pressing the left mouse button will increase the current status
* Pressing the right mouse button will decrease the current status
* An IS_LEFT LED is lit, marking the fact that the left click increases and the right click decreases
* A REVERSE button/switch is used to reverse the mouse functions, IS_LEFT will turn off when pressed

The project will be carried out by **2 students.**

### Changes in Terminology
increase -> increment
decrease -> decrement
IS_LEFT
REVERSE
Naming convention and capitalization

## Overview

The general idea of the solution is to receive the message packets sent by the mouse, extract the significant bits from them, detect actual mouse clicks, and modify the internal state accordingly. This state should then be transformed into Binary Coded Decimal representation and displayed on the Seven Segment Display.
The internal state management should be implemented in the form of a bidirectional counter, in accordance with the conditions governing the state transitions (for example, if the reverse switch is toggled, left clicks result in a decrement and right clicks result in an increment).

From a high-level perspective, the solution is divided into the following parts:
* **CounterUnit:** the main unit that manages the internal state
* **MouseDecoder:** the component responsible for decoding and forwarding the mouse packets
* **BinaryToBCD:** the component responsible for transforming the internal state into the BCD representation
* **SevenSegmentDisplay:** the component responsible for displaying a given number based on the BCD representation

There is also an additional utility library focused on structuring and validating mouse packets. The goal of this library is to provide an intuitive interface to work with, instead of having to manually count bits to determine their meaning.

### Hardware

### Communication

A valid transmission from the mouse is defined in the following table.
|  | Bit 7 | Bit 6 | Bit 5 | Bit 4 | Bit 3 | Bit 2 | Bit 1 | Bit 0 |
|---|-------|-------|-------|-------|-------|-------|-------|-------|
| Byte 1 | Y overflow | X overflow | Y sign bit | X sign bit | Always 1 | Middle Btn | Right Btn | Left Btn |
| Byte 2 | X Movement |
| Byte 3 | Y Movement |
| Byte 4 | Z Movement |

Additionally, transmissions are delimited by a *1* stop bit (used for signaling the end of the transmission, or an idle state), and a *0* start bit. Each byte also has a parity bit, which is used to detect transmission errors.

For example, a valid binary sequence would be:
| Index | Bit | Description |
|:-----:|:---:|-------------|
| 0     | 0   | Start bit   |
| 1     | 1   | Left mouse button currently pressed |
| 2     | 0   | Right mouse button currently not pressed |
| 3     | 0   | Middle mouse button currently not pressed |
| 4     | 1   | Always *1*  |
| 5     | 0   | X movement is a positive amount (^) |
| 6     | 1   | Y movement is a negative amount (^) |
| 7     | 0   | No overflow for X |
| 8     | 0   | No overflow for Y |
| 9     | 1   | Parity bit |
| 10    | 0   | Stop bit |
| 11    | 0   | Start bit |
...

## Detailed Implementation

The data structure defined in the convenience library is used to represent the incoming mouse packets.

```vhdl
type Mouse_Message is record
    LeftClick:  STD_LOGIC;
    RightClick: STD_LOGIC;
    MiddleClick:STD_LOGIC;
    OverflowX:  STD_LOGIC;
    OverflowY:  STD_LOGIC;
    
    X: STD_LOGIC_VECTOR(8 downto 0);
    Y: STD_LOGIC_VECTOR(8 downto 0);
    Z: STD_LOGIC_VECTOR(8 downto 0);
end record;
```

### Alternative Solutions

* simple counter

## Debugging

In order to perform debugging and figure out what goes wrong for generic transmissions, packets were fragmented and displayed using the available LEDs. The binary sequence was then manually transferred and used as input for a Python script which decoded it into a human-readable format.

The script I wrote can be found [here.](https://gist.github.com/)

An example of its output is shown below.
```json
{
    "actual": "output"
}
```

## Results

<GIF of the thing in action>

## Acknowledgements
https://web.archive.org/web/20041117095622/http://panda.cs.ndsu.nodak.edu:80/~achapwes/PICmicro/mouse/mouse.html