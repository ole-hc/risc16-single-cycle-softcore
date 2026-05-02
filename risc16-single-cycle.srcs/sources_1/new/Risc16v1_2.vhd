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
           idle : out STD_LOGIC;
           debug_addr : in std_logic_vector(2 downto 0);
           debug_rega_out : out std_logic_vector(15 downto 0);
           anode : out std_logic_vector(3 downto 0);
           cathode : out std_logic_vector(7 downto 0));
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
           alu_op : in STD_LOGIC_VECTOR (1 downto 0);
           instruction : in STD_LOGIC_VECTOR (15 downto 0);
           ir_addr : out STD_LOGIC_VECTOR (15 downto 0);
           a_equ_b : out STD_LOGIC;
           debug : in std_logic;
           debug_addr : in std_logic_vector(2 downto 0);
           debug_rega_out : out std_logic_vector(15 downto 0));
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

component clk_wiz_0
        port (
            clk_in1  : in  std_logic;
            clk_out1 : out std_logic;
            clk_out2 : out std_logic;
            reset    : in  std_logic;
            locked   : out std_logic
        );
end component;

signal pc_load, pc_sel, beq_cmd, reg_write, imm7_op, debug : std_logic := '0';
signal alu_op : std_logic_vector(1 downto 0) := "00";
signal instruction, ir_addr : std_logic_vector(15 downto 0) := (others => '0');
signal a_equ_b : std_logic := '0';

-- clock 
signal clk_system, clk_7seg : std_logic := '0';

-- clk wiz 
signal int_reset, locked : std_logic := '0';

begin

clk_wiz : clk_wiz_0
    port map (
        clk_in1  => clk,
        clk_out1 => clk_7seg,
        clk_out2 => clk_system,
        reset    => '0',
        locked   => locked
);

int_reset <= reset or (not locked); -- reset processor on button and clk_wiz stable

datapath : Risc16_datapath port map (
    clk => clk_system, 
    reset => int_reset, 
    pc_load => pc_load, 
    pc_sel => pc_sel, 
    beq_cmd => beq_cmd,
    reg_write => reg_write, 
    imm7_op => imm7_op, 
    debug => debug,
    alu_op => alu_op, 
    instruction => instruction, 
    ir_addr => ir_addr, 
    a_equ_b => a_equ_b,
    debug_addr => debug_addr,
    debug_rega_out => debug_rega_out
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
    clk => clk_7seg,
    cathode => cathode,
    anode => anode
);

end Structural;
