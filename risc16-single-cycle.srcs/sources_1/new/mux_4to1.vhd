----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 12:19:20 AM
-- Design Name: 
-- Module Name: mux_4to1 - Behavioral
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

entity mux_4to1 is
    generic ( data_width : integer := 16);
    Port ( a : in std_logic_vector (data_width - 1 downto 0);
           b : in std_logic_vector (data_width - 1 downto 0);
           c : in std_logic_vector (data_width - 1 downto 0);
           d : in std_logic_vector (data_width - 1 downto 0);
           sel : in STD_LOGIC_vector (1 downto 0);
           y : out std_logic_vector (data_width - 1 downto 0));
end mux_4to1;

architecture Behavioral of mux_4to1 is

begin

output : process (a, b, sel) begin
    case sel is
        when "00" => 
            y <= a;
        when "01" =>
            y <= b;
        when "10" =>
            y <= c;
        when "11" =>
            y <= d;
        when others => 
            y <= (others => '0');
    end case;
end process output;

end Behavioral;
