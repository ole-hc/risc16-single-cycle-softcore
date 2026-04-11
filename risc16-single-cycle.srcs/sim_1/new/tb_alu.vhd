----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2026 11:46:28 AM
-- Design Name: 
-- Module Name: tb_alu - Behavioral
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

entity tb_alu is
--  Port ( );
end tb_alu;

architecture Behavioral of tb_alu is

component alu is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           alu_op : in STD_LOGIC_VECTOR (1 downto 0);
           c : out STD_LOGIC_VECTOR (15 downto 0);
           a_equ_b : out STD_LOGIC);
end component;

signal a, b, c : std_logic_vector (15 downto 0) := (others => '0');
signal alu_op : std_logic_vector (1 downto 0) := (others => '0');
signal a_equ_b : std_logic := '0';

begin

dut : alu port map (a => a, b => b, alu_op => alu_op, c => c, a_equ_b => a_equ_b);

stimulus : process begin
    wait for 100ns;
    
    -- add
    alu_op <= "00";
    a <= x"0001";
    b <= x"0001";
    wait for 1ps;
    assert c = x"0002" 
    report "Error in add command" severity error;
    assert a_equ_b = '0'
    report "Error in add command, equ is true" severity warning;
    wait for 10ns;
    
    -- nand
    alu_op <= "01";
    a <= x"F0F0";
    b <= x"3333";
    wait for 1ps;
    assert c = x"CFCF"
    report "Error in nand command" severity error;
    assert a_equ_b = '0'
    report "Error in nand command, equ is true" severity warning;
    wait for 10ns;
    
    -- equ
    alu_op <= "10";
    a <= x"0F0F";
    b <= x"0F0F";
    wait for 1ps;
    assert a_equ_b = '1'
    report "Error equ command, 0 when equ should be true" severity error;
    wait for 10ns;
    b <= x"0000";
    wait for 1ps;
    assert a_equ_b = '0'
    report "Error equ command, 1 when equ should be false" severity error;
    wait for 10ns;
    
end process stimulus;

end Behavioral;
