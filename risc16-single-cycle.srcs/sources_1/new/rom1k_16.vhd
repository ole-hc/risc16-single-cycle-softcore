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
x"380a",   -- 0x00  addi r6,r0,10     r6 = 10 (Zähler)
x"3c01",   -- 0x01  addi r7,r0,1      r7 = 1  (Stopwert)
x"2402",   -- 0x02  addi r1,r0,2      r1 = 2  (Startwert)
x"0481",   -- 0x03  add  r1,r1,r1     r1 verdoppeln      <- loop
x"8700",   -- 0x04  sw   r1,r6,0      mem[r6] = r1
x"a700",   -- 0x05  lw   r1,r6,0      r1 = mem[r6] (roundtrip)
x"3b7f",   -- 0x06  addi r6,r6,-1     r6 = r6 - 1
x"db81",   -- 0x07  beq  r6,r7,1      wenn r6==1 -> raus (0x09)
x"c07a",   -- 0x08  beq  r0,r0,-6     unbedingt zurück -> 0x03
x"e000",   -- 0x09                    Halt (Self-Loop)
others => x"0000"
);

begin
    data <= memory (TO_INTEGER(unsigned(addr)));
end Behavioral;
