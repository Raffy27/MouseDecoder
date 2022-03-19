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
        Tens :      in  STD_LOGIC_VECTOR (3 downto 0);
        Hundreds :  in  STD_LOGIC_VECTOR (3 downto 0);
        Thousands : in  STD_LOGIC_VECTOR (3 downto 0)
    );
end BinaryToBCD;

architecture Behavioral of BinaryToBCD is
signal R: STD_LOGIC_VECTOR(31 downto 0);
begin
    R <= "0000000000000000" & Number;
    process(Number)
    begin
        for I in 1 to 16 loop
            R <= R(30 to 0) & '0';
        end for;
    end process;

end Behavioral;
