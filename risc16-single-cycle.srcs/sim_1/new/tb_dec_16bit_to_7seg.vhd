----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 03:56:27 PM
-- Design Name: 
-- Module Name: tb_dec_16bit_to_7seg - Behavioral
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

entity tb_dec_16bit_to_7seg is
--  Port ( );
end tb_dec_16bit_to_7seg;

architecture Behavioral of tb_dec_16bit_to_7seg is

component dec_16bit_to_7seg is
    Port ( data : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           cathode : out STD_LOGIC_VECTOR (7 downto 0);
           anode : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal data : std_logic_vector(15 downto 0) := (others => '0');
signal clk : std_logic := '0';
signal cathode : std_logic_vector(7 downto 0) := (others => '0');
signal anode : std_logic_vector(3 downto 0) := (others => '0');

begin

dut : dec_16bit_to_7seg port map (
    data => data, 
    clk => clk,
    cathode => cathode,
    anode => anode
);

timing : process begin
    wait for 25ns;
    clk <= not clk;
end process timing;

stimulus : process begin 
    wait for 100ns;
    
    for index in 0 to 65535 loop
        data <= std_logic_vector(to_unsigned(index, 16));
        wait until clk = '1';
    end loop;
end process stimulus;

end Behavioral;
