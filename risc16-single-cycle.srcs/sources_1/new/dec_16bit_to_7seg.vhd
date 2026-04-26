----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 03:41:51 PM
-- Design Name: 
-- Module Name: dec_16bit_to_7seg - Structural
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

entity dec_16bit_to_7seg is
    Port ( data : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           cathode : out STD_LOGIC_VECTOR (7 downto 0);
           anode : out STD_LOGIC_VECTOR (3 downto 0));
end dec_16bit_to_7seg;

architecture Structural of dec_16bit_to_7seg is

component mux_4to1 is
    generic ( data_width : integer := 16);
    Port ( a : in std_logic_vector (data_width - 1 downto 0);
           b : in std_logic_vector (data_width - 1 downto 0);
           c : in std_logic_vector (data_width - 1 downto 0);
           d : in std_logic_vector (data_width - 1 downto 0);
           sel : in STD_LOGIC_vector (1 downto 0);
           y : out std_logic_vector (data_width - 1 downto 0));
end component;

component dec_2to4 is
    Port ( data : in STD_LOGIC_VECTOR (1 downto 0);
           anode : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component dec_hexto7seg is
    Port ( hex : in STD_LOGIC_VECTOR (3 downto 0);
           cathode : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component counter_2bit is
    Port ( clk : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (1 downto 0));
end component;

signal a, b, c, d, current_hex : std_logic_vector(3 downto 0) := x"0";
signal sel : std_logic_vector(1 downto 0) := "00";

begin

a <= data(3 downto 0);
b <= data(7 downto 4);
c <= data(11 downto 8);
d <= data(15 downto 12);

counter : counter_2bit port map (
    clk => clk, 
    q => sel
);

decode_anode : dec_2to4 port map (
    data => sel,
    anode => anode
);

input_mux : mux_4to1 
generic map (
    data_width => 4)
port map (
    a => a, b => b, c => c, d => d,
    sel => sel, 
    y => current_hex
);

hex_decoder : dec_hexto7seg port map (
    hex => current_hex,
    cathode => cathode
);

end Structural;
