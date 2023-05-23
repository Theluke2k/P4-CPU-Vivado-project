----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2023 21:46:35
-- Design Name: 
-- Module Name: GPR_Regs - Behavioral
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

entity GPR_Regs is
    Port
    (
        -- INS
        i_clk : in STD_LOGIC;
        i_ldReg : in std_logic;
        i_RSA : in std_logic_vector(5 downto 0); -- Two selects if two registers are to be read at the same time
        i_RSB : in std_logic_vector(5 downto 0); 
        i_RIN : in std_logic_vector(31 downto 0); -- Only one input data since we only write to one register at a time.
    
        --OUTS
        o_ROA : out std_logic_vector(31 downto 0);
        o_ROB : out std_logic_vector(31 downto 0)
    );
end GPR_Regs;

architecture Behavioral of GPR_Regs is
    signal reg0 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg1 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg2 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg3 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg4 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg5 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg6 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg7 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg8 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg9 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg10 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg11 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg12 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg13 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg14 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg15 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg16 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg17 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg18 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg19 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg20 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg21 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg22 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg23 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg24 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg25 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg26 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg27 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg28 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg29 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg30 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg31 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg32 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg33 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg34 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg35 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg36 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg37 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg38 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg39 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg40 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg41 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg42 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg43 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg44 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg45 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg46 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg47 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg48 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg49 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg50 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg51 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg52 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg53 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg54 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg55 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg56 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg57 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg58 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg59 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg60 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg61 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg62 : std_logic_vector(31 downto 0) := (others => '0');
    signal reg63 : std_logic_vector(31 downto 0) := (others => '0');
    
begin
    GPR_Regs : process(i_clk)
    begin
        if(rising_edge(i_clk)) then
            if(i_ldReg = '1') then
                if(i_RSA = "000000") then
                    reg0 <= i_RIN;
                elsif(i_RSA = "000001") then
                    reg1 <= i_RIN;
                elsif(i_RSA = "000010") then
                    reg2 <= i_RIN;
                elsif(i_RSA = "000011") then
                    reg3 <= i_RIN;
                elsif(i_RSA = "000100") then
                    reg4 <= i_RIN;
                elsif(i_RSA = "000101") then
                    reg5 <= i_RIN;
                elsif(i_RSA = "000110") then
                    reg6 <= i_RIN;
                elsif(i_RSA = "000111") then
                    reg7 <= i_RIN;
                elsif(i_RSA = "001000") then
                    reg8 <= i_RIN;
                elsif(i_RSA = "001001") then
                    reg9 <= i_RIN;
                elsif(i_RSA = "001010") then
                    reg10 <= i_RIN;
                elsif(i_RSA = "001011") then
                    reg11 <= i_RIN;
                elsif(i_RSA = "001100") then
                    reg12 <= i_RIN;
                elsif(i_RSA = "001101") then
                    reg13 <= i_RIN;
                elsif(i_RSA = "001110") then
                    reg14 <= i_RIN;
                elsif(i_RSA = "001111") then
                    reg15 <= i_RIN;
                elsif(i_RSA = "010000") then
                    reg16 <= i_RIN;
                elsif(i_RSA = "010001") then
                    reg17 <= i_RIN;
                elsif(i_RSA = "010010") then
                    reg18 <= i_RIN;
                elsif(i_RSA = "010011") then
                    reg19 <= i_RIN;
                elsif(i_RSA = "010100") then
                    reg20 <= i_RIN;
                elsif(i_RSA = "010101") then
                    reg21 <= i_RIN;
                elsif(i_RSA = "010110") then
                    reg22 <= i_RIN;
                elsif(i_RSA = "010111") then
                    reg23 <= i_RIN;
                elsif(i_RSA = "011000") then
                    reg24 <= i_RIN;
                elsif(i_RSA = "011001") then
                    reg25 <= i_RIN;
                elsif(i_RSA = "011010") then
                    reg26 <= i_RIN;
                elsif(i_RSA = "011011") then
                    reg27 <= i_RIN;
                elsif(i_RSA = "011100") then
                    reg28 <= i_RIN;
                elsif(i_RSA = "011101") then
                    reg29 <= i_RIN;
                elsif(i_RSA = "011110") then
                    reg30 <= i_RIN;
                elsif(i_RSA = "011111") then
                    reg31 <= i_RIN;
                elsif(i_RSA = "100000") then
                    reg32 <= i_RIN;
                elsif(i_RSA = "100001") then
                    reg33 <= i_RIN;
                elsif(i_RSA = "100010") then
                    reg34 <= i_RIN;
                elsif(i_RSA = "100011") then
                    reg35 <= i_RIN;
                elsif(i_RSA = "100100") then
                    reg36 <= i_RIN;
                elsif(i_RSA = "100101") then
                    reg37 <= i_RIN;
                elsif(i_RSA = "100110") then
                    reg38 <= i_RIN;
                elsif(i_RSA = "100111") then
                    reg39 <= i_RIN;
                elsif(i_RSA = "101000") then
                    reg40 <= i_RIN;
                elsif(i_RSA = "101001") then
                    reg41 <= i_RIN;
                elsif(i_RSA = "101010") then
                    reg42 <= i_RIN;
                elsif(i_RSA = "101011") then
                    reg43 <= i_RIN;
                elsif(i_RSA = "101100") then
                    reg44 <= i_RIN;
                elsif(i_RSA = "101101") then
                    reg45 <= i_RIN;
                elsif(i_RSA = "101110") then
                    reg46 <= i_RIN;
                elsif(i_RSA = "101111") then
                    reg47 <= i_RIN;
                elsif(i_RSA = "110000") then
                    reg48 <= i_RIN;
                elsif(i_RSA = "110001") then
                    reg49 <= i_RIN;
                elsif(i_RSA = "110010") then
                    reg50 <= i_RIN;
                elsif(i_RSA = "110011") then
                    reg51 <= i_RIN;
                elsif(i_RSA = "110100") then
                    reg52 <= i_RIN;
                elsif(i_RSA = "110101") then
                    reg53 <= i_RIN;
                elsif(i_RSA = "110110") then
                    reg54 <= i_RIN;
                elsif(i_RSA = "110111") then
                    reg55 <= i_RIN;
                elsif(i_RSA = "111000") then
                    reg56 <= i_RIN;
                elsif(i_RSA = "111001") then
                    reg57 <= i_RIN;
                elsif(i_RSA = "111010") then
                    reg58 <= i_RIN;
                elsif(i_RSA = "111011") then
                    reg59 <= i_RIN;
                elsif(i_RSA = "111100") then
                    reg60 <= i_RIN;
                elsif(i_RSA = "111101") then
                    reg61 <= i_RIN;
                elsif(i_RSA = "111110") then
                    reg62 <= i_RIN;
                elsif(i_RSA = "111111") then
                    reg63 <= i_RIN;    
                end if;
            end if;
        end if;
    end process;
    
    o_ROA <= reg0 when (i_RSA = "000000") else
                  reg1 when (i_RSA = "000001") else
                  reg2 when (i_RSA = "000010") else
                  reg3 when (i_RSA = "000011") else
                  reg4 when (i_RSA = "000100") else
                  reg5 when (i_RSA = "000101") else
                  reg6 when (i_RSA = "000110") else
                  reg7 when (i_RSA = "000111") else
                  reg8 when (i_RSA = "001000") else
                  reg9 when (i_RSA = "001001") else
                  reg10 when (i_RSA = "001010") else
                  reg11 when (i_RSA = "001011") else
                  reg12 when (i_RSA = "001100") else
                  reg13 when (i_RSA = "001101") else
                  reg14 when (i_RSA = "001110") else
                  reg15 when (i_RSA = "001111") else
                  reg16 when (i_RSA = "010000") else
                  reg17 when (i_RSA = "010001") else
                  reg18 when (i_RSA = "010010") else
                  reg19 when (i_RSA = "010011") else
                  reg20 when (i_RSA = "010100") else
                  reg21 when (i_RSA = "010101") else
                  reg22 when (i_RSA = "010110") else
                  reg23 when (i_RSA = "010111") else
                  reg24 when (i_RSA = "011000") else
                  reg25 when (i_RSA = "011001") else
                  reg26 when (i_RSA = "011010") else
                  reg27 when (i_RSA = "011011") else
                  reg28 when (i_RSA = "011100") else
                  reg29 when (i_RSA = "011101") else
                  reg30 when (i_RSA = "011110") else
                  reg31 when (i_RSA = "011111") else
                  reg32 when (i_RSA = "100000") else
                  reg33 when (i_RSA = "100001") else
                  reg34 when (i_RSA = "100010") else
                  reg35 when (i_RSA = "100011") else
                  reg36 when (i_RSA = "100100") else
                  reg37 when (i_RSA = "100101") else
                  reg38 when (i_RSA = "100110") else
                  reg39 when (i_RSA = "100111") else
                  reg40 when (i_RSA = "101000") else
                  reg41 when (i_RSA = "101001") else
                  reg42 when (i_RSA = "101010") else
                  reg43 when (i_RSA = "101011") else
                  reg44 when (i_RSA = "101100") else
                  reg45 when (i_RSA = "101101") else
                  reg46 when (i_RSA = "101110") else
                  reg47 when (i_RSA = "101111") else
                  reg48 when (i_RSA = "110000") else
                  reg49 when (i_RSA = "110001") else
                  reg50 when (i_RSA = "110010") else
                  reg51 when (i_RSA = "110011") else
                  reg52 when (i_RSA = "110100") else
                  reg53 when (i_RSA = "110101") else
                  reg54 when (i_RSA = "110110") else
                  reg55 when (i_RSA = "110111") else
                  reg56 when (i_RSA = "111000") else
                  reg57 when (i_RSA = "111001") else
                  reg58 when (i_RSA = "111010") else
                  reg59 when (i_RSA = "111011") else
                  reg60 when (i_RSA = "111100") else
                  reg61 when (i_RSA = "111101") else
                  reg62 when (i_RSA = "111110") else
                  reg63 when (i_RSA = "111111") else
                  x"00000000";
    o_ROB <= reg0 when (i_RSB = "000000") else
                  reg1 when (i_RSB = "000001") else
                  reg2 when (i_RSB = "000010") else
                  reg3 when (i_RSB = "000011") else
                  reg4 when (i_RSB = "000100") else
                  reg5 when (i_RSB = "000101") else
                  reg6 when (i_RSB = "000110") else
                  reg7 when (i_RSB = "000111") else
                  reg8 when (i_RSB = "001000") else
                  reg9 when (i_RSB = "001001") else
                  reg10 when (i_RSB = "001010") else
                  reg11 when (i_RSB = "001011") else
                  reg12 when (i_RSB = "001100") else
                  reg13 when (i_RSB = "001101") else
                  reg14 when (i_RSB = "001110") else
                  reg15 when (i_RSB = "001111") else
                  reg16 when (i_RSB = "010000") else
                  reg17 when (i_RSB = "010001") else
                  reg18 when (i_RSB = "010010") else
                  reg19 when (i_RSB = "010011") else
                  reg20 when (i_RSB = "010100") else
                  reg21 when (i_RSB = "010101") else
                  reg22 when (i_RSB = "010110") else
                  reg23 when (i_RSB = "010111") else
                  reg24 when (i_RSB = "011000") else
                  reg25 when (i_RSB = "011001") else
                  reg26 when (i_RSB = "011010") else
                  reg27 when (i_RSB = "011011") else
                  reg28 when (i_RSB = "011100") else
                  reg29 when (i_RSB = "011101") else
                  reg30 when (i_RSB = "011110") else
                  reg31 when (i_RSB = "011111") else
                  reg32 when (i_RSB = "100000") else
                  reg33 when (i_RSB = "100001") else
                  reg34 when (i_RSB = "100010") else
                  reg35 when (i_RSB = "100011") else
                  reg36 when (i_RSB = "100100") else
                  reg37 when (i_RSB = "100101") else
                  reg38 when (i_RSB = "100110") else
                  reg39 when (i_RSB = "100111") else
                  reg40 when (i_RSB = "101000") else
                  reg41 when (i_RSB = "101001") else
                  reg42 when (i_RSB = "101010") else
                  reg43 when (i_RSB = "101011") else
                  reg44 when (i_RSB = "101100") else
                  reg45 when (i_RSB = "101101") else
                  reg46 when (i_RSB = "101110") else
                  reg47 when (i_RSB = "101111") else
                  reg48 when (i_RSB = "110000") else
                  reg49 when (i_RSB = "110001") else
                  reg50 when (i_RSB = "110010") else
                  reg51 when (i_RSB = "110011") else
                  reg52 when (i_RSB = "110100") else
                  reg53 when (i_RSB = "110101") else
                  reg54 when (i_RSB = "110110") else
                  reg55 when (i_RSB = "110111") else
                  reg56 when (i_RSB = "111000") else
                  reg57 when (i_RSB = "111001") else
                  reg58 when (i_RSB = "111010") else
                  reg59 when (i_RSB = "111011") else
                  reg60 when (i_RSB = "111100") else
                  reg61 when (i_RSB = "111101") else
                  reg62 when (i_RSB = "111110") else
                  reg63 when (i_RSB = "111111") else
                  x"00000000";
end Behavioral;
