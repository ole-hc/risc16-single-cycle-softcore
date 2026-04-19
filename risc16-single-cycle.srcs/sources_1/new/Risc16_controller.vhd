----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2026 12:21:08 PM
-- Design Name: 
-- Module Name: Risc16_controller - Behavioral
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

entity Risc16_controller is
    Port ( instruction : in STD_LOGIC_VECTOR (15 downto 0);
           a_equ_b : in STD_LOGIC;
           pc_load : out STD_LOGIC;
           pc_sel : out STD_LOGIC;
           reg_write : out STD_LOGIC;
           imm7_op : out STD_LOGIC;
           alu_op : out STD_LOGIC_VECTOR (1 downto 0);
           beq_cmd : out STD_LOGIC;
           idle : out STD_LOGIC);
end Risc16_controller;

architecture Behavioral of Risc16_controller is

signal opcode : std_logic_vector (2 downto 0) := (others => '0');

begin

opcode <= instruction(15 downto 13);

output : process (instruction, a_equ_b) begin
    case opcode is 
        -- add
        when "000" => 
            pc_load <= '1';
            pc_sel <= '0';
            reg_write <= '1';
            imm7_op <= '0';
            alu_op <= "00";
            beq_cmd <= '0';
            idle <= '0';
        -- addi
        when "001" =>
            pc_load <= '1';
            pc_sel <= '0';
            reg_write <= '1';
            imm7_op <= '1';
            alu_op <= "00";
            beq_cmd <= '0';
            idle <= '0';
        -- beq
        when "110" =>
            pc_load <= '1';
            pc_sel <= a_equ_b;
            reg_write <= '0';
            imm7_op <= '0';
            alu_op <= "10";
            beq_cmd <= '1';
            idle <= '0';
        -- halt
        when "111" =>
            pc_load <= '0';
            pc_sel <= '0';
            reg_write <= '0';
            imm7_op <= '0';
            alu_op <= "00";
            beq_cmd <= '0';
            idle <= '1';  
        -- unimplemented opcode 
        when others => 
            idle <= '1';
    end case;
end process output;
    
end Behavioral;
