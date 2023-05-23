----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.05.2023 20:34:47
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.numeric_std.ALL;
use ieee.std_logic_unsigned.all;
library work;
use work.Constants.all;

entity ALU is
    Port
    (
        -- INS
        i_clk : in STD_LOGIC;
        i_ALU_A_In : in std_logic_vector(31 downto 0);
        i_ALU_B_In : in std_logic_vector(31 downto 0);
        i_OPCODE : std_logic_vector(5 downto 0);
        i_state : std_logic_vector(2 downto 0);
        
        -- OUTS
        o_ALU_Out : inout std_logic_vector(31 downto 0);
        o_FWT : out std_logic
    );
end ALU;

architecture Behavioral of ALU is
    -- General
    signal w_ALU_Out : signed(31 downto 0);
    signal w_FWT : std_logic;

    signal w_result_ADD_SUB : signed(31 downto 0);
    signal w_result_MUL : signed(63 downto 0);
    signal w_result_DIV : signed(39 downto 0);
    signal w_result_SCF : signed(31 downto 0);
    signal w_result_SCA : signed(31 downto 0);

    -- For compare function
    signal w_result_CMP : signed(31 downto 0);
    signal w_isBigger : std_logic;
    
    -- For negative denominators
    signal inputBTemp : signed(31 downto 0);
    signal resultCTemp : signed(39 downto 0);
    signal negDenominator : std_logic := '0';
    
    -- Trigo
    signal w_inputUpscaled : std_logic_vector(31 downto 0);
    signal w_inputNormalize : std_logic_vector(47 downto 0);
    signal w_inputCutInteger : std_logic_vector(31 downto 0);
    signal w_powerTWO : signed(63 downto 0);
    
    -- SINE
    signal w_result_SIN : signed(95 downto 0);
    signal w_twoPI : std_logic_vector(31 downto 0) := "00000000000001100100100010000000"; -- 6.2832
    signal w_FS15 : std_logic_vector(31 downto 0) := "00000000000000001011011111011000"; -- 0.71814
    signal w_FS13 : std_logic_vector(31 downto 0) := "00000000000000111101000111111000"; -- 3.8202
    signal w_FS11 : std_logic_vector(31 downto 0) := "00000000000011110001100001000000"; -- 15.095
    signal w_FS9 : std_logic_vector(31 downto 0) := "00000000001010100000111100000000"; -- 42.059
    signal w_FS7 : std_logic_vector(31 downto 0) := "00000000010011001011010100000000"; -- 76.707
    signal w_FS5 : std_logic_vector(31 downto 0) := "00000000010100011001101101000000"; -- 81.606
    signal w_FS3 : std_logic_vector(31 downto 0) := "00000000001010010101011100000000"; -- 41.340
    
    -- SINE temporary values
    signal w_TS1 : signed(63 downto 0);
    signal w_TS2 : signed(63 downto 0);
    signal w_TS3 : signed(63 downto 0);
    signal w_TS4 : signed(63 downto 0);
    signal w_TS5 : signed(63 downto 0);
    signal w_TS6 : signed(63 downto 0);
    signal w_TS7 : signed(63 downto 0);
    signal w_TS8 : signed(63 downto 0);
    
    -- COSINE
    signal w_FC16 : std_logic_vector(31 downto 0) := "00000000000000000100100000110011"; -- 0.71814
    signal w_FC14 : std_logic_vector(31 downto 0) := "00000000000000011011011011101000"; -- 0.71814
    signal w_FC12 : std_logic_vector(31 downto 0) := "00000000000001111110011101100000"; -- 3.8202
    signal w_FC10 : std_logic_vector(31 downto 0) := "00000000000110100110110101000000"; -- 15.095
    signal w_FC8 : std_logic_vector(31 downto 0) := "00000000001111000011111100000000"; -- 42.059
    signal w_FC6 : std_logic_vector(31 downto 0) := "00000000010101010111010101000000"; -- 76.707
    signal w_FC4 : std_logic_vector(31 downto 0) := "00000000010000001111000011000000"; -- 81.606
    signal w_FC2 : std_logic_vector(31 downto 0) := "00000000000100111011110101000000"; -- 41.340
    
    -- COSINE temporary values
    signal w_TC1 : signed(63 downto 0);
    signal w_TC2 : signed(63 downto 0);
    signal w_TC3 : signed(63 downto 0);
    signal w_TC4 : signed(63 downto 0);
    signal w_TC5 : signed(63 downto 0);
    signal w_TC6 : signed(63 downto 0);
    signal w_TC7 : signed(63 downto 0);
    signal w_TC8 : signed(63 downto 0);
    signal w_TC9 : signed(31 downto 0);
    
    -- INVERSE COSINE
    signal w_halfPI : std_logic_vector(31 downto 0) := "00000000000000011001001000100000"; -- 1.5708
    signal w_ICC3 : std_logic_vector(31 downto 0) := "00000000000000000000101101101110"; -- 0.044647
    signal w_ICC2 : std_logic_vector(31 downto 0) := "00000000000000000001001100110011"; -- 0.074997
    signal w_ICC1 : std_logic_vector(31 downto 0) := "00000000000000000001010101010101"; -- 0.083328
    signal w_CosInv_powerTWO : signed(63 downto 0);

    -- INVERSE COSINE temporary values
    signal w_TIC1 : signed(63 downto 0);
    signal w_TIC2 : signed(63 downto 0);
    signal w_TIC3 : signed(63 downto 0);
    signal w_TIC4 : signed(63 downto 0);
    signal w_TIC5 : signed(31 downto 0);
begin
    update : process(i_clk)
    begin
        if(falling_edge(i_clk)) then
            o_FWT <= w_FWT;
        end if;
    end process;
    
    o_ALU_Out <= std_logic_vector(w_ALU_Out);
    --o_ALU_Out <= std_logic_vector(w_ALU_Out) when falling_edge(i_clk);
    --o_FWT <= w_FWT when falling_edge(i_clk);
    
    
    -- ADD and SUB operation
    w_result_ADD_SUB <= (signed(i_ALU_A_In) + signed(i_ALU_B_In)) when (i_OPCODE = ADD) else
                 (signed(i_ALU_A_In) - signed(i_ALU_B_In)) when (i_OPCODE = SUB) else
                 x"00000000";
    
    -- Multiply operation
    w_result_MUL <= (signed(i_ALU_A_In) * signed(i_ALU_B_In)) when (i_OPCODE = MUL) else
                 x"0000000000000000";
    
    -- Divide operation
    w_result_DIV <= (others => '0') when (i_ALU_B_In = x"00000000") else
                    (signed(i_ALU_A_In & "00000000") / signed("00000000" & i_ALU_B_In)) when (i_OPCODE = DIV and negDenominator = '0') else
                    (not(resultCTemp) + 1) when (i_OPCODE = DIV and negDenominator = '1' and resultCTemp(34) = '0') else
                    not(resultCTemp - 1) when (i_OPCODE = DIV and negDenominator = '1' and resultCTemp(34) = '1') else
                    (others => '0');
    
    -- Temporaries for negative denominators in divide operations       
    resultCTemp <= (others => '0') when (inputBTemp = x"00000000") else
                   (signed(i_ALU_A_In & "00000000") / signed("00000000" & inputBTemp));
    negDenominator <= i_ALU_B_In(31);
    inputBTemp <= not(signed(i_ALU_B_In) - 1);
    
    -- Scale frequency operation (SCF)
    w_result_SCF <= "00000000000000000000" & (signed(i_ALU_A_In(13 downto 10)) & "00000000") when (i_OPCODE = SCF) else
                    (others => '0');
    -- Scale amplitude operation (SCA)
    w_result_SCA <= "00000000000000" & (signed(i_ALU_A_In(9 downto 0)) & "00000000") when (i_OPCODE = SCA) else
                    (others => '0');

    -- Compare functionality (CMP)
    w_isBigger <= '1' when (unsigned(i_ALU_A_In(9 downto 0)) > unsigned(i_ALU_B_In(9 downto 0))) else '0';
    
    w_result_CMP <= signed(i_ALU_A_In) when (w_isBigger = '1') else
                    signed(i_ALU_B_In) when (w_isBigger = '0');
    
    --w_inputA <= inputA(23 downto 0) & "00000000";
    w_inputUpscaled <= i_ALU_A_In(23 downto 0) & "00000000" when (i_OPCODE = SIN or i_OPCODE = COS or i_OPCODE = ACS) else
                       (others => '0');
    w_inputNormalize <= std_logic_vector(signed(w_inputUpscaled & "0000000000000000") / signed("0000000000000000" & w_twoPI));
    w_inputCutInteger <= "0000000000000000" & w_inputNormalize(15 downto 0);
    w_powerTWO <= signed(w_inputNormalize(31 downto 0)) * signed(w_inputNormalize(31 downto 0)); -- x*x
    
    -- SINE
    w_TS1 <= w_powerTWO(47 downto 16) * signed(w_FS15);
    w_TS2 <= w_powerTWO(47 downto 16) * (signed(w_FS13) - w_TS1(47 downto 16));
    w_TS3 <= w_powerTWO(47 downto 16) * (signed(w_FS11) - w_TS2(47 downto 16));
    w_TS4 <= w_powerTWO(47 downto 16) * (signed(w_FS9) - w_TS3(47 downto 16));
    w_TS5 <= w_powerTWO(47 downto 16) * (signed(w_FS7) - w_TS4(47 downto 16));
    w_TS6 <= w_powerTWO(47 downto 16) * (signed(w_FS5) - w_TS5(47 downto 16));
    w_TS7 <= w_powerTWO(47 downto 16) * (signed(w_FS3) - w_TS6(47 downto 16));
    w_TS8 <= signed(w_inputCutInteger) * (signed(w_twoPI) - w_TS7(47 downto 16));

    -- COSINE
    w_TC1 <= w_powerTWO(47 downto 16) * signed(w_FC16);
    w_TC2 <= w_powerTWO(47 downto 16) * (signed(w_FC14) - w_TC1(47 downto 16));
    w_TC3 <= w_powerTWO(47 downto 16) * (signed(w_FC12) - w_TC2(47 downto 16));
    w_TC4 <= w_powerTWO(47 downto 16) * (signed(w_FC10) - w_TC3(47 downto 16));
    w_TC5 <= w_powerTWO(47 downto 16) * (signed(w_FC8) - w_TC4(47 downto 16));
    w_TC6 <= w_powerTWO(47 downto 16) * (signed(w_FC6) - w_TC5(47 downto 16));
    w_TC7 <= w_powerTWO(47 downto 16) * (signed(w_FC4) - w_TC6(47 downto 16));
    w_TC8 <= w_powerTWO(47 downto 16) * (signed(w_FC2) - w_TC7(47 downto 16));
    w_TC9 <= 65536 - w_TC8(47 downto 16);
    
    -- INVERSE COSINE
    w_CosInv_powerTWO <= signed(w_inputUpscaled) * signed(w_inputUpscaled);
    w_TIC1 <= w_CosInv_powerTWO(47 downto 16) * signed(w_ICC3);
    w_TIC2 <= w_CosInv_powerTWO(47 downto 16) * (signed(w_ICC2) + w_TIC1(47 downto 16));
    w_TIC3 <= w_CosInv_powerTWO(47 downto 16) * (signed(w_ICC1) + w_TIC2(47 downto 16));
    w_TIC4 <= signed(w_inputUpscaled) * (65536 + w_TIC3(47 downto 16));
    w_TIC5 <= signed(w_halfPI) - w_TIC4(47 downto 16);
    
    -- General ALU output
    w_ALU_Out <= w_result_ADD_SUB when ((i_OPCODE = ADD) or (i_OPCODE = SUB)) else
                 w_result_MUL(39 downto 8) when ((i_OPCODE = MUL)) else
                 w_result_DIV(31 downto 0) when ((i_OPCODE = DIV)) else
                 w_result_SCF when (i_OPCODE = SCF) else
                 w_result_SCA when (i_OPCODE = SCA) else
                 w_result_CMP when (i_OPCODE = CMP) else
                 w_TS8(55 downto 24) when (i_OPCODE = SIN) else
                 "00000000000000000000000000000000" when (i_OPCODE = COS and (w_TC9(31 downto 8) = "111111111111111111111111")) else
                 "00000000000000000000000000000000" when (i_OPCODE = ACS and (w_TIC5(31 downto 8) = "111111111111111111111111")) else
                 signed("00000000" & std_logic_vector(w_TC9(31 downto 8))) when (i_OPCODE = COS and w_TC9(31) = '0') else
                 signed("11111111" & std_logic_vector(w_TC9(31 downto 8))) when (i_OPCODE = COS and w_TC9(31) = '1') else
                 signed("00000000" & std_logic_vector(w_TIC5(31 downto 8))) when (i_OPCODE = ACS and w_TIC5(31) = '0') else
                 signed("11111111" & std_logic_vector(w_TIC5(31 downto 8))) when (i_OPCODE = ACS and w_TIC5(31) = '1') else
                 signed(i_ALU_A_In);
    
    -- The flag only works if it is used in the instruction after it is set     
    w_FWT <= '1' when ((unsigned(i_ALU_A_In) > x"00000500") and i_state = "010") else
             '1' when ((unsigned(i_ALU_A_In) = x"00000500") and i_state = "010") else
             '0' when ((unsigned(i_ALU_A_In) < x"00000500") and i_state = "010");
end Behavioral;
