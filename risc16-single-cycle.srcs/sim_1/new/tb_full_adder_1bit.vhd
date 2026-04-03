----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2026 04:44:14 PM
-- Design Name: 
-- Module Name: tb_full_adder_1bit - Behavioral
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

entity tb_full_adder_1bit is
--  Port ( );
end tb_full_adder_1bit;

architecture Behavioral of tb_full_adder_1bit is

component full_adder_1bit is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           c_in : in STD_LOGIC;
           sum : out STD_LOGIC;
           c_out : out STD_LOGIC);
end component;

signal a, b, c_in, sum, c_out : std_logic := '0';

begin

dut : full_adder_1bit port map (a => a, b => b, c_in => c_in, sum => sum, c_out => c_out);

-- test process taken from:
-- https://allaboutfpga.com/vhdl-code-for-full-adder/?srsltid=AfmBOoolbG51hDna_wDlKp-6nsdTAUkAW_MYP6IqkBqYY3Ozj88rnqAi
 -- Stimulus process
 stim_proc: process
 begin
 -- hold reset state for 100 ns.
 wait for 100 ns;
 
 -- insert stimulus here
 a <= '1';
 b <= '0';
 c_in <= '0';
 wait for 10 ns;
 assert (sum = '1') and (c_out = '0');
 
 a <= '0';
 b <= '1';
 c_in <= '0';
 wait for 10 ns;
 assert (sum = '1') and (c_out = '0');
 
 a <= '1';
 b <= '1';
 c_in <= '0';
 wait for 10 ns;
 assert (sum = '0') and (c_out = '1');
 
 a <= '0';
 b <= '0';
 c_in <= '1';
 wait for 10 ns;
 assert (sum = '1') and (c_out = '0');
 
 a <= '1';
 b <= '0';
 c_in <= '1';
 wait for 10 ns;
 assert (sum = '0') and (c_out = '1');
 
 a <= '0';
 b <= '1';
 c_in <= '1';
 wait for 10 ns;
 assert (sum = '0') and (c_out = '1');
 
 a <= '1';
 b <= '1';
 c_in <= '1';
 wait for 10 ns;
 assert (sum = '1') and (c_out = '1');
 
 end process;
end Behavioral;
