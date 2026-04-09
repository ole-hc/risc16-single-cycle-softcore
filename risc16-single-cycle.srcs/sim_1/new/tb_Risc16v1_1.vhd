----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2026 10:52:24 AM
-- Design Name: 
-- Module Name: tb_Risc16v1_1 - Behavioral
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

entity tb_Risc16v1_1 is
--  Port ( );
end tb_Risc16v1_1;

architecture Behavioral of tb_Risc16v1_1 is

component Risc16v1_1 is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           load_pc : in std_logic;
           pc_sel : in std_logic);
end component;

signal clk, reset, load_pc, pc_sel : std_logic := '0';

begin

dut : Risc16v1_1 port map (clk => clk, reset => reset, load_pc => load_pc, pc_sel => pc_sel);

timing : process begin 
    wait for 25ns;
    clk <= not clk;
end process timing;

stimulus : process begin 
    reset <= '1';
    wait until clk = '1';
    wait for 1ps;
    reset <= '0';
    
    load_pc <= '1';
    wait for 510ns;
    
end process stimulus;

end Behavioral;
