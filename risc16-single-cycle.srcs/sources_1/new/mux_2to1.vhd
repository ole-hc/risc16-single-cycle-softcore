----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2026 07:42:23 PM
-- Design Name: 
-- Module Name: mux_2to1 - Behavioral
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

entity mux_2to1 is
    generic ( data_width : integer := 16);
    Port ( a : in std_logic_vector (data_width - 1 downto 0);
           b : in std_logic_vector (data_width - 1 downto 0);
           sel : in STD_LOGIC;
           y : out std_logic_vector (data_width - 1 downto 0));
end mux_2to1;

architecture Behavioral of mux_2to1 is

-- sel = 0: y = a | sel = 1: y = b

begin

output : process (a, b, sel) begin
    if (sel = '0') then
        y <= a;
    elsif (sel = '1') then
        y <= b;
    end if;
end process output;

end Behavioral;
