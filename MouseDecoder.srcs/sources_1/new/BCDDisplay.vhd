----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/15/2022 01:22:28 PM
-- Design Name: 
-- Module Name: BCDDisplay - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BCDDisplay is
    Port(
        BCD: in STD_LOGIC_VECTOR(3 downto 0);
        DISPLAY: out STD_LOGIC_VECTOR(0 to 6)
    );
end BCDDisplay;

architecture Behavioral of BCDDisplay is
begin
    process(BCD)
    begin
        case BCD is
            when "0000" => DISPLAY <= "0000001";
            when "0001" => DISPLAY <= "1001111";
            when "0010" => DISPLAY <= "0010010";
            when "0011" => DISPLAY <= "0000110";
            when "0100" => DISPLAY <= "1001100";
            when "0101" => DISPLAY <= "0100100";
            when "0110" => DISPLAY <= "0100000";
            when "0111" => DISPLAY <= "0001111";
            when "1000" => DISPLAY <= "0000000";
            when "1001" => DISPLAY <= "0000100";
            when others => DISPLAY <= "0110000";
        end case;
    end process;
end Behavioral;
