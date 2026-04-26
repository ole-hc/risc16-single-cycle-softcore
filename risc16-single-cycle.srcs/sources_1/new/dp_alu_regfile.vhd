----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2026 01:57:15 PM
-- Design Name: 
-- Module Name: dp_alu_regfile - Behavioral
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

entity dp_alu_regfile is
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
end dp_alu_regfile;

architecture Structural of dp_alu_regfile is

component alu is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           alu_op : in STD_LOGIC_VECTOR (1 downto 0);
           c : out STD_LOGIC_VECTOR (15 downto 0);
           a_equ_b : out STD_LOGIC);
end component;

component regfile is
    Port ( clk : in STD_LOGIC;
           reg_write : in STD_LOGIC;
           a_addr : in STD_LOGIC_VECTOR (2 downto 0);
           b_addr : in STD_LOGIC_VECTOR (2 downto 0);
           c_addr : in STD_LOGIC_VECTOR (2 downto 0);
           a_data : out STD_LOGIC_VECTOR (15 downto 0);
           b_data : out STD_LOGIC_VECTOR (15 downto 0);
           c_data : in STD_LOGIC_VECTOR (15 downto 0));
end component;

component extender2k is
    Port ( data : in STD_LOGIC_VECTOR (6 downto 0);
           q : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component mux_2to1 is
    generic ( data_width : integer := 16);
    Port ( a : in std_logic_vector (data_width - 1 downto 0);
           b : in std_logic_vector (data_width - 1 downto 0);
           sel : in STD_LOGIC;
           y : out std_logic_vector (data_width - 1 downto 0));
end component;

-- regfile
signal a_addr, b_addr, c_addr : std_logic_vector(2 downto 0) := (others => '0');
signal a_data, b_data, c_data : std_logic_vector (15 downto 0) := (others => '0');

-- extender2k
signal immediate : std_logic_vector(6 downto 0) := (others => '0');

-- mux2to1 
signal alu_b, imm16_input : std_logic_vector (15 downto 0) := (others => '0');

begin

c_addr <= instruction(12 downto 10);
immediate <= instruction(6 downto 0);

mux_beq : mux_2to1 generic map (data_width => 3)
port map (
    a => instruction(2 downto 0), b => instruction(12 downto 10), sel => beq_cmd, 
    y => b_addr
);

register_file : regfile port map (
    clk => clk, reg_write => reg_write, 
    a_addr => a_addr, b_addr => b_addr, c_addr => c_addr,
    a_data => a_data, b_data => b_data, c_data => c_data
);

mux_a_debug : mux_2to1 generic map (data_width => 3)
port map (
    a => instruction(9 downto 7), b => debug_addr,
    sel => debug, 
    y => a_addr
);

extender_2k : extender2k port map (
    data => immediate,
    q => imm16_input
);

mux_b_imm : mux_2to1 port map (
    a => b_data, b => imm16_input,
    sel => imm7_op, 
    y => alu_b
);

alu16 : alu port map (
    a => a_data, b => alu_b, alu_op => alu_op,
    c => c_data, a_equ_b => a_equ_b
);

debug_mux : mux_2to1 port map (
    a => x"0000", b => a_data, 
    sel => debug,
    y => debug_rega_out
);

immediate16 <= imm16_input;

end Structural;
