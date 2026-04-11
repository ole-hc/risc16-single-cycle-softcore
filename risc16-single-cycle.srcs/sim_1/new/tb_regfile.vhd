----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2026 10:30:42 AM
-- Design Name: 
-- Module Name: tb_regfile - Behavioral
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

entity tb_regfile is
--  Port ( );
end tb_regfile;

architecture Behavioral of tb_regfile is

component regfile is
    Port ( clk : in STD_LOGIC;
           reg_write : in STD_LOGIC;
           a_addr : in STD_LOGIC_VECTOR (2 downto 0);
           b_addr : in STD_LOGIC_VECTOR (2 downto 0);
           c_addr : in STD_LOGIC_VECTOR (2 downto 0);
           a_data : out STD_LOGIC_VECTOR (15 downto 0);
           b_data : out STD_LOGIC_VECTOR (15 downto 0);
           c_data : in STD_LOGIC_VECTOR (15 downto 0));
end component;

signal clk, reg_write : std_logic := '0';
signal a_addr, b_addr, c_addr : std_logic_vector (2 downto 0) := (others => '0');
signal a_data, b_data, c_data : std_logic_vector (15 downto 0) := (others => '0');

begin

dut : regfile port map (
    clk => clk, reg_write => reg_write,
    a_addr => a_addr, b_addr => b_addr, c_addr => c_addr,
    a_data => a_data, b_data => b_data, c_data => c_data
);

timing : process begin 
    wait for 25ns;
    clk <= not clk;
end process timing;

stimulus : process begin 
    wait for 100ns; 
    
    reg_write <= '1';
    write: for index in 0 to 7 loop
        c_addr <= std_logic_vector(to_unsigned(index, 3));
        c_data <= std_logic_vector(to_unsigned(index, 16));
        wait until clk = '1';
        wait for 1ps;
    end loop write;
    
    -- read 
    wait for 10ns;
    a_addr <= "001";
    b_addr <= "000";
    wait for 1ps;
    assert a_data = x"0001" and b_data = x"0000"
    report "Error read" severity error;
    
    -- write test reg0
    c_addr <= "000";
    c_data <= x"FFFF";
    wait until clk = '1';
    wait for 1ps;
    
    a_addr <= "000";
    wait for 1ps;
    assert a_data = x"0000"
    report "Reg 0 has been overwritten" severity error;
        
end process stimulus;

end Behavioral;
