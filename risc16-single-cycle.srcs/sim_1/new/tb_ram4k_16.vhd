----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2026 11:24:24 AM
-- Design Name: 
-- Module Name: tb_ram4k_16 - Behavioral
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

entity tb_ram4k_16 is
--  Port ( );
end tb_ram4k_16;

architecture Behavioral of tb_ram4k_16 is

component ram4k_16 is
    Port ( clk : in STD_LOGIC;
           write_en : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (15 downto 0);
           addr : in STD_LOGIC_VECTOR (15 downto 0);
           data_out : out STD_LOGIC_VECTOR (15 downto 0));
end component;

signal clk, write_en : std_logic := '0';
signal data_in, addr, data_out : std_logic_vector (15 downto 0) := (others => '0');

begin

dut : ram4k_16 port map (
    clk => clk,
    write_en => write_en,
    data_in => data_in,
    addr => addr, 
    data_out => data_out
);

timing : process begin 
    wait for 25ns;
    clk <= not clk;
end process timing;

stimulus : process begin 
    wait for 100ns;
    
    -- test write
    write_en <= '1';
    data_in <= x"0001";
    addr <= x"0001";
    wait until clk = '1';
    wait for 0ns;
    
    -- test read
    write_en <= '0';
    data_in <= x"0000";
    addr <= x"0001";
    wait until clk = '1';
    wait for 0ns;
    assert data_out = x"0001"
    report "FAIL!" severity error;
end process stimulus;

end Behavioral;
