----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2026 11:55:54 PM
-- Design Name: 
-- Module Name: counter_2bit - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_2bit is
    Port ( clk : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (1 downto 0));
end counter_2bit;

architecture Behavioral of counter_2bit is

begin

count : process (clk)  
    variable value : integer range 0 to 3;
    begin
    if (rising_edge(clk)) then
        value := value + 1;
    end if;
    q <= std_logic_vector(to_unsigned(value, 2));
end process count;

end Behavioral;
