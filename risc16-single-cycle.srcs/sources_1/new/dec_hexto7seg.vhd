----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 03:08:22 PM
-- Design Name: 
-- Module Name: dec_hexto7seg - Behavioral
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

entity dec_hexto7seg is
    Port ( hex : in STD_LOGIC_VECTOR (3 downto 0);
           cathode : out STD_LOGIC_VECTOR (7 downto 0));
end dec_hexto7seg;

architecture Behavioral of dec_hexto7seg is

begin

output : process(hex) begin
    case hex is
        when x"0" =>
            cathode <= "11111100";
        when x"1" =>
            cathode <= "01100000";
        when x"2" => 
            cathode <= "11011010";
        when x"3" => 
            cathode <= "11110010";
        when x"4" => 
            cathode <= "01100110";
        when x"5" =>
            cathode <= "10110110";
        when x"6" =>
            cathode <= "10111110";
        when x"7" =>
            cathode <= "11100000";
        when x"8" => 
            cathode <= "11111110";
        when x"9" => 
            cathode <= "11100110";
        when x"a" =>
            cathode <= "11101110";
        when x"b" =>
            cathode <= "00111110";
        when x"c" => 
            cathode <= "10011100";
        when x"d" => 
            cathode <= "01111010";
        when x"e" =>
            cathode <= "10011110";
        when x"f" =>
            cathode <= "10001110";
        when others => 
            cathode <= "00000000";
    end case;
end process output;

end Behavioral;
