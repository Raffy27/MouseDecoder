----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2022 10:22:06 PM
-- Design Name: 
-- Module Name: Bin2Bcd - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Bin2Bcd is
    Port(
        Clock:  in  STD_LOGIC;
        Reset:  in  STD_LOGIC;
        Number: in  STD_LOGIC_VECTOR(15 downto 0);
        BCD:    out STD_LOGIC_VECTOR(15 downto 0)
    );
end Bin2Bcd;

architecture Behavioral of Bin2Bcd is
type TState is (Take, Shift, Add, Provide);
signal State: TState := Take;
begin
    process(Reset, Clock, State, Number)
    variable vBuff: STD_LOGIC_VECTOR(31 downto 0);
    variable I: NATURAL;
    begin
        if Reset = '1' then
            State <= Take;
        else
            case State is
                when Take =>
                    vBuff(15 downto 0) := Number;
                    vBuff(31 downto 16) := (others => '0');
                    I := 0;
                    State <= Shift;
                when Shift =>
                    vBuff := vBuff(30 downto 0) & '0';
                    if I = 15 then
                        State <= Provide;
                    else
                        State <= Add;
                    end if;
                when Add =>
                    if vBuff(19 downto 16) > 4 then
                        vBuff(19 downto 16) := vBuff(19 downto 16) + 3;
                    end if;
                    if vBuff(23 downto 20) > 4 then
                        vBuff(23 downto 20) := vBuff(23 downto 20) + 3;
                    end if;
                    if vBuff(27 downto 24) > 4 then
                        vBuff(27 downto 24) := vBuff(27 downto 24) + 3;
                    end if;
                    if vBuff(31 downto 28) > 4 then
                        vBuff(31 downto 28) := vBuff(31 downto 28) + 3;
                    end if;
                    I := I + 1;
                    State <= Shift;
                when Provide =>
                    BCD <= vBuff(31 downto 16);
            end case;
        end if;
    end process;

end Behavioral;
