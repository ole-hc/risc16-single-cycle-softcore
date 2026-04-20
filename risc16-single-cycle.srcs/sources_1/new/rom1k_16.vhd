----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2026 07:34:09 PM
-- Design Name: 
-- Module Name: rom1k_16 - Behavioral
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

entity rom1k_16 is
    Port ( addr : in STD_LOGIC_VECTOR (9 downto 0);
           data : out STD_LOGIC_VECTOR (15 downto 0));
end rom1k_16;

architecture Behavioral of rom1k_16 is

type mem_array is array (0 to 1023) of std_logic_vector (15 downto 0);
signal memory : mem_array := (
x"240f",
x"2803",
x"c803",
x"0481",
x"297f",
x"c07c",
x"e001",
x"c001", -- halt 
others => x"0000"
);

begin
    data <= memory (TO_INTEGER(unsigned(addr)));
end Behavioral;
