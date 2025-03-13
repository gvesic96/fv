----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2025 01:06:21 AM
-- Design Name: 
-- Module Name: tb - Behavioral
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

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
constant width_tb : positive := 64;

    --instanciranje komponente
    --TESTBENCH FOR ALU
    
    component alu is
        Generic(WIDTH : positive := width_tb);
        Port(
            op1 : in STD_LOGIC_VECTOR(2*width_tb-1 downto 0);
            op2 : in STD_LOGIC_VECTOR(2*width_tb-1 downto 0);
            en : in std_logic;
            sel : in std_logic;
            result : out STD_LOGIC_VECTOR(2*width_tb-1 downto 0)
            );
    end component alu;

    signal en_in_s, sel_in_s : std_logic;
    signal op1_in_s, op2_in_s : std_logic_vector(2*width_tb-1 downto 0);
    signal result_s : std_logic_vector(2*width_tb-1 downto 0);
begin

    design_under_verification: alu
        generic map(WIDTH => width_tb)
        port map(
            en => en_in_s,
            sel => sel_in_s,
            op1 => op1_in_s,
            op2 => op2_in_s,
            
            result => result_s
        );


    
    stim_gen:process
    begin
       
        en_in_s <= '0', '1' after 75 ns;
        sel_in_s <= '0', '1' after 90 ns, '0' after 130 ns, '1' after 300 ns, '0' after 400ns;
        op1_in_s <= x"00000000000000000000000000000002", x"00000000000000000000000000000001" after 50ns;
        op2_in_s <= x"00000000000000000000000000000001", x"00000000000000000000000000000005" after 50ns;
   
        wait;
    end process stim_gen;


end Behavioral;
