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

component MouseDecoder is
    Port(
        Reset:          in  STD_LOGIC;
        MouseClock:     in  STD_LOGIC;
        MouseData:      in  STD_LOGIC;
        MouseMessage:   out Mouse_Message;
        NewMessage:     out STD_LOGIC
    );
end component;

signal Number:      STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

signal M: Mouse_Message;
signal NewMessage: STD_LOGIC;
signal x, y: STD_LOGIC := '0';
--signal Mega: STD_LOGIC;

begin
-- This implementation skips some clicks
    process(Reset, NewMessage, M, Number)
    variable temp: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    begin
        if Reset = '1' then
            Number <= (others => '0');
            temp := (others => '0');
            x <= '0';
            y <= '0';
        elsif rising_edge(NewMessage) then
            if M.LeftClick = '0' and x = '1' then
                temp := temp + 1;
            end if;
            if M.RightClick = '0' and y = '1' and temp > 0 then
                temp := temp - 1;
            end if;
            x <= M.LeftClick;
            y <= M.RightClick;
            Number <= temp;
        end if;
    end process;

--    Mega <= M.LeftClick or M.RightClick;
--    process(Mega, Number)
--    begin
--        if falling_edge(Mega) then
--            if M.LeftClick = '0' then
--                Number <= Number + 1;
--            end if;
--            if M.RightClick = '0' and Number > 0 then
--                Number <= Number - 1;
--            end if;
--        end if;
--    end process;
    
    Debugging: process(Clock, DebugSwitch, NewMessage, M, x, y)
    begin
        if falling_edge(Clock) then
            if DebugSwitch = '0' then
                Debug(15) <= M.LeftClick;
                Debug(14) <= M.RightClick;
                
                Debug(13) <= x;
                Debug(12) <= y;
                
                if M.X = 0 then
                    Debug(11) <= '1';
                else
                    Debug(11) <= '0';
                end if;
                if M.Y = 0 then
                    Debug(10) <= '1';
                else
                    Debug(10) <= '0';
                end if;
                if M.Z = 0 then
                    Debug(9) <= '1';
                else
                    Debug(9) <= '0';
                end if;
                Debug(8) <= NewMessage;
                Debug(7 downto 0) <= (others => '0');
            else
                Debug <= Number;
            end if;
        end if;
    end process;
    
    Decode_Message: MouseDecoder port map (
        Reset => Reset,
        MouseClock => MouseClock,
        MouseData => MouseData,
        MouseMessage => M,
        NewMessage => NewMessage
    );
        
    Display_Number: SSGDisplay port map (Clock, Number, Segments, Anodes);
end Behavioral;
