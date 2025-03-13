----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/11/2025 12:08:47 AM
-- Design Name: 
-- Module Name: div_module_tb - Behavioral
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

entity div_module_tb is
--  Port ( );
end div_module_tb;

architecture Behavioral of div_module_tb is
constant width_tb : positive := 64;
    
    component division_module is
        Generic(WIDTH : positive := width_tb);
        Port(
            clk, rst : in std_logic;
            start : in STD_LOGIC;
          
            divisor : in STD_LOGIC_VECTOR(width_tb-1 downto 0);
            dividend : in STD_LOGIC_VECTOR(width_tb-1 downto 0);
          
            ready : out STD_LOGIC;
            quotient : out STD_LOGIC_VECTOR(width_tb-1 downto 0);
            remainder : out STD_LOGIC_VECTOR(width_tb-1 downto 0)
            );
    end component division_module;

    signal clk_s, rst_s : std_logic;
    signal divisor_in_s, dividend_in_s : std_logic_vector(width_tb-1 downto 0);
    signal start_s, ready_s : std_logic;
    signal quotient_s, remainder_s : std_logic_vector(width_tb-1 downto 0);

begin

    design_under_verification: division_module
        port map(
            clk => clk_s,
            rst => rst_s,
            start => start_s,
            divisor => divisor_in_s,
            dividend => dividend_in_s,
            ready => ready_s,
            quotient => quotient_s,
            remainder => remainder_s
        );

    clk_gen:process
    begin
        clk_s <= '0', '1' after 100ns;
        wait for 200ns;    
    end process clk_gen;

    
    stim_gen:process
    begin
        rst_s <= '1', '0' after 50ns;
        divisor_in_s <= x"0000000000000001", x"0000000000000002" after 75ns; --tested with bigger numbers working
        dividend_in_s <= x"0000000000000001", x"000000000000000f" after 75ns; --Tested with bigger numbers working
        start_s <= '0', '1' after 250ns, '0' after 350ns;
        wait;
    end process stim_gen;



end Behavioral;
