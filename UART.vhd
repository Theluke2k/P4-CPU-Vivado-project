----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2023 15:39:06
-- Design Name: 
-- Module Name: UART - Behavioral
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

entity UART is
  Port
  (
    i_clk : in std_logic;
    i_PAR : in std_logic_vector(3 downto 0);
    o_PDR : out std_logic_vector(31 downto 0);
    o_status : out std_logic
  );
end UART;

architecture Behavioral of UART is
    type mem is array(0 to 9) of std_logic_vector(31 downto 0);
    signal mem_10 : mem;
    signal w_UARTOutputData : std_logic_vector(31 downto 0);
begin
    process(i_clk)
    begin
        if(rising_edge(i_clk)) then
            w_UARTOutputData <= mem_10(to_integer(unsigned(i_PAR)));
        end if;
    end process;
    o_PDR <= w_UARTOutputData;
    
    o_status <= '0'
                when
                (mem_10(0) = x"00000000") or
                (mem_10(1) = x"00000000") or
                (mem_10(2) = x"00000000") or
                (mem_10(3) = x"00000000") or
                (mem_10(4) = x"00000000") or
                (mem_10(5) = x"00000000") or
                (mem_10(6) = x"00000000") or
                (mem_10(7) = x"00000000") or
                (mem_10(8) = x"00000000") or
                (mem_10(9) = x"00000000")
                else '1';
                
    mem_10(0) <= "00000000000000000000010000000000";
    mem_10(1) <= "00000000000000000000010000000000";
    mem_10(2) <= "00000000000000000000010000000000";
    mem_10(3) <= "00000000000000000000010000000000";
    mem_10(4) <= "00000000000000000000010000000000";
    mem_10(5) <= "00000000000000000001100001100100";
    mem_10(6) <= "00000000000000000000010000000000";
    mem_10(7) <= "00000000000000000000010000000000";
    mem_10(8) <= "00000000000000000000010000000000";
    mem_10(9) <= "00000000000000000000010000000000";
end Behavioral;
