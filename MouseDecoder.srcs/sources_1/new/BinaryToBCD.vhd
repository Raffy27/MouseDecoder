----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2022 07:50:50 PM
-- Design Name: 
-- Module Name: BinaryToBCD - Behavioral
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

entity BinaryToBCD is
    Port(
        Number :    in  STD_LOGIC_VECTOR (15 downto 0);
        Ones :      out STD_LOGIC_VECTOR (3 downto 0);
        Tens :      out STD_LOGIC_VECTOR (3 downto 0);
        Hundreds :  out STD_LOGIC_VECTOR (3 downto 0);
        Thousands : out STD_LOGIC_VECTOR (3 downto 0)
    );
end BinaryToBCD;

architecture Behavioral of BinaryToBCD is
begin
    process(Number)
    variable BCD: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    variable Tmp: STD_LOGIC_VECTOR(15 downto 0) := Number; 
    begin
        for I in 0 to 15 loop
            BCD(15 downto 1) := BCD(14 downto 0);
            BCD(0) := Tmp(15);
            Tmp(15 downto 1) := Tmp(14 downto 0);
            Tmp(0) := '0';
            
            if I < 15 and BCD(3 downto 0) > "0100" then
                BCD(3 downto 0) := BCD(3 downto 0) + "0011";
            end if;
            if I < 15 and BCD(7 downto 4) > "0100" then
                BCD(7 downto 4) := BCD(7 downto 4) + "0011";
            end if;
            if I < 15 and BCD(11 downto 8) > "0100" then
                BCD(11 downto 8) := BCD(11 downto 8) + "0011";
            end if;
            if I < 15 and BCD(15 downto 12) > "0100" then
                BCD(15 downto 12) := BCD(15 downto 12) + "0011";
            end if;
        end loop;
        Ones <= BCD(3 downto 0);
        Tens <= BCD(7 downto 4);
        Hundreds <= BCD(11 downto 8);
        Thousands <= BCD(15 downto 12);
    end process;
end Behavioral;
