----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/08/2026 03:31:53 PM
-- Design Name: 
-- Module Name: tb_instruction_memory - Behavioral
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

entity tb_instruction_memory is
--  Port ( );
end tb_instruction_memory;

architecture Behavioral of tb_instruction_memory is

component instruction_memory is
    Port ( addr : in STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (15 downto 0));
end component;

signal addr : STD_LOGIC_VECTOR (3 downto 0);
signal data : STD_LOGIC_VECTOR (15 downto 0);

begin

    uut: instruction_memory
        port map (
            addr => addr,
            data => data
        );

    stimulus : process
    begin
        for index in 0 to 15 loop
            addr <= std_logic_vector(to_unsigned(index, 4));
            wait for 25 ns;
        end loop;

        wait; -- Simulation stop
    end process;

end Behavioral;