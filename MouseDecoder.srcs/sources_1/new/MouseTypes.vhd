----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2022 12:51:38 PM
-- Design Name: 
-- Module Name: MouseTypes - 
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package Mouse_Types is

    type Mouse_Message is record
        LeftClick:  STD_LOGIC;
        RightClick: STD_LOGIC;
        MiddleClick:STD_LOGIC;
        OverflowX:  STD_LOGIC;
        OverflowY:  STD_LOGIC;
        
        X: STD_LOGIC_VECTOR(8 downto 0);
        Y: STD_LOGIC_VECTOR(8 downto 0);
        Z: STD_LOGIC_VECTOR(3 downto 0);
    end record;
    
    function ParseMouseData(signal Buf: STD_LOGIC_VECTOR(0 to 42)) return Mouse_Message;
    function IsMouseDataValid(signal Buf: STD_LOGIC_VECTOR(0 to 42)) return Boolean;
    
end package;

package body Mouse_Types is
    function ParseMouseData(signal Buf: STD_LOGIC_VECTOR(0 to 42)) return Mouse_Message is
    variable Msg: Mouse_Message;
    begin
        Msg.LeftClick   := Buf(42);
        Msg.RightClick  := Buf(41);
        Msg.MiddleClick := Buf(40);
        -- Bit #3 == #39 is always 1
        Msg.X(8) := Buf(38);
        Msg.Y(8) := Buf(37);
        Msg.OverflowX   := Buf(36);
        Msg.OverflowY   := Buf(35);
        -- Parity, Stop, Start
        
        Msg.X(7 downto 0) := Buf(11 to 18);
        -- Parity, Stop, Start
        Msg.Y(7 downto 0) := Buf(22 to 29);
        -- Parity, Stop, Start, Sign Extension or Secondary Buttons
        Msg.Z := Buf(37 to 40);
        -- Stop bit
        
        return Msg;
    end function;
    
    function IsMouseDataValid(signal Buf: STD_LOGIC_VECTOR(0 to 42)) return Boolean is
    begin
        -- TODO
        return true;
    end function;
end;
