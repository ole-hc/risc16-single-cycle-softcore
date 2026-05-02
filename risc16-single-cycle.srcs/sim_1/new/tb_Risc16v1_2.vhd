----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2026 08:03:24 PM
-- Design Name: 
-- Module Name: tb_Risc16v1_2 - Behavioral
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

entity tb_Risc16v1_2 is
--  Port ( );
end tb_Risc16v1_2;

architecture Behavioral of tb_Risc16v1_2 is

component Risc16v1_2 is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           idle : out STD_LOGIC;
           debug_addr : in std_logic_vector(2 downto 0);
           debug_rega_out : out std_logic_vector(15 downto 0);
           anode : out std_logic_vector(3 downto 0);
           cathode : out std_logic_vector(7 downto 0));
end component;

signal reset, clk, idle : std_logic := '0';
signal debug_addr : std_logic_vector(2 downto 0) := (others => '0');
signal debug_rega_out : std_logic_vector(15 downto 0) := (others => '0');
signal anode : std_logic_vector(3 downto 0) := (others => '0');
signal cathode : std_logic_vector(7 downto 0) := (others => '0');

begin

dut : Risc16v1_2 port map (
    reset => reset,
    clk => clk, 
    idle => idle,
    debug_addr => debug_addr,
    debug_rega_out => debug_rega_out,
    anode => anode,
    cathode => cathode
);

timing : process begin 
    wait for 10ns;
    clk <= not clk;
end process timing;

stimulus : process begin
    reset <= '1';
    wait until clk = '1';
    wait for 1ps;
    reset <= '0';
    
    wait;
end process stimulus;

end Behavioral;
