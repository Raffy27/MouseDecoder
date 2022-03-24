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

-- Logic for converting the binary input to BCD
-- TODO: Refactor this into a separate component (solve weird combinational loop error)
function BinToBCD(Bin: STD_LOGIC_VECTOR(15 downto 0)) return STD_LOGIC_VECTOR is
variable BCD:   STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
variable Temp:  STD_LOGIC_VECTOR(15 downto 0) := Bin;
begin
    for I in 0 to 15 loop
        -- Shift left
        BCD(15 downto 1) := BCD(14 downto 0);
        BCD(0) := Temp(15);
        Temp(15 downto 1) := Temp(14 downto 0);
        Temp(0) := '0';
        
        -- Conditionally add 3
        if I < 15 then
            if BCD(3 downto 0) > 4 then
                BCD(3 downto 0) := BCD(3 downto 0) + 3;
            end if;
            if BCD(7 downto 4) > 4 then
                BCD(7 downto 4) := BCD(7 downto 4) + 3;
            end if;
            if BCD(11 downto 8) > 4 then
                BCD(11 downto 8) := BCD(11 downto 8) + 3;
            end if;
            if BCD(15 downto 12) > 4 then
                BCD(15 downto 12) := BCD(15 downto 12) + 3;
            end if;
        end if;
    end loop;

    return BCD;
end BinToBCD;

begin
    process(Digit)
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

    process(Clock)
    begin 
        if rising_edge(Clock) then
            Refresh <= Refresh + 1;
        end if;
    end process;
    
    -- Select the next anode pattern
    NextAnode <= Refresh(19 downto 18);
    
    process(NextAnode)
    variable Parsed: STD_LOGIC_VECTOR(15 downto 0);
    begin
        Parsed := BinToBCD(Number);
        case NextAnode is
            when "00" =>    -- First digit
                Anodes <= "0111";
                Digit <= Parsed(15 downto 12);
            when "01" =>    -- Second digit
                Anodes <= "1011";
                Digit <= Parsed(11 downto 8);
            when "10" =>    -- Third digit
                Anodes <= "1101";
                Digit <= Parsed(7 downto 4);
            when "11" =>    -- Fourth digit
                Anodes <= "1110"; 
                Digit <= Parsed(3 downto 0);  
            end case;
    end process;

end Behavioral;
