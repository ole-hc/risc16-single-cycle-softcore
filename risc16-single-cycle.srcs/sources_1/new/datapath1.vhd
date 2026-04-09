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
           ir_addr : out STD_LOGIC_VECTOR (15 downto 0);
           br_offset : in std_logic_vector (15 downto 0);
           instruction : in std_logic_vector (15 downto 0);
           idle : out std_logic);
end prog_counter;

architecture Structural of prog_counter is

component full_adder_nbit is
    generic (
           data_width : integer := 16
    );
    Port ( a : in STD_LOGIC_VECTOR (data_width - 1 downto 0);
           b : in STD_LOGIC_VECTOR (data_width - 1 downto 0);
           c_in : in STD_LOGIC;
           sum : out STD_LOGIC_VECTOR (data_width - 1 downto 0);
           c_out : out STD_LOGIC);
end component;

component register_nbit is
    generic (
           data_width : integer := 16
    );
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (data_width - 1 downto 0);
           q : out STD_LOGIC_VECTOR (data_width - 1 downto 0);
           load : in STD_LOGIC);
end component;

component mux_2to1 is
    generic ( data_width : integer := 16);
    Port ( a : in std_logic_vector (data_width - 1 downto 0);
           b : in std_logic_vector (data_width - 1 downto 0);
           sel : in STD_LOGIC;
           y : out std_logic_vector (data_width - 1 downto 0));
end component;

signal pc_value, adder_out, mux_out : std_logic_vector (15 downto 0) := (others => '0');

begin
programm_counter : register_nbit 
    generic map (data_width => 16)
    port map (clk => clk, reset => reset, data => adder_out, q => pc_value, load => load_pc);

pc_adder : full_adder_nbit
    generic map (data_width => 16)
    port map (a => mux_out, b => pc_value, c_in => '1', sum => adder_out);

pc_mux : mux_2to1 
    generic map (data_width => 16)
    port map (a => x"0000", b => br_offset, sel => pc_sel, y => mux_out);

ir_addr <= pc_value;

check_stop : process (instruction) begin
    if (instruction = x"c001") then -- halt cmd
        idle <= '1';
    end if;
end process check_stop;

end Structural;
