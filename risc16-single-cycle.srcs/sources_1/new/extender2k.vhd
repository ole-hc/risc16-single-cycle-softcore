----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2026 09:40:44 AM
-- Design Name: 
-- Module Name: extender2k - Behavioral
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

entity extender2k is
    Port ( data : in STD_LOGIC_VECTOR (6 downto 0);
           q : out STD_LOGIC_VECTOR (15 downto 0));
end extender2k;

architecture Behavioral of extender2k is

begin

output : process (data) begin
    if (data(data'left) = '1') then
        q <= "111111111" & data;
    else 
        q <= "000000000" & data;
    end if;
end process output;

end Behavioral;
