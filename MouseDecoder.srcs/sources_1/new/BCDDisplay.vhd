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
use IEEE.std_logic_unsigned.all;
use iEEE.numeric_std.all;

entity BCDDisplay is
    Port(
        Reset:      in STD_LOGIC;
        clock_100Mhz:   in STD_LOGIC;
        Display:    out STD_LOGIC_VECTOR(6 downto 0);
        Anodes:     out STD_LOGIC_VECTOR(3 downto 0)
    );
end BCDDisplay;

architecture Behavioral of BCDDisplay is
signal one_second_counter: STD_LOGIC_VECTOR (27 downto 0);
signal one_second_enable: STD_LOGIC;
-- one second enable for counting numbers
signal displayed_number: STD_LOGIC_VECTOR (15 downto 0);
signal LED_BCD: STD_LOGIC_VECTOR (3 downto 0);
signal refresh_counter: STD_LOGIC_VECTOR (19 downto 0);
-- creating 10.5ms refresh period
signal LED_activating_counter: std_logic_vector(1 downto 0);
-- the other 2-bit for creating 4 LED-activating signals
-- count         0    ->  1  ->  2  ->  3
-- activates    LED1    LED2   LED3   LED4
-- and repeat

component BinaryToBCD is
    Port(
        Number :    in  STD_LOGIC_VECTOR (15 downto 0);
        Ones :      out STD_LOGIC_VECTOR (3 downto 0);
        Tens :      out STD_LOGIC_VECTOR (3 downto 0);
        Hundreds :  out STD_LOGIC_VECTOR (3 downto 0);
        Thousands : out STD_LOGIC_VECTOR (3 downto 0)
    );
end component;
signal O, T, H, Th: STD_LOGIC_VECTOR (3 downto 0);

begin

BCD_Conversion: BinaryToBCD port map (
    Number => displayed_number, 
    Ones => O,
    Tens => T,
    Hundreds => H,
    Thousands => Th
);

process(LED_BCD)
begin
    case LED_BCD is
    when "0000" => Display <= "0000001"; -- "0"     
    when "0001" => Display <= "1001111"; -- "1" 
    when "0010" => Display <= "0010010"; -- "2" 
    when "0011" => Display <= "0000110"; -- "3" 
    when "0100" => Display <= "1001100"; -- "4" 
    when "0101" => Display <= "0100100"; -- "5" 
    when "0110" => Display <= "0100000"; -- "6" 
    when "0111" => Display <= "0001111"; -- "7" 
    when "1000" => Display <= "0000000"; -- "8"     
    when "1001" => Display <= "0000100"; -- "9" 
    when "1010" => Display <= "0000010"; -- a
    when "1011" => Display <= "1100000"; -- b
    when "1100" => Display <= "0110001"; -- C
    when "1101" => Display <= "1000010"; -- d
    when "1110" => Display <= "0110000"; -- E
    when "1111" => Display <= "0111000"; -- F
    end case;
end process;
-- 7-segment display controller
-- generate refresh period of 10.5ms
process(clock_100Mhz,Reset)
begin 
    if(Reset='1') then
        refresh_counter <= (others => '0');
    elsif(rising_edge(clock_100Mhz)) then
        refresh_counter <= refresh_counter + 1;
    end if;
end process;
 LED_activating_counter <= refresh_counter(19 downto 18);
-- 4-to-1 MUX to generate anode activating signals for 4 LEDs 
process(LED_activating_counter)
begin
    case LED_activating_counter is
    when "00" =>
        Anodes <= "0111"; 
        -- activate LED1 and Deactivate LED2, LED3, LED4
        LED_BCD <= Th;
        -- the first hex digit of the 16-bit number
    when "01" =>
    Anodes <= "1011"; 
        -- activate LED2 and Deactivate LED1, LED3, LED4
        LED_BCD <= H;
        -- the second hex digit of the 16-bit number
    when "10" =>
        Anodes <= "1101"; 
        -- activate LED3 and Deactivate LED2, LED1, LED4
        LED_BCD <= T;
        -- the third hex digit of the 16-bit number
    when "11" =>
        Anodes <= "1110"; 
        -- activate LED4 and Deactivate LED2, LED3, LED1
        LED_BCD <= O;
        -- the fourth hex digit of the 16-bit number    
    end case;
end process;
-- Counting the number to be displayed on 4-digit 7-segment Display 
-- on Basys 3 FPGA board
process(clock_100Mhz, Reset)
begin
        if(Reset='1') then
            one_second_counter <= (others => '0');
        elsif(rising_edge(clock_100Mhz)) then
            if(one_second_counter>=x"5F5E0FF") then
                one_second_counter <= (others => '0');
            else
                one_second_counter <= one_second_counter + "0000001";
            end if;
        end if;
end process;
one_second_enable <= '1' when one_second_counter=x"5F5E0FF" else '0';
process(clock_100Mhz, Reset)
begin
        if(Reset='1') then
            displayed_number <= (others => '0');
        elsif(rising_edge(clock_100Mhz)) then
             if(one_second_enable='1') then
                displayed_number <= displayed_number + x"0001";
             end if;
        end if;
end process;

end Behavioral;
