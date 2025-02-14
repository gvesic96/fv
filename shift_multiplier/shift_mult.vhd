----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/12/2025 12:44:01 AM
-- Design Name: 
-- Module Name: shift_mult - Struct
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

entity shift_mult is
    Generic(WIDTH : integer := 64);
    Port (clk : in STD_LOGIC;
          rst : in STD_LOGIC;
          start : in STD_LOGIC;
          
          op1_in : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
          op2_in : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
          
          ready : out STD_LOGIC;
          result : out STD_LOGIC_VECTOR(2*WIDTH-1 downto 0)
          
    );
end shift_mult;


architecture Struct of shift_mult is

    signal multiplier_s : std_logic_vector(WIDTH-1 downto 0);
    signal alu_en_s : std_logic;
    signal product_we_s : std_logic;
    signal ctrl_multiplier_s : std_logic_vector(1 downto 0);
    signal ctrl_multiplicand_s : std_logic_vector(1 downto 0);

begin

    control_path: entity work.control_test_fsm(Behavioral)
        generic map(WIDTH => WIDTH)
        port map(clk => clk,
                 rst => rst,
                 start => start,
                 multiplier => multiplier_s,
                 
                 ready => ready,
                 alu_en => alu_en_s,
                 product_we => product_we_s,
                 ctrl_multiplier => ctrl_multiplier_s,
                 ctrl_multiplicand => ctrl_multiplicand_s
        );

    data_path: entity work.data_path(Struct)
        generic map(WIDTH => WIDTH)
        port map(clk => clk,
                 rst => rst,
                 op1 => op1_in,
                 op2 => op2_in,
                 alu_en => alu_en_s,
                 product_we => product_we_s,
                 ctrl_multiplicand => ctrl_multiplicand_s,
                 ctrl_multiplier => ctrl_multiplier_s,
                 
                 multiplier_out => multiplier_s,
                 result => result
        );


end Struct;
