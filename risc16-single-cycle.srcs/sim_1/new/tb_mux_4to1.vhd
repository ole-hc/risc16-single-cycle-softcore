----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 12:25:38 AM
-- Design Name: 
-- Module Name: tb_mux_4to1 - Behavioral
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

entity tb_mux_4to1 is
--  Port ( );
end tb_mux_4to1;

architecture Behavioral of tb_mux_4to1 is

component mux_4to1 is
    generic ( data_width : integer := 16);
    Port ( a : in std_logic_vector (data_width - 1 downto 0);
           b : in std_logic_vector (data_width - 1 downto 0);
           c : in std_logic_vector (data_width - 1 downto 0);
           d : in std_logic_vector (data_width - 1 downto 0);
           sel : in STD_LOGIC_vector (1 downto 0);
           y : out std_logic_vector (data_width - 1 downto 0));
end component;

signal a, b, c, d, y : std_logic_vector(15 downto 0) := (others => '0');
signal sel : std_logic_vector(1 downto 0) := (others => '0');

begin

dut : mux_4to1 port map (
    a => a, b => b, c => c, d => d, 
    sel => sel, 
    y => y
);

stimulus : process begin
    a <= x"0001";
    b <= x"0002";
    c <= x"0003";
    d <= x"0004";
    sel <= "00";
    
    wait for 100ns; 
    assert y = a 
    report "Not showing a correctly" severity error;
    wait for 25ns;
    
    sel <= "01";
    wait for 1ps;
    assert y = b
    report "Not showing b correctly" severity error;
    wait for 25ns;
    
    sel <= "10";
    wait for 1ps;
    assert y = c 
    report "Not showing c correctly" severity error;
    wait for 25ns;
    
    sel <= "11";
    wait for 1ps;
    assert y = d 
    report "Not showing d correctly" severity error;
    wait for 25ns;
    
end process stimulus;

end Behavioral;
