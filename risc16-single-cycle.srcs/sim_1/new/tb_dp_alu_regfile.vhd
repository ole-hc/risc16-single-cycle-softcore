----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2026 02:34:10 PM
-- Design Name: 
-- Module Name: tb_dp_alu_regfile - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_dp_alu_regfile is
--  Port ( );
end tb_dp_alu_regfile;

architecture Behavioral of tb_dp_alu_regfile is

component dp_alu_regfile is
    Port ( clk : in STD_LOGIC;
           reg_write : in STD_LOGIC;
           imm7_op : in STD_LOGIC;
           regb_sel : in std_logic;
           mem_to_reg : in std_logic_vector (1 downto 0);
           alu_op : in STD_LOGIC_VECTOR (1 downto 0);
           instruction : in std_logic_vector (15 downto 0);
           ram_data : in std_logic_vector (15 downto 0);
           pc_jalr : in std_logic_vector (15 downto 0);
           debug : in std_logic;
           debug_addr : in STD_LOGIC_VECTOR (2 downto 0);
           debug_rega_out : out std_logic_vector(15 downto 0);
           a_equ_b : out STD_LOGIC;
           alu_out : out std_logic_vector (15 downto 0);
           rega_out : out std_logic_vector (15 downto 0);
           regb_out : out std_logic_vector (15 downto 0);
           immediate16 : out std_logic_vector (15 downto 0));
end component;

signal clk, reg_write, imm7_op, a_equ_b, regb_sel, debug, mem_to_reg : std_logic := '0';
signal alu_op : std_logic_vector(1 downto 0) := (others => '0');
signal debug_addr : std_logic_vector(2 downto 0) := (others => '0');
signal instruction, immediate16, debug_rega_out, ram_data, alu_out, regb_out : std_logic_vector(15 downto 0) := (others => '0');

begin

dut : dp_alu_regfile port map (
    clk => clk, reg_write => reg_write, imm7_op => imm7_op, regb_sel => regb_sel, 
    mem_to_reg => mem_to_reg, alu_op => alu_op, instruction => instruction, ram_data => ram_data,
    debug => debug, debug_addr => debug_addr, debug_rega_out => debug_rega_out, 
    alu_out => alu_out, regb_out => regb_out, a_equ_b => a_equ_b, immediate16 => immediate16
);

timing : process begin 
    wait for 25ns;
    clk <= not clk;
end process timing;

stimulus : process begin 
    wait for 100ns; 
    
    -- addi r1, r0, 1
    regb_sel <= '0';
    reg_write <= '1';
    imm7_op <= '1';
    debug <= '0';
    alu_op <= "00";
    ram_data <= x"0000";
    mem_to_reg <= '0';
    instruction <= "001" & "001" & "000" & "0000001";
    wait until clk = '1';
    wait for 1ps;
    
    -- addi r2, r0, 2
    instruction <= "001" & "010" & "000" & "0000010";
    wait until clk = '1';
    wait for 1ps;
    
    -- add r3, r2, r1 
    imm7_op <= '1';
    instruction <= "001" & "011" & "010" & "0000" & "001";
    wait until clk = '1';
    wait for 1ps;
    
    -- nand r1, r2, r3
    -- x"0001" nand x"0002"
    alu_op <= "01";
    instruction <= "000" & "001" & "010" & "0000" & "011";
    wait until clk = '1';
    wait for 1ps;
    
    -- beq test
    -- addi r1, r0, 1
    regb_sel <= '0';
    reg_write <= '1';
    imm7_op <= '1';
    alu_op <= "00";
    instruction <= "001" & "001" & "000" & "0000001";
    wait until clk = '1';
    wait for 1ps;
    
    -- beq r1, r0, 5
    regb_sel <= '1';
    imm7_op <= '0';
    alu_op <= "10";
    instruction <= "110" & "001" & "000" & "0000101";
    wait until clk = '1';
    wait for 1ps;
    assert a_equ_b = '0'
    report "False positive in first BEQ cmd" severity error;
    wait for 10ns;
    
    -- beq r0, r0, -1
    instruction <= "110" & "000" & "000" & "1111110";
    wait until clk = '1';
    wait for 1ps;
    assert a_equ_b = '1'
    report "False negative in second BEQ cmd" severity error;
    
    -- sw r1, r1, 1
    regb_sel <= '0';
    reg_write <= '0';
    imm7_op <= '1';
    debug <= '0';
    alu_op <= "00";
    ram_data <= x"0000";
    mem_to_reg <= '1';
    instruction <= "101" & "001" & "001" & "0000001";
    wait until clk = '1';
    wait for 1ps;
    
    -- lw r2, r1, 1
    regb_sel <= '0';
    reg_write <= '1';
    imm7_op <= '1';
    debug <= '0';
    alu_op <= "00";
    ram_data <= x"FFFF";
    mem_to_reg <= '1';
    instruction <= "100" & "010" & "001" & "0000001";
    wait until clk = '1';
    wait for 1ps;
    
    debug <= '1';
    debug_addr <= "000";
    wait for 10ns;
    debug_addr <= "001";
    wait for 10ns;
    debug_addr <= "010";
    wait for 10ns;
    
end process stimulus; 
end Behavioral;
