----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2026 11:37:23 AM
-- Design Name: 
-- Module Name: alu - Behavioral
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

entity alu is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           alu_op : in STD_LOGIC_VECTOR (1 downto 0);
           c : out STD_LOGIC_VECTOR (15 downto 0);
           a_equ_b : out STD_LOGIC);
end alu;

architecture Behavioral of alu is

begin

output : process (a, b, alu_op) begin
    case alu_op is
        when "00" => 
            c <= std_logic_vector(signed(a) + signed(b));
        when "01" =>
            c <= not (a and b);
        when "10" =>
            if (a = b) then 
                a_equ_b <= '1';
            else 
                a_equ_b <= '0';
            end if;
        when others =>
    end case;
end process output;

end Behavioral;
