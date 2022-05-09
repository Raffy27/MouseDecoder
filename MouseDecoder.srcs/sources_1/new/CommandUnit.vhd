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

begin
--    process(NewMessage, Number)
--    variable LastLeft: STD_LOGIC := '0';
--    variable LastRight: STD_LOGIC := '0';
--    begin
--        if rising_edge(NewMessage) then
--            --if M.X = 0 and M.Y = 0 and M.Z = 0 then
--                if M.LeftClick = '0' and LastLeft = '1' then
--                    Number <= Number + 1;
--                end if;
--                if M.RightClick = '0' and LastRight = '1' and Number > 0 then
--                    Number <= Number - 1;
--                end if;
--                LastLeft := M.LeftClick;
--                LastRight := M.RightClick;
--            --end if;
--        end if;
--        Debug(15) <= LastLeft;
--        Debug(14) <= LastRight;
--    end process;
    process(Reset, Clock, M, Number)
    variable x, y: STD_LOGIC := '0';
    variable temp: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    begin
        if Reset = '1' then
            Number <= (others => '0');
            temp := (others => '0');
            x := '0';
            y := '0';
        elsif falling_edge(Clock) then
            if M.LeftClick = '0' and x = '1' then
                temp := temp + 1;
            end if;
            if M.RightClick = '0' and y = '1' and temp > 0 then
                temp := temp - 1;
            end if;
            x := M.LeftClick;
            y := M.RightClick;
            Number <= temp;
        end if;
    end process;
    
    Debug(15) <= M.LeftClick;
    Debug(14) <= M.RightClick;
    
    Debug(12) <= '1' when M.X = 0 else '0';
    Debug(11) <= '1' when M.Y = 0 else '0';
    Debug(10) <= '1' when M.Z = 0 else '0';
    
    Decode_Message: MouseDecoder port map (
        Reset => Reset,
        MouseClock => MouseClock,
        MouseData => MouseData,
        MouseMessage => M,
        NewMessage => NewMessage
    );
        
    Display_Number: SSGDisplay port map (Clock, Number, Segments, Anodes);
end Behavioral;
