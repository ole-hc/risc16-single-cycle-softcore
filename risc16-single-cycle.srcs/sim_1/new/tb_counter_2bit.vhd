----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 12:09:45 AM
-- Design Name: 
-- Module Name: tb_counter_2bit - Behavioral
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

entity tb_counter_2bit is
--  Port ( );
end tb_counter_2bit;

architecture Behavioral of tb_counter_2bit is

component counter_2bit is
    Port ( clk : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (1 downto 0));
end component;

signal clk : std_logic := '0';
signal q : std_logic_vector(1 downto 0) := "00";

begin

dut : counter_2bit port map (clk => clk, q => q);

timing : process begin
    wait for 25ns;
    clk <= not clk;
end process timing;

stimulus : process begin
    wait;
end process stimulus;

end Behavioral;
