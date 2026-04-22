----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2026 12:36:54 PM
-- Design Name: 
-- Module Name: tb_Risc16_controller - Behavioral
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

entity tb_Risc16_controller is
--  Port ( );
end tb_Risc16_controller;

architecture Behavioral of tb_Risc16_controller is

component Risc16_controller is
    Port ( instruction : in STD_LOGIC_VECTOR (15 downto 0);
           a_equ_b : in STD_LOGIC;
           reset : in std_logic;
           pc_load : out STD_LOGIC;
           pc_sel : out STD_LOGIC;
           reg_write : out STD_LOGIC;
           imm7_op : out STD_LOGIC;
           alu_op : out STD_LOGIC_VECTOR (1 downto 0);
           beq_cmd : out STD_LOGIC;
           idle : out STD_LOGIC);
end component;

signal instruction : std_logic_vector (15 downto 0) := (others => '0');
signal a_equ_b, reset, pc_load, pc_sel, reg_write, imm7_op : std_logic := '0';
signal alu_op : std_logic_vector (1 downto 0) := "00";
signal beq_cmd, idle : std_logic := '0';

begin

dut : Risc16_controller port map (
    instruction => instruction, a_equ_b => a_equ_b, reset => reset,
    pc_load => pc_load, pc_sel => pc_sel, reg_write => reg_write, imm7_op => imm7_op,
    alu_op => alu_op, beq_cmd => beq_cmd, idle => idle
);

stimulus : process begin 
    instruction <= "0000000000000000";
    a_equ_b <= '1';
    reset <= '1';
    wait for 10ns;
    reset <= '0';
    
    wait for 100ns;
    instruction <= "0001111000000101"; -- add r7, r4, r5 
    wait for 10ns;
    instruction <= "0011111000000101"; -- addi r7, r4, r5
    wait for 10ns;
    instruction <= "1101111000000101"; -- beq r7, r4, r5
    a_equ_b <= '0'; -- a /= b 
    wait for 10ns;
    a_equ_b <= '1'; -- a == b
    wait for 10ns;
    instruction <= "1110000000000001"; -- halt
    wait;
    
end process stimulus;

end Behavioral;
