----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2026 07:45:09 PM
-- Design Name: 
-- Module Name: tb_mux_2to1 - Behavioral
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

entity tb_mux_2to1 is
--  Port ( );
end tb_mux_2to1;

architecture Behavioral of tb_mux_2to1 is

component mux_2to1 is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           sel : in STD_LOGIC;
           y : out STD_LOGIC);
end component;

signal a, b, sel, y : std_logic := '0';

begin

dut : mux_2to1 port map (a => a, b => b, sel => sel, y => y);

test : process begin
    wait for 100ns;
    
    a <= '1';
    b <= '0';
    sel <= '1';
    wait for 10ns;
    assert y = '0'
    report "Error in test 1" severity error;
    
    sel <= '0';
    wait for 10ns;
    assert y = '1'
    report "Error in test 2" severity error; 
    
end process test; 
end Behavioral;
