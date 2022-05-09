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
Heya

## Overview

The general idea of the solution is to receive the message packets sent by the mouse, extract the significant bits from them, detect actual mouse clicks, and modify the internal state accordingly. This state should then be transformed into Binary Coded Decimal representation and displayed on the Seven Segment Display.

## Detailed Implementation

### Alternative Solution

## Debugging

## Results

## Acknowledgements
https://web.archive.org/web/20041117095622/http://panda.cs.ndsu.nodak.edu:80/~achapwes/PICmicro/mouse/mouse.html