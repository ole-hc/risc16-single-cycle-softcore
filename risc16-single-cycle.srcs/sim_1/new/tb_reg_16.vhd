----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2026 03:56:37 PM
-- Design Name: 
-- Module Name: tb_reg_16 - Behavioral
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

entity tb_reg_16 is
--  Port ( );
end tb_reg_16;

architecture Behavioral of tb_reg_16 is

component register_nbit is
    generic (
           data_width : integer := 16
    );
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (data_width - 1 downto 0);
           q : out STD_LOGIC_VECTOR (data_width - 1 downto 0);
           load : in STD_LOGIC);
end component;

signal clk, reset, load : std_logic := '0';
signal data, q : std_logic_vector (15 downto 0) := (others => '0');

begin

dut : register_nbit 
generic map (data_width => 16)
port map (clk => clk, reset => reset, data => data, q => q, load => load);

timing : process begin
    wait for 25ns;
    clk <= not clk;
end process timing;

test : process begin
    -- reset 
    reset <= '1';
    wait until clk = '1';
    wait for 1ps;
    assert q = (q'range => '0')
    report "Register reset error" severity error;
    reset <= '0';
    
    -- set without load 
    data <= x"5555";
    load <= '0';
    wait until clk = '1';
    wait for 1ps;
    assert q = (q'range => '0')
    report "Register set without load active" severity error; 
    
    -- set 
    data <= x"5555";
    load <= '1';
    wait until clk = '1';
    wait for 1ps;
    assert q = x"5555"
    report "Register set error" severity error; 
    
    -- reset test
    wait for 10ns;
    reset <= '1';
    assert q = x"5555"
    report "Register reset async" severity error; 
    wait until clk = '1';
    wait for 1ps;
    assert q = (q'range => '0')
    report "Register reset error" severity error;
    
    wait;
    
end process test;
end Behavioral;
