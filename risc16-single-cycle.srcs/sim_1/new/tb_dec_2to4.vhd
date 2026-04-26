----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 02:58:30 PM
-- Design Name: 
-- Module Name: tb_dec_2to4 - Behavioral
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

entity tb_dec_2to4 is
--  Port ( );
end tb_dec_2to4;

architecture Behavioral of tb_dec_2to4 is

component dec_2to4 is
    Port ( data : in STD_LOGIC_VECTOR (1 downto 0);
           anode : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal data : std_logic_vector(1 downto 0) := "00";
signal anode : std_logic_vector(3 downto 0) := x"0";

begin

dut : dec_2to4 port map (
    data => data, 
    anode => anode
);

stimulus : process begin
    wait for 100ns;
    
    for index in 0 to 3 loop
        data <= std_logic_vector(to_unsigned(index, 2));
        wait for 10ns;
    end loop;
end process stimulus;

end Behavioral;
