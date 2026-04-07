----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2026 08:12:20 PM
-- Design Name: 
-- Module Name: tb_prog_counter - Behavioral
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

entity tb_prog_counter is
--  Port ( );
end tb_prog_counter;

architecture Behavioral of tb_prog_counter is

component prog_counter is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           load_pc : in STD_LOGIC;
           pc_sel : in STD_LOGIC;
           ir_addr : out STD_LOGIC_VECTOR (15 downto 0);
           br_offset : in std_logic_vector (15 downto 0));
end component;

signal clk, reset, load_pc, pc_sel : std_logic := '0';
signal ir_addr, br_offset : std_logic_vector (15 downto 0) := (others => '0');

begin

dut : prog_counter port map (clk => clk, reset => reset, load_pc => load_pc, pc_sel => pc_sel, ir_addr => ir_addr, br_offset => br_offset);

timing : process begin 
    wait for 25ns;
    clk <= not clk;
end process timing;

test : process begin
    reset <= '1';
    wait until clk = '1';
    wait for 1ps;
    
    wait until ir_addr = x"0004";
    wait for 100ns;
end process test;

end Behavioral;
