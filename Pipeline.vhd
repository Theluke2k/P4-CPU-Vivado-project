----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2023 16:51:07
-- Design Name: 
-- Module Name: Pipeline - Behavioral
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

entity Pipeline is
    Port
    (
        i_clk : in STD_LOGIC;
        i_rst : in STD_LOGIC;
        o_state : inout std_logic_vector(2 downto 0)
    );
end Pipeline;

architecture Behavioral of Pipeline is
    signal w_state : std_logic_vector(2 downto 0);
begin
    w_state <= "000" when (i_rst = '1') else
               "001" when (o_state = "000") else
               "010" when (o_state = "001") else
               "011" when (o_state = "010") else
               "100" when (o_state = "011") else
               "000";
    
    Pipeline : process(i_clk)
    begin
        if(rising_edge(i_clk)) then
            o_state <= w_state;
        end if;
    end process;
end Behavioral;
