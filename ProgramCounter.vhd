----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2023 09:18:33
-- Design Name: 
-- Module Name: CPU_Top - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity ProgramCounter is
    Port (
        -- Ins
        i_clk : in std_logic;
        i_loadPC : in std_logic;
        i_incPC : in std_logic;
        i_PCLdVal : in std_logic_vector(11 downto 0);
        -- Outs
        o_ProgCtr : OUT STD_LOGIC_VECTOR(11 downto 0)
    );
end ProgramCounter;

architecture Behavioral of ProgramCounter is
    signal w_ProgCtr : std_logic_vector(11 downto 0) := (others => '0');
begin
   progCtr : process(i_clk)
   begin
       if(falling_edge(i_clk)) then
           if(i_loadPC = '1') then
               w_ProgCtr <= i_PCLdVal;
           elsif(i_incPC = '1') then
               w_ProgCtr <= std_logic_vector(unsigned(w_ProgCtr) + 1);
           end if;
       end if;
   end process;
   
   o_ProgCtr <= w_ProgCtr;
end Behavioral;
