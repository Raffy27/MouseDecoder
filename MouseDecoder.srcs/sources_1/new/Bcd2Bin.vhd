----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2022 02:37:35 PM
-- Design Name: 
-- Module Name: Bcd2Bin - Behavioral
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

entity Bcd2Bin is
    Port(
        Number: in  STD_LOGIC_VECTOR (15 downto 0);
        Clock : in  STD_LOGIC;
        Enable:  in  STD_LOGIC;
        BCD:    out STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
        Ready:  out STD_LOGIC := '0'
    );
end Bcd2Bin;

architecture Behavioral of Bcd2Bin is
signal State:   STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
begin
    Shift_And_Add: process(Enable, Clock, Number)
    variable vNumber: STD_LOGIC_VECTOR(15 downto 0);
    variable vBCD:    STD_LOGIC_VECTOR(15 downto 0);
    begin
        if rising_edge(Enable) then
            -- Component was just enabled, copy input for internal operations
            vNumber := Number;
            vBCD := (others => '0');
        elsif Enable = '0' then
            State <= (others => '0');
            Ready <= '0';
            BCD <= (others => '0');
        elsif rising_edge(Clock) then
            -- Valid input data: shift and add 3
            vBCD := vBCD(14 downto 0) & vNumber(15);
            vNumber := vNumber(14 downto 0) & '0';
            if vBCD(3 downto 0) > 4 then
                vBCD(3 downto 0) := vBCD(3 downto 0) + 3;
            end if;
            if vBCD(7 downto 4) > 4 then
                vBCD(7 downto 4) := vBCD(7 downto 4) + 3;
            end if;
            if vBCD(11 downto 8) > 4 then
                vBCD(11 downto 8) := vBCD(11 downto 8) + 3;
            end if;
            if vBCD(15 downto 12) > 4 then
                vBCD(15 downto 12) := vBCD(15 downto 12) + 3;
            end if;
            -- Increment State
            State <= State + 1;
        elsif falling_edge(Clock) then
            -- Prepare result
            if State = 16 then
                BCD <= vBCD;
                Ready <= '1';
            end if;
        end if;
    end process;
end Behavioral;
