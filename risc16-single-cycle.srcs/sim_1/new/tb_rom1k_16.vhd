----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2026 07:35:12 PM
-- Design Name: 
-- Module Name: tb_rom1k_16 - Behavioral
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

entity tb_rom1k_16 is
--  Port ( );
end tb_rom1k_16;

architecture Behavioral of tb_rom1k_16 is

component rom1k_16 is
    Port ( addr : in STD_LOGIC_VECTOR (9 downto 0);
           data : out STD_LOGIC_VECTOR (15 downto 0));
end component;

signal addr : std_logic_vector(9 downto 0) := (others => '0');
signal data : std_logic_vector(15 downto 0) := (others => '0'); 

begin

dut : rom1k_16 port map (addr => addr, data => data);

stimulus : process begin 
    for index in 0 to 1023 loop
        addr <= std_logic_vector(to_unsigned(index, 10));
        wait for 10ns;
    end loop;
end process stimulus;

end Behavioral;
