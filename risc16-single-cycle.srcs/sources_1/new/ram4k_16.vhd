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

entity ram64k_16 is
    Port ( clk      : in  STD_LOGIC;
           write_en : in  STD_LOGIC;
           data_in  : in  STD_LOGIC_VECTOR (15 downto 0);
           addr     : in  STD_LOGIC_VECTOR (15 downto 0);
           data_out : out STD_LOGIC_VECTOR (15 downto 0));
end ram64k_16;

architecture Behavioral of ram64k_16 is
    type mem_t is array (0 to 65535) of std_logic_vector(15 downto 0);
    signal mem : mem_t := (others => (others => '0'));
begin
    process (clk) begin
        if rising_edge(clk) then
            if write_en = '1' then
                mem(to_integer(unsigned(addr))) <= data_in;
            end if;
            data_out <= mem(to_integer(unsigned(addr)));
        end if;
    end process;
end Behavioral;
