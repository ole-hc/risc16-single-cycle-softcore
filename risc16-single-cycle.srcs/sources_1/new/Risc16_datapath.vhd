----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/13/2026 12:44:07 PM
-- Design Name: 
-- Module Name: Risc16_datapath - Behavioral
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

entity Risc16_datapath is
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
end Risc16_datapath;

architecture Structural of Risc16_datapath is

component prog_counter is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           load_pc : in STD_LOGIC;
           pc_sel : in STD_LOGIC;
           ir_addr : out STD_LOGIC_VECTOR (15 downto 0);
           br_offset : in std_logic_vector (15 downto 0));
end component;

component dp_alu_regfile is
    Port ( clk : in STD_LOGIC;
           reg_write : in STD_LOGIC;
           imm7_op : in STD_LOGIC;
           beq_cmd : in std_logic;
           alu_op : in STD_LOGIC_VECTOR (1 downto 0);
           instruction : in std_logic_vector (15 downto 0);
           debug : in std_logic;
           debug_addr : in STD_LOGIC_VECTOR (2 downto 0);
           debug_rega_out : out std_logic_vector(15 downto 0);
           a_equ_b : out STD_LOGIC;
           immediate16 : out std_logic_vector (15 downto 0));
end component;

signal immediate16 : std_logic_vector (15 downto 0) := (others => '0');
signal debug_addr : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
signal debug_rega_out : std_logic_vector(15 downto 0) := (others => '0');

begin

programm_counter : prog_counter port map (
    clk => clk, reset => reset,
    load_pc => pc_load, pc_sel => pc_sel,
    ir_addr => ir_addr, br_offset => immediate16
);

regfile_alu : dp_alu_regfile port map (
    clk => clk, 
    reg_write => reg_write, imm7_op => imm7_op, beq_cmd => beq_cmd, 
    alu_op => alu_op, instruction => instruction, 
    debug => debug, debug_addr => debug_addr, debug_rega_out => debug_rega_out,
    a_equ_b => a_equ_b, immediate16 => immediate16
);

end Structural;
