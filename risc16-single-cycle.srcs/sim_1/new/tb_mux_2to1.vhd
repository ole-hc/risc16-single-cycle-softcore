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
    generic ( data_width : integer := 16);
    Port ( a : in std_logic_vector (data_width - 1 downto 0);
           b : in std_logic_vector (data_width - 1 downto 0);
           sel : in STD_LOGIC;
           y : out std_logic_vector (data_width - 1 downto 0));
end component;

signal a, b, y : std_logic_vector (15 downto 0) := (others => '0');
signal sel : std_logic := '0';

begin

dut : mux_2to1 generic map (data_width => 16) port map (a => a, b => b, sel => sel, y => y);

test : process begin
    wait for 100ns;
    
    a <= x"1111";
    b <= x"0000";
    sel <= '1';
    wait for 10ns;
    assert y = b
    report "Error in test 1" severity error;
    
    sel <= '0';
    wait for 10ns;
    assert y = a
    report "Error in test 2" severity error; 
    
end process test; 
end Behavioral;
