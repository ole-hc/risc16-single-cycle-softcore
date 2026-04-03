----------------------------------------------------------------------------------
-- Company: XXX
-- Engineer: 
-- 
-- Create Date: 04/03/2026 03:46:17 PM
-- Design Name: 
-- Module Name: register_nbit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- Generic N Bit Register with sync reset  
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

entity register_nbit is
    generic (
           data_width : integer := 16
    );
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (data_width - 1 downto 0);
           q : out STD_LOGIC_VECTOR (data_width - 1 downto 0);
           load : in STD_LOGIC);
end register_nbit;

architecture Behavioral of register_nbit is

begin

output : process (clk) begin
    if rising_edge(clk) then
        if (reset = '1') then 
            q <= (others => '0');
        elsif (load = '1') then 
            q <= data;
        end if;
    end if;
end process output; 

end Behavioral;
