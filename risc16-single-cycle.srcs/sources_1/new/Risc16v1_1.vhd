----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/08/2026 03:55:26 PM
-- Design Name: 
-- Module Name: Risc16v1_1 - Structural
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

entity Risc16v1_1 is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           load_pc : in std_logic;
           pc_sel : in std_logic);
end Risc16v1_1;

architecture Structural of Risc16v1_1 is

component prog_counter is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           load_pc : in STD_LOGIC;
           pc_sel : in STD_LOGIC;
           ir_addr : out STD_LOGIC_VECTOR (15 downto 0);
           br_offset : in std_logic_vector (15 downto 0));
end component;

component instruction_memory is
    Port ( addr : in STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (15 downto 0));
end component; 

signal br_offset, ir_addr, instruction: STD_LOGIC_VECTOR (15 downto 0) := (others => '0');

begin
program_counter : prog_counter port map (clk => clk, reset => reset, load_pc => load_pc, pc_sel => pc_sel, ir_addr => ir_addr, br_offset => br_offset);
instr_memory : instruction_memory port map (addr => ir_addr(3 downto 0), data => instruction);

end Structural;
