----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 03:20:23 PM
-- Design Name: 
-- Module Name: tb_dec_hexto7seg - Behavioral
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

entity tb_dec_hexto7seg is
--  Port ( );
end tb_dec_hexto7seg;

architecture Behavioral of tb_dec_hexto7seg is

component dec_hexto7seg is
    Port ( hex : in STD_LOGIC_VECTOR (3 downto 0);
           cathode : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal hex : std_logic_vector(3 downto 0) := "0000";
signal cathode : std_logic_vector(7 downto 0) := x"00";

begin

dut : dec_hexto7seg port map (
    hex => hex,
    cathode => cathode
);

stimulus : process begin 
    for index in 0 to 15 loop
        hex <= std_logic_vector(to_unsigned(index, 4));
        wait for 10ns;
    end loop;
    
    wait;
end process stimulus;
end Behavioral;
