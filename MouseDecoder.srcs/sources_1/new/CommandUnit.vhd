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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CommandUnit is
    Port(
        Reset : in STD_LOGIC;
        Clock : in STD_LOGIC;
        Button: in STD_LOGIC;
        Segments: out STD_LOGIC_VECTOR(6 downto 0);
        Anodes:     out STD_LOGIC_VECTOR(3 downto 0)
    );
end CommandUnit;

architecture Behavioral of CommandUnit is

component BCDDisplay is
    Port(
        Reset:      in STD_LOGIC;
        clock_100Mhz:   in STD_LOGIC;
        displayed_number: in STD_LOGIC_VECTOR (15 downto 0);
        Display:    out STD_LOGIC_VECTOR(6 downto 0);
        Anodes:     out STD_LOGIC_VECTOR(3 downto 0)
    );
end component;
signal BtnTransform: STD_LOGIC_VECTOR(25 downto 0) := (others => '0');
signal Number: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
begin
    process (Reset, Clock)
    begin
        if Reset = '1' then
            BtnTransform <= (others => '0');
        elsif rising_edge(Clock) then
            if BtnTransform(25) = '1' then
                BtnTransform <= (others => '0');
            else
                BtnTransform <= BtnTransform + 1;
            end if;
        end if;
    end process;
    process(Reset, BtnTransform, Button)
    begin
        if Reset = '1' then
            Number <= (others => '0');
        elsif BtnTransform(25) = '1' then
            if Button = '1' then
                Number <= Number + 1;
            end if;
        end if;
    end process;
    
    Display_Number: BCDDisplay port map (Reset, Clock, Number, Segments, Anodes);
end Behavioral;
