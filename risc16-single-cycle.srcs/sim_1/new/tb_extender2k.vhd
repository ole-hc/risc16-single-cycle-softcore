----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2026 09:42:56 AM
-- Design Name: 
-- Module Name: tb_extender2k - Behavioral
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

entity tb_extender2k is
--  Port ( );
end tb_extender2k;

architecture Behavioral of tb_extender2k is

component extender2k is
    Port ( data : in STD_LOGIC_VECTOR (6 downto 0);
           q : out STD_LOGIC_VECTOR (15 downto 0));
end component;

signal data : std_logic_vector (6 downto 0) := (others => '0');
signal q : std_logic_vector (15 downto 0) := (others => '0');

begin

dut : extender2k port map (data => data, q => q);

stimulus : process begin 
    wait for 100ns;
    
    data <= "1001110"; -- -50
    wait for 1ps;
    assert q = "1111111111001110"
    report "Error converting -50 to 2k" severity error;
    
    wait for 25ns;
    data <= "0000111"; -- 7
    wait for 1ps;
    assert q = "0000000000000111"
    report "Error converting 7 to 2k" severity error;
    wait for 25ns; 
end process stimulus;

end Behavioral;
