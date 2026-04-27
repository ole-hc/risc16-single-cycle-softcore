----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2026 07:24:26 PM
-- Design Name: 
-- Module Name: Risc16v1_2 - Behavioral
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

entity Risc16v1_2 is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           idle : out STD_LOGIC);
end Risc16v1_2;

architecture Structural of Risc16v1_2 is

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

component Risc16_controller is
    Port ( instruction : in STD_LOGIC_VECTOR (15 downto 0);
           a_equ_b : in STD_LOGIC;
           pc_load : out STD_LOGIC;
           pc_sel : out STD_LOGIC;
           reg_write : out STD_LOGIC;
           imm7_op : out STD_LOGIC;
           alu_op : out STD_LOGIC_VECTOR (1 downto 0);
           beq_cmd : out STD_LOGIC;
           debug : out std_logic;
           idle : out STD_LOGIC);
end component;

component rom1k_16 is
    Port ( addr : in STD_LOGIC_VECTOR (9 downto 0);
           data : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component dec_16bit_to_7seg is
    Port ( data : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           cathode : out STD_LOGIC_VECTOR (7 downto 0);
           anode : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal pc_load, pc_sel, beq_cmd, reg_write, imm7_op, debug : std_logic := '0';
signal alu_op : std_logic_vector(1 downto 0) := "00";
signal instruction, ir_addr : std_logic_vector(15 downto 0) := (others => '0');
signal a_equ_b : std_logic := '0';

-- 7segment
signal basys3_clk : std_logic := '0';
signal cathode : std_logic_vector(7 downto 0) := (others => '0');
signal anode : std_logic_vector(3 downto 0) := (others => '0');

begin

datapath : Risc16_datapath port map (
    clk => clk, 
    reset => reset, 
    pc_load => pc_load, 
    pc_sel => pc_sel, 
    beq_cmd => beq_cmd,
    reg_write => reg_write, 
    imm7_op => imm7_op, 
    debug => debug,
    alu_op => alu_op, 
    instruction => instruction, 
    ir_addr => ir_addr, 
    a_equ_b => a_equ_b
);

controller : Risc16_controller port map (
    instruction => instruction, 
    a_equ_b => a_equ_b,
    pc_load => pc_load, 
    pc_sel => pc_sel,
    reg_write => reg_write,
    imm7_op => imm7_op,
    alu_op => alu_op, 
    beq_cmd => beq_cmd,
    idle => idle,
    debug => debug
);

rom : rom1k_16 port map (
    addr => ir_addr(9 downto 0),
    data => instruction
);

dec_7segment : dec_16bit_to_7seg port map (
    data => ir_addr, 
    clk => basys3_clk,
    cathode => cathode,
    anode => anode
);

end Structural;
