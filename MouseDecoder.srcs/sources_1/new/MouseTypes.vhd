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
    
    function ParseMouseData(signal Buf: STD_LOGIC_VECTOR(42 downto 0)) return Mouse_Message;
    function IsMouseDataValid(signal Buf: STD_LOGIC_VECTOR(42 downto 0)) return Boolean;
    
end package;

package body Mouse_Types is
    function ParseMouseData(signal Buf: STD_LOGIC_VECTOR(42 downto 0)) return Mouse_Message is
    variable Msg: Mouse_Message;
    begin
        Msg.LeftClick   := Buf(42);
        Msg.RightClick  := Buf(41);
        Msg.MiddleClick := Buf(40);
        -- Bit #3 <==> #39 is always 1
        Msg.X(8) := Buf(38);
        Msg.Y(8) := Buf(37);
        Msg.OverflowX   := Buf(36);
        Msg.OverflowY   := Buf(35);
        -- Parity, Stop, Start
        
        Msg.X(7 downto 0) := Buf(31 downto 24);
        -- Parity, Stop, Start
        Msg.Y(7 downto 0) := Buf(20 to 13);
        -- Parity, Stop, Start, Sign Extension or Secondary Buttons
        Msg.Z := Buf(5 to 2);
        -- Stop bit
        
        return Msg;
    end function;
    
    function ParityOf(signal Buf: STD_LOGIC_VECTOR) return STD_LOGIC is
    variable P: STD_LOGIC := '0';
    begin
        for I in Buf'RANGE loop
            P := P xor Buf(I);
        end loop;
        return P;
    end function;
    
    function IsMouseDataValid(signal Buf: STD_LOGIC_VECTOR(42 downto 0)) return Boolean is
    begin
        if Buf(39) /= '1' then return false; end if;
        if ParityOf(Buf(42 downto 35)) /= Buf(34) then return false; end if;
        if Buf(33) /= '1' or Buf(32) /= '0' then return false; end if;
        
        if ParityOf(Buf(31 downto 24)) /= Buf(23) then return false; end if;
        if Buf(22) /= '1' or Buf(21) /= '0' then return false; end if;
        
        if ParityOf(Buf(20 downto 13)) /= Buf(12) then return false; end if;
        if Buf(11) /= '1' or Buf(10) /= '0' then return false; end if;
        
        if ParityOf(Buf(9 downto 2)) /= Buf(1) then return false; end if;
        if Buf(0) /= '1' then return false; end if;
        
        return true;
    end function;
end;
