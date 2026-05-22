----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2026 11:10:02 AM
-- Design Name: 
-- Module Name: ram4k_16 - Behavioral
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

entity ram4k_16 is
    Port ( clk : in STD_LOGIC;
           write_en : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (15 downto 0);
           addr : in STD_LOGIC_VECTOR (15 downto 0);
           data_out : out STD_LOGIC_VECTOR (15 downto 0));
end ram4k_16;

architecture Behavioral of ram4k_16 is

signal addr_internal : std_logic_vector (12 downto 0) := (others => '0');

type mem_array is array (0 to 4095) of std_logic_vector(15 downto 0);
signal ram : mem_array := (others => x"0000");

begin

addr_internal <= addr(12 downto 0);

output : process (clk, addr_internal) begin
    if (rising_edge(clk)) then 
        if (write_en = '1') then
            ram(TO_INTEGER(unsigned(addr_internal))) <= data_in;
        else 
            data_out <= ram(TO_INTEGER(unsigned(addr_internal)));
        end if;
    end if;
end process output;

end Behavioral;
