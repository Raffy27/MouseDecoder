----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/15/2022 01:22:28 PM
-- Design Name: 
-- Module Name: SSGDisplay - Behavioral
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
use iEEE.numeric_std.all;

entity SSGDisplay is
    Port(
        Clock:      in STD_LOGIC;
        Number:     in STD_LOGIC_VECTOR (15 downto 0);
        Segments:   out STD_LOGIC_VECTOR(6 downto 0);
        Anodes:     out STD_LOGIC_VECTOR(3 downto 0)
    );
end SSGDisplay;

architecture Behavioral of SSGDisplay is

signal Digit: STD_LOGIC_VECTOR(3 downto 0);
-- 1 / (100MHz / 2^20) = 10.48ms refresh rate
signal Refresh: STD_LOGIC_VECTOR(19 downto 0);
-- 2 bits for the 4 to 1 MUX
signal NextAnode: STD_LOGIC_VECTOR(1 downto 0);

component Bin2Bcd is
    Port(
        Clock:  in  STD_LOGIC;
        Reset:  in  STD_LOGIC;
        Number: in  STD_LOGIC_VECTOR(15 downto 0);
        BCD:    out STD_LOGIC_VECTOR(15 downto 0)
    );
end component Bin2Bcd;

signal ResetB2B:    STD_LOGIC;
signal BCD:         STD_LOGIC_VECTOR(15 downto 0);

begin
    Segment_Pattern: process(Digit)
    begin
        case Digit is
            when "0000" => Segments <= "0000001"; -- 0    
            when "0001" => Segments <= "1001111"; -- 1
            when "0010" => Segments <= "0010010"; -- 2
            when "0011" => Segments <= "0000110"; -- 3
            when "0100" => Segments <= "1001100"; -- 4
            when "0101" => Segments <= "0100100"; -- 5
            when "0110" => Segments <= "0100000"; -- 6
            when "0111" => Segments <= "0001111"; -- 7
            when "1000" => Segments <= "0000000"; -- 8   
            when "1001" => Segments <= "0000100"; -- 9
            when others => Segments <= "0000001"; -- 0
        end case;
    end process;

    Refresh_Interval: process(Clock)
    begin 
        if rising_edge(Clock) then
            Refresh <= Refresh + 1;
        end if;
    end process;
    
    -- Select the next anode pattern
    Anode_Mux: NextAnode <= Refresh(19 downto 18);
    
    ResetB2B <= Refresh(18);
    
    Binary_To_BCD: Bin2Bcd port map(
        Number => Number, 
        Clock => Clock,
        Reset => ResetB2B,
        BCD => BCD
    );
    
    Digit_Selection: process(NextAnode, BCD)
    begin
        -- Select the actual digit to show
        case NextAnode is
            when "00" =>    -- First digit
                Anodes <= "0111";
                Digit <= BCD(15 downto 12);
            when "01" =>    -- Second digit
                Anodes <= "1011";
                Digit <= BCD(11 downto 8);
            when "10" =>    -- Third digit
                Anodes <= "1101";
                Digit <= BCD(7 downto 4);
            when "11" =>    -- Fourth digit
                Anodes <= "1110"; 
                Digit <= BCD(3 downto 0);  
            end case;
    end process;

end Behavioral;
