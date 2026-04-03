----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2026 03:43:57 PM
-- Design Name: 
-- Module Name: prog_counter - Structural
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

entity prog_counter is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           load_pc : in STD_LOGIC;
           pc_sel : in STD_LOGIC;
           ir_addr : out STD_LOGIC_VECTOR (15 downto 0));
end prog_counter;

architecture Structural of prog_counter is

begin


end Structural;
