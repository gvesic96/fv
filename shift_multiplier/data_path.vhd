----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/12/2025 12:54:29 AM
-- Design Name: 
-- Module Name: data_path - Struct
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
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity data_path is
    Generic(WIDTH : integer := 64);
    Port (clk : in STD_LOGIC;
          rst : in STD_LOGIC;
          op1 : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
          op2 : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
          alu_en : in STD_LOGIC;
          product_we : in STD_LOGIC;
          
          ctrl_multiplicand : in STD_LOGIC_VECTOR(1 downto 0);
          ctrl_multiplier : in STD_LOGIC_VECTOR(1 downto 0);
          
          multiplier_out : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
          result : out STD_LOGIC_VECTOR(2*WIDTH-1 downto 0)
         );
end data_path;

architecture Struct of data_path is

    signal q_multiplicand_s : std_logic_vector(2*WIDTH-1 downto 0);
    signal d_multiplicand_s : std_logic_vector(2*WIDTH-1 downto 0);

    signal q_multiplier_s : std_logic_vector(WIDTH-1 downto 0);
    
    signal alu_out_s : std_logic_vector(2*WIDTH-1 downto 0);
    signal alu_input_1_s : std_logic_vector(2*WIDTH-1 downto 0);
    --signal alu_input_2_s : std_logic_vector(2*WIDTH-1 downto 0);
    
begin

    d_multiplicand_s <= x"0000000000000000"&op1;

    multiplicand: entity work.shift_reg(Behavioral)
        generic map(WIDTH => 2*WIDTH)
        port map(clk => clk,
                 rst => rst,
                 ctrl => ctrl_multiplicand,
                 d => d_multiplicand_s,
                 q => q_multiplicand_s
        );

    multiplier: entity work.shift_reg(Behavioral)
        generic map(WIDTH => WIDTH)
        port map(clk => clk,
                 rst => rst,
                 ctrl => ctrl_multiplier,
                 d => op2,
                 q => q_multiplier_s
        );
        
    product: entity work.pipo_reg(Behavioral)
        generic map(WIDTH => 2*WIDTH)
        port map(clk => clk,
                 rst => rst,
                 we => product_we,
                 d => alu_out_s,
                 q => alu_input_1_s
        );    
        
    alu: entity work.alu(Behavioral)
        generic map(WIDTH => 2*WIDTH)
        port map(input_1 => alu_input_1_s,
                 input_2 => q_multiplicand_s,
                 en => alu_en,
                 output => alu_out_s
        );

        result <= alu_input_1_s;
        multiplier_out <= q_multiplier_s;

end Struct;
