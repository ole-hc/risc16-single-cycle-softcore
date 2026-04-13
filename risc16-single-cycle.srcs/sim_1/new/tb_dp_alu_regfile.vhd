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
           beq_cmd : in std_logic;
           alu_op : in STD_LOGIC_VECTOR (1 downto 0);
           instruction : in std_logic_vector (15 downto 0);
           a_equ_b : out STD_LOGIC;
           immediate16 : out std_logic_vector (15 downto 0));
end component;

signal clk, reg_write, imm7_op, a_equ_b, beq_cmd : std_logic := '0';
signal alu_op : std_logic_vector(1 downto 0) := (others => '0');
signal instruction, immediate16 : std_logic_vector(15 downto 0) := (others => '0');

begin

dut : dp_alu_regfile port map (
    clk => clk, reg_write => reg_write, imm7_op => imm7_op, beq_cmd => beq_cmd, alu_op => alu_op, instruction => instruction,
    a_equ_b => a_equ_b, immediate16 => immediate16
);

timing : process begin 
    wait for 25ns;
    clk <= not clk;
end process timing;

stimulus : process begin 
    wait for 100ns; 
    
    -- addi r1, r0, 1
    beq_cmd <= '0';
    reg_write <= '1';
    imm7_op <= '1';
    alu_op <= "00";
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
    beq_cmd <= '0';
    reg_write <= '1';
    imm7_op <= '1';
    alu_op <= "00";
    instruction <= "001" & "001" & "000" & "0000001";
    wait until clk = '1';
    wait for 1ps;
    
    -- beq r1, r0, 5
    beq_cmd <= '1';
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
    
end process stimulus; 
end Behavioral;
