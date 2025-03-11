----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2025 10:00:50 PM
-- Design Name: 
-- Module Name: division_module - Struct
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

entity division_module is
    Generic (WIDTH : positive := 64);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start : in STD_LOGIC;
           divisor : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           dividend : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
                      
           quotient : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           remainder : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           ready : out STD_LOGIC);
end division_module;

architecture Struct of division_module is
    signal rmn_val_s : STD_LOGIC_VECTOR(2*WIDTH-1 downto 0);
    signal d_quotient_s : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
    signal rmn_we_s : STD_LOGIC;
    signal load_sel_s : STD_LOGIC;
    signal alu_en_s : STD_LOGIC;
    signal alu_sel_s : STD_LOGIC;
    signal divisor_ctrl_s : STD_LOGIC_VECTOR(1 downto 0);
    signal quotient_ctrl_s : STD_LOGIC_VECTOR(1 downto 0);

begin

    control_path: entity work.control_path(Behavioral)
        Generic map(WIDTH => WIDTH)
        Port map( clk => clk,
                  rst => rst,
                  start => start,
                  rmn_val => rmn_val_s,
                  d_quotient => d_quotient_s,
                  rmn_we => rmn_we_s,
                  load_sel => load_sel_s,
                  alu_en => alu_en_s,
                  alu_sel => alu_sel_s,
                  divisor_ctrl => divisor_ctrl_s,
                  quotient_ctrl => quotient_ctrl_s,
                  ready => ready
        );

    data_path: entity work.data_path(Struct)
        Generic map(WIDTH => WIDTH)
        Port map( clk => clk,
                  rst => rst,
                  divisor => divisor,
                  dividend => dividend,
                  rmn_val_cp => rmn_val_s,
                  d_quotient_cp => d_quotient_s,
                  rmn_we_cp => rmn_we_s,
                  load_sel_cp => load_sel_s,
                  alu_en_cp => alu_en_s,
                  alu_sel_cp => alu_sel_s,
                  divisor_ctrl_cp => divisor_ctrl_s,
                  quotient_ctrl_cp => quotient_ctrl_s,
                  quotient => quotient,
                  remainder => remainder
        );

end Struct;
