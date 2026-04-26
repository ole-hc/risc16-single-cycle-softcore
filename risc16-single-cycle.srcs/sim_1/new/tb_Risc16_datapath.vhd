----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/13/2026 01:29:48 PM
-- Design Name: 
-- Module Name: tb_Risc16_datapath - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- This testbench first test BEQ with r1 and r0 --> false
-- Then 5 is added to r1 and the BEQ is done again with r1 and r1 --> true
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_Risc16_datapath is
--  Port ( );
end tb_Risc16_datapath;

architecture Behavioral of tb_Risc16_datapath is

component Risc16_datapath is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           pc_load : in STD_LOGIC;
           pc_sel : in STD_LOGIC;
           beq_cmd : in STD_LOGIC;
           reg_write : in STD_LOGIC;
           imm7_op : in STD_LOGIC;
           debug : in std_logic;
           alu_op : in STD_LOGIC_VECTOR (1 downto 0);
           instruction : in STD_LOGIC_VECTOR (15 downto 0);
           ir_addr : out STD_LOGIC_VECTOR (15 downto 0);
           a_equ_b : out STD_LOGIC);
end component;

signal clk, reset, pc_load, pc_sel, beq_cmd, reg_write, imm7_op, debug : std_logic := '0';
signal alu_op : std_logic_vector (1 downto 0) := (others => '0');
signal instruction, ir_addr : std_logic_vector (15 downto 0) := (others => '0');
signal a_equ_b : std_logic := '0';

begin

dut : Risc16_datapath port map (
    clk => clk, reset => reset,
    pc_load => pc_load, pc_sel => pc_sel,
    beq_cmd => beq_cmd, reg_write => reg_write, imm7_op => imm7_op, 
    debug => debug, alu_op => alu_op, instruction => instruction,
    ir_addr => ir_addr, a_equ_b => a_equ_b
);

timing : process begin
    wait for 25ns;
    clk <= not clk;
end process timing;

stimulus : process begin
    -- reset
    wait for 100ns;
    reset <= '1';
    wait until clk = '1';
    wait for 1ps;
    reset <= '0';
    
    -- beq r1, r0, 5 
    pc_sel <= '0';
    pc_load <= '1';
    beq_cmd <= '1';
    imm7_op <= '1';
    alu_op <= "10";
    instruction <= "110" & "001" & "000" & "0000101";
    wait until clk = '1';
    wait for 1ps;
    assert a_equ_b = '0'
    report "Error in first BEQ - False positive" severity error;
    wait for 10ns;
    
    -- addi r1, r0, 5
    pc_sel <= '0';
    pc_load <= '1';
    beq_cmd <= '0';
    reg_write <= '1';
    imm7_op <= '1';
    alu_op <= "00";
    instruction <= "001" & "001" & "000" & "0000101";
    wait until clk = '1';
    wait for 10ns;
    
    -- beq r1, r1, 5
    pc_sel <= '0';
    pc_load <= '1';
    beq_cmd <= '1';
    imm7_op <= '1';
    alu_op <= "10";
    instruction <= "110" & "001" & "001" & "0000101";
    wait until clk = '1';
    wait for 1ps;
    assert a_equ_b = '1'
    report "Error in second BEQ - False negative" severity error;
    wait for 10ns;
    
end process stimulus;

end Behavioral;
