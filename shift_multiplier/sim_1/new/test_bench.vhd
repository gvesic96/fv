----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2025 03:44:15 PM
-- Design Name: 
-- Module Name: test_bench - Behavioral
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_bench is
--  Port ( );
end test_bench;

architecture Behavioral of test_bench is

    constant width_tb : integer := 64;

    --instanciranje komponente
    --component shift_reg is
    --    Generic(WIDTH : integer := width_tb);
    --    Port(
    --        clk, rst : in std_logic;
    --        ctrl : in STD_LOGIC_VECTOR (1 downto 0);
    --        d : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
    --        q : out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    --        );
    --end component shift_reg;
    
    component shift_mult is
        Generic(WIDTH : integer := width_tb);
        Port(
            clk, rst : in std_logic;
            start : in STD_LOGIC;
          
            op1_in : in STD_LOGIC_VECTOR(width_tb-1 downto 0);
            op2_in : in STD_LOGIC_VECTOR(width_tb-1 downto 0);
          
            ready : out STD_LOGIC;
            result : out STD_LOGIC_VECTOR(2*width_tb-1 downto 0)
            );
    end component shift_mult;

    signal clk_s, rst_s : std_logic;
    signal op1_in_s, op2_in_s : std_logic_vector(width_tb-1 downto 0);
    signal start_s, ready_s : std_logic;
    signal result_s : std_logic_vector(2*width_tb-1 downto 0);
    
begin

    design_under_verification: shift_mult
        port map(
            clk => clk_s,
            rst => rst_s,
            start => start_s,
            op1_in => op1_in_s,
            op2_in => op2_in_s,
            ready => ready_s,
            result => result_s
        );

    clk_gen:process
    begin
        clk_s <= '0', '1' after 100ns;
        wait for 200ns;    
    end process clk_gen;

    
    stim_gen:process
    begin
        rst_s <= '1', '0' after 50ns;
        op1_in_s <= x"0000000000000000", x"0000000000000101" after 75ns;
        op2_in_s <= x"0000000000000000", x"0000000000000010" after 75ns;
        start_s <= '0', '1' after 250ns, '0' after 350ns;
        wait;
    end process stim_gen;


end Behavioral;
