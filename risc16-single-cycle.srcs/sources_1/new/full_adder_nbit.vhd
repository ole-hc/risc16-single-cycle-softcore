----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2026 04:52:56 PM
-- Design Name: 
-- Module Name: full_adder_nbit - Structural
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

entity full_adder_nbit is
    generic (
           data_width : integer := 16
    );
    Port ( a : in STD_LOGIC_VECTOR (data_width - 1 downto 0);
           b : in STD_LOGIC_VECTOR (data_width - 1 downto 0);
           c_in : in STD_LOGIC;
           sum : out STD_LOGIC_VECTOR (data_width - 1 downto 0);
           c_out : out STD_LOGIC);
end full_adder_nbit;

architecture Dataflow of full_adder_nbit is

signal sum_temp : signed(data_width downto 0);

begin

    sum_temp <= resize(signed(a), data_width+1) + 
                resize(signed(b), data_width+1) + 
                resize(signed'('0'&c_in), data_width+1);
    sum  <= std_logic_vector(sum_temp(data_width-1 downto 0));
    c_out <= sum_temp(data_width);

end Dataflow;
