----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2022 09:01:34 PM
-- Design Name: 
-- Module Name: CommandUnit - Behavioral
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
use IEEE.std_logic_unsigned.all;
use work.Mouse_Types.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CommandUnit is
    Port(
        Debug:      out STD_LOGIC_VECTOR(15 downto 0);
        DebugSwitch:in STD_LOGIC;
        Reset :     in STD_LOGIC;
        Clock :     in STD_LOGIC;
        MouseClock: in STD_LOGIC;
        MouseData:  in STD_LOGIC;
        Segments:   out STD_LOGIC_VECTOR(6 downto 0);
        Anodes:     out STD_LOGIC_VECTOR(3 downto 0)
    );
end CommandUnit;

architecture Behavioral of CommandUnit is

component SSGDisplay is
    Port(
        Clock:      in STD_LOGIC;
        Number:     in STD_LOGIC_VECTOR(15 downto 0);
        Segments:   out STD_LOGIC_VECTOR(6 downto 0);
        Anodes:     out STD_LOGIC_VECTOR(3 downto 0)
    );
end component;

signal Number:      STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
-- Counter for the number of data bits sent by the mouse
signal MouseBits:   STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
signal MouseReg:    STD_LOGIC_VECTOR(42 downto 0) := (others => '0');

signal MT1: Mouse_Message;
signal MT2: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

begin
    -- TODO: Extract as component
    process(Reset, MouseClock)
    begin
        if Reset = '1' then
            MouseBits  <= (others => '0');
        elsif rising_edge(MouseClock) then
            -- Counter modulo 43
            if MouseBits <= 42 then
                MouseBits <= MouseBits + 1;
            else
                MouseBits <= (others => '0');
            end if;
        end if;
    end process;
    
    process(Reset, MouseClock, Number, DebugSwitch)
    begin
        if Reset = '1' then
            Number <= (others => '0');
            MouseReg <= (others => '0');
        elsif falling_edge(MouseClock) then
            -- TODO: New condition for left/right mode
            MouseReg <= MouseReg(41 downto 0) & MouseData;
            if MouseBits = 1 then
                if MouseData = '1' then
                    Number <= Number + 1;
                end if;
            elsif MouseBits = 2 then
                if MouseData = '1' and Number > 0 then
                    Number <= Number - 1;
                end if;
            elsif MouseBits = 43 then
                MT1 <= ParseMouseData(MouseReg);
                if DebugSwitch = '0' then 
                    Debug(14 downto 0) <= MouseReg(42 downto 28);
                    if IsMouseDataValid(MouseReg) then
                        Debug(15) <= '1';
                    else
                        Debug(15) <= '0';
                    end if;
                else
                    Debug <= MouseReg(15 downto 0);
                end if;
            end if;
        end if;
    end process;
    
    MT2 <= "0000000" & MT1.X;
    
    Display_Number: SSGDisplay port map (Clock, MT2, Segments, Anodes);
end Behavioral;
