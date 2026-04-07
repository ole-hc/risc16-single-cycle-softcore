----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2026 07:22:57 PM
-- Design Name: 
-- Module Name: tb_full_adder_nbit - Behavioral
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

entity tb_full_adder_nbit is
--  Port ( );
end tb_full_adder_nbit;

architecture Behavioral of tb_full_adder_nbit is

component full_adder_nbit is
    generic (
           data_width : integer := 16
    );
    Port ( a : in STD_LOGIC_VECTOR (data_width - 1 downto 0);
           b : in STD_LOGIC_VECTOR (data_width - 1 downto 0);
           c_in : in STD_LOGIC;
           sum : out STD_LOGIC_VECTOR (data_width - 1 downto 0);
           c_out : out STD_LOGIC);
end component;

signal a, b, sum : std_logic_vector (15 downto 0) := (others => '0');
signal c_in, c_out : std_logic := '0';

begin

dut : full_adder_nbit generic map (data_width => 16) 
port map ( a => a, b => b, c_in => c_in, sum => sum, c_out => c_out);

test : process begin 
    wait for 100ns;
    a <= x"1111";
    b <= x"1111";
    c_in <= '0';
    wait for 10ns;
    assert (sum = x"2222") and (c_out = '0')
    report "Error adding" severity error;
    
    a <= x"FFFF";
    b <= x"0001"; 
    c_in <= '0';
    wait for 10ns;
    assert (sum = x"0000") and (c_out = '1') 
    report "light overflow error" severity error;
    
    a <= x"0001";
    b <= x"FFFF";
    c_in <= '1';
    wait for 10ns;
    assert (sum = x"0001") and (c_out = '1')
    report "heavy overflow error" severity error;
    
end process test;

end Behavioral;
