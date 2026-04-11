----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2026 10:18:18 AM
-- Design Name: 
-- Module Name: regfile - Behavioral
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

entity regfile is
    Port ( clk : in STD_LOGIC;
           reg_write : in STD_LOGIC;
           a_addr : in STD_LOGIC_VECTOR (3 downto 0);
           b_addr : in STD_LOGIC_VECTOR (3 downto 0);
           c_addr : in STD_LOGIC_VECTOR (3 downto 0);
           a_data : out STD_LOGIC_VECTOR (15 downto 0);
           b_data : out STD_LOGIC_VECTOR (15 downto 0);
           c_data : in STD_LOGIC_VECTOR (15 downto 0));
end regfile;

architecture Behavioral of regfile is

type reg_array is array (15 downto 0) of std_logic_vector (15 downto 0);
signal regfile : reg_array := (others => x"0000");

begin

a_data <= regfile(TO_INTEGER(unsigned(a_addr)));
b_data <= regfile(TO_INTEGER(unsigned(b_addr)));

write_c : process (clk) begin
    if (rising_edge(clk)) then
        if (reg_write = '1') then
            if (c_addr /= x"0") then
                regfile(TO_INTEGER(unsigned(c_addr))) <= c_data;
            end if;
        end if;
    end if;
end process write_c;
end Behavioral;
