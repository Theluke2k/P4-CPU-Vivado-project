
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;


package Constants is

    -- OPCODE
    constant IDL : std_logic_vector(5 downto 0) := "000000";
    constant ADD : std_logic_vector(5 downto 0) := "000001";
    constant SUB : std_logic_vector(5 downto 0) := "000010";
    constant MUL : std_logic_vector(5 downto 0) := "000011";
    constant DIV : std_logic_vector(5 downto 0) := "000100";
    constant JMP : std_logic_vector(5 downto 0) := "000101";
    constant LDR : std_logic_vector(5 downto 0) := "000110";
    constant STR : std_logic_vector(5 downto 0) := "000111";
    constant LRI : std_logic_vector(5 downto 0) := "001000";
    constant SIN : std_logic_vector(5 downto 0) := "001001";
    constant COS : std_logic_vector(5 downto 0) := "001010";
    constant ACS : std_logic_vector(5 downto 0) := "001011";
    constant CMP : std_logic_vector(5 downto 0) := "001100";
    constant SCF : std_logic_vector(5 downto 0) := "001101";
    constant SCA : std_logic_vector(5 downto 0) := "001110";
    constant BUA : std_logic_vector(5 downto 0) := "001111";
    constant LDU : std_logic_vector(5 downto 0) := "010000";
    constant BRW : std_logic_vector(5 downto 0) := "010001";
    constant PTO : std_logic_vector(5 downto 0) := "010010";
    
end Constants;

package body Constants is
end Constants;
