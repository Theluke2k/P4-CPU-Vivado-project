----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2023 21:43:01
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

library work;
use work.Constants.all;

entity CPU_Top is
    Port ( 
        i_sysclk : in STD_LOGIC;
        o_Output : out std_logic_vector(11 downto 0)
    );
end CPU_Top;

architecture Behavioral of CPU_Top is
    -- Clock
    --constant ClockPeriode:    time    := 1000ms / 1e6; -- Periode
    --signal i_clk: std_logic :='1';    
    signal w_clk_reset : std_logic := '0';
    signal w_clk_locked : std_logic := '0';
    signal w_clk : std_logic := '0';
    
    -- Output
    signal w_RO : std_logic_vector(31 downto 0) := x"FFFFFFFF";
    
                            -- Klokken
    -- General purpose registers (GPR_Reg)
    signal w_ldReg : std_logic := '0';
    signal w_RSA : std_logic_vector(5 downto 0) := (others => '0');
    signal w_RSB : std_logic_vector(5 downto 0) := (others => '0');
    signal w_RIN : std_logic_vector(31 downto 0);
    signal w_ROA : std_logic_vector(31 downto 0);
    signal w_ROB : std_logic_vector(31 downto 0);
    
    -- Special purpose registers
      -- Program counter
    signal w_loadPC : std_logic := '0';
    signal w_incPC : std_logic := '1';
    signal w_PCLdVal : std_logic_vector(11 downto 0);
    signal w_PC : std_logic_vector(11 downto 0) := (others => '0');
    
    -- Pipeline
    signal w_state : std_logic_vector(2 downto 0);
    signal w_pipeRst : std_logic := '0';
    signal w_fetch : std_logic := '0';
    signal w_decode : std_logic := '0';
    signal w_execute : std_logic := '0';
    signal w_memory : std_logic := '0';
    signal w_writeback : std_logic := '0';
    signal w_ALUTEMP : std_logic_vector(31 downto 0) := x"FFFFFFFF";
    
    -- ALU
    signal w_ALU_A_In : std_logic_vector(31 downto 0);
    signal w_ALU_B_In : std_logic_vector(31 downto 0);
    signal w_OPCODE : std_logic_vector(5 downto 0);
    signal w_ALU_Out : std_logic_vector(31 downto 0);
    signal w_FWT : std_logic;
    
    -- ROM
    signal w_ROM_Addr : std_logic_vector(11 downto 0) := (others => '0');
    signal w_ROM_Out : std_logic_vector(31 downto 0);
    signal w_ROM_En : std_logic := '1';
    
    -- SRAM
    signal w_SRAM_Addr : std_logic_vector(11 downto 0);
    signal w_SRAM_DIn : std_logic_vector(31 downto 0) := (others => '0');
    signal w_SRAM_Out : std_logic_vector(31 downto 0);
    signal w_SRAM_En : std_logic := '1';
    signal w_SRAM_We : std_logic_vector(0 downto 0) := "0";
    
    -- UART
    signal w_PAR : std_logic_vector(3 downto 0);
    signal w_PDR : std_logic_vector(31 downto 0);
    signal w_UARTstatus : std_logic;
    
    -- Instruction register
    signal w_IR : std_logic_vector(31 downto 0) := x"00000000";
    
    -- Pipeline registers
--    signal w_regAData : std_logic_vector(31 downto 0);
--    signal w_regAData : std_logic_vector(31 downto 0);
    
    --Control signals
--    component clk_wiz_0
--    port
--    (-- Clock in ports
--    -- Clock out ports
--        clk_out1          : out    std_logic;
--        clk_in1           : in     std_logic
--    );
--    end component;
    
begin
    ----- COMPONENT INSTANTIATION -----
    --Clock
--  Clock : clk_wiz_0
--   port map ( 
--  -- Clock out ports  
--   clk_out1 => w_clk,
--   -- Clock in ports
--   clk_in1 => sysclk
-- );
    -- General purpose registers
    GPR_Regs : entity work.GPR_Regs 
    Port map
    (
        -- INS
        i_clk => w_clk,
        i_ldReg => w_ldReg,
        i_RSA => w_RSA,
        i_RSB => w_RSB,
        i_RIN => w_RIN,
        
        --OUTS
        o_ROA => w_ROA,
        o_ROB => w_ROB  
    );
    
    -- Special purpose registers
    progCtr : entity work.ProgramCounter
    Port map
    (
        -- Ins
        i_clk  => w_clk,          -- Clock 50 MHz
        i_loadPC => w_loadPC,     -- Load PC control
        i_incPC => w_incPC,       -- Increment PC control
        i_PCLdVal => w_PCLdVal,  -- Load PC value
        -- Outs
        o_ProgCtr => w_PC    -- Program Counter
    );
    
    -- Pipeline (state control)
    Pipeline : entity work.Pipeline
    Port map
    (
        i_clk => w_clk,
        i_rst => w_pipeRst,
        o_state => w_state
    );
    
    -- Arithmetic logic unit
    ALU : entity work.ALU
    Port map
    (
        -- INS
        i_clk => w_clk,
        i_ALU_A_In => w_ALU_A_In,
        i_ALU_B_In => w_ALU_B_In,
        i_OPCODE  => w_OPCODE,
        i_state => w_state,
        
        -- OUTS
        o_ALU_Out  => w_ALU_Out,
        o_FWT => w_FWT
    );
    
    -- ROM memory (instructions)
    ROM : entity work.ROM_wrapper 
    port map(
        BRAM_PORTA_0_addr => w_ROM_Addr,
        BRAM_PORTA_0_clk => w_clk,
        BRAM_PORTA_0_dout => w_ROM_Out,
        BRAM_PORTA_0_en => w_ROM_En
    );
    
    -- SRAM memory (data)
    SRAM : entity work.SRAM_wrapper
    port map
    (
        BRAM_PORTA_0_addr => w_SRAM_Addr,
        BRAM_PORTA_0_clk => w_clk,
        BRAM_PORTA_0_din => w_SRAM_DIn,
        BRAM_PORTA_0_dout => w_SRAM_Out,
        BRAM_PORTA_0_en => w_SRAM_En,
        BRAM_PORTA_0_we => w_SRAM_We
    );
    
    -- UART
    UART : entity work.UART
    Port map
    (
        i_clk => w_clk,
        i_PAR => w_PAR,
        o_PDR => w_PDR,
        o_status => w_UARTstatus
    );
    
    -- Clock
    --i_clk <= not i_clk after ClockPeriode/2;
    w_clk <= i_sysclk;
    
    ----- GLOBAL CONTROL -----
    -- Pipeline state machine enable signals
    w_fetch <= '1' when (w_state = "000") else '0';
    w_decode <= '1' when (w_state = "001") else '0';
    w_execute <= '1' when (w_state = "010") else '0';
    w_memory <= '1' when (w_state = "011") else '0';
    w_writeback <= '1' when (w_state = "100") else '0';
    
    ---------- NORMAL OPERATION ----------
    ----- FETCH -----
    w_ROM_Addr <= w_PC;
    w_incPC <= '1' when w_fetch ='1' else '0';
    
    ----- DECODE -----
    w_IR <= w_ROM_Out when (w_decode = '1');
    w_OPCODE <= w_IR(31 downto 26) when (w_decode = '1');
    
    -- Register reads in decode stage
    w_RSA <= w_IR(5 downto 0) when (w_decode = '1' and w_OPCODE = SIN) else
                 w_IR(5 downto 0) when (w_decode = '1' and w_OPCODE = COS) else
                 w_IR(5 downto 0) when (w_decode = '1' and w_OPCODE = ACS) else
                 w_IR(5 downto 0) when (w_decode = '1' and w_OPCODE = PTO) else
                 w_IR(25 downto 20) when (w_writeback = '1') else
                 w_IR(11 downto 6) when (w_decode = '1');
                            
    w_RSB <= w_IR(5 downto 0) when (w_decode = '1');
    
    -- Set the peripheral address register to the source in the instrution.
    w_PAR <= w_IR(3 downto 0) when (w_decode = '1' and w_OPCODE = LDU) else
                    "0000";
    
    -- For jump or branch instructions
    w_loadPC <= '1' when (w_decode ='1' and w_OPCODE = JMP) else
                '1' when (w_decode ='1' and w_OPCODE = BUA and w_UARTstatus = '1') else
                '1' when (w_decode ='1' and w_OPCODE = BRW and w_FWT = '1') else
                '0';
               
    w_PCLdVal <= w_IR(11 downto 0) when (w_decode = '1' and w_OPCODE = JMP) else
                 w_IR(11 downto 0) when (w_decode = '1' and w_OPCODE = BUA) else
                 w_IR(11 downto 0) when (w_decode = '1' and w_OPCODE = BRW) else
                 (others => '0');
   
    ----- EXECUTE -----
    w_ALU_A_In <= ("000000000000" & w_IR(19 downto 0)) when (w_execute = '1' and w_OPCODE = LRI) else    -- LRI
                  w_PDR when (w_execute = '1' and w_OPCODE = LDU) else       -- LDU
                  w_ROA when (w_execute = '1') else                                -- ADD, SUB, MUL, DIV
                  (others => '0');
    w_ALU_B_In <= w_ROB when (w_execute = '1') else                               -- ADD, SUB, MUL, DIV
                  (others => '0');
    
    process(w_clk)
    begin
        if(falling_edge(w_clk) and w_execute = '1') then
            w_SRAM_Addr <= w_IR(11 downto 0);
            w_ALUTEMP <= w_ALU_Out;
        end if;
    end process;
    
    
    ----- MEMORY -----
    w_SRAM_We <= "1" when (w_OPCODE = STR and w_memory = '1') else
                 "0" when (w_OPCODE = LDR and w_memory = '1') else
                 (others => '0');
    
    ----- WRITEBACK -----
    w_ldReg <= '1' when ((w_writeback = '1') and (w_OPCODE = LRI)) else
           '1' when ((w_writeback = '1') and (w_OPCODE = LDU)) else
           '1' when ((w_writeback = '1') and (w_OPCODE = CMP)) else
           '1' when ((w_writeback = '1') and (w_OPCODE = SCF)) else
           '1' when ((w_writeback = '1') and (w_OPCODE = SCA)) else
           '1' when ((w_writeback = '1') and (w_OPCODE = ADD)) else
           '1' when ((w_writeback = '1') and (w_OPCODE = SUB)) else
           '1' when ((w_writeback = '1') and (w_OPCODE = MUL)) else
           '1' when ((w_writeback = '1') and (w_OPCODE = DIV)) else
           '1' when ((w_writeback = '1') and (w_OPCODE = SIN)) else
           '1' when ((w_writeback = '1') and (w_OPCODE = COS)) else
           '1' when ((w_writeback = '1') and (w_OPCODE = ACS)) else
           '1' when ((w_writeback = '1') and (w_OPCODE = LDR)) else
           '0';

    -- Register input in the writeback stage
    w_RIN <= w_SRAM_Out when (w_writeback = '1' and w_OPCODE = LDR) else
             w_ALUTEMP when (w_writeback = '1') else
             (others => '0');
    
    --o_Output <= w_RO(11 downto 0);
    o_Output <= w_ALUTEMP(11 downto 0);
    w_RO <= w_ALUTEMP when (w_OPCODE = PTO and w_writeback = '1');
    
end Behavioral;
