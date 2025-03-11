----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2025 03:40:52 PM
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity data_path is
    Generic (WIDTH : positive := 64);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           divisor : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           dividend : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           
           divisor_ctrl_cp : in STD_LOGIC_VECTOR(1 downto 0);
           quotient_ctrl_cp : in STD_LOGIC_VECTOR(1 downto 0);
           alu_sel_cp : in STD_LOGIC;
           alu_en_cp : in STD_LOGIC;
           load_sel_cp : in STD_LOGIC;
           rmn_we_cp : in STD_LOGIC;
           d_quotient_cp : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           
           
           rmn_val_cp : out STD_LOGIC_VECTOR(2*WIDTH-1 downto 0);
           
           quotient : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           remainder : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
           );
end data_path;

architecture Struct of data_path is

    signal q_divisor_s : STD_LOGIC_VECTOR(2*WIDTH-1 downto 0);
    signal divisor_s : STD_LOGIC_VECTOR(2*WIDTH-1 downto 0);
    signal q_quotient_s: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
    signal q_remainder_s : STD_LOGIC_VECTOR(2*WIDTH-1 downto 0);
    signal d_remainder_s : STD_LOGIC_VECTOR(2*WIDTH-1 downto 0);
    signal alu_out_s : STD_LOGIC_VECTOR(2*WIDTH-1 downto 0);
    signal dividend_s : STD_LOGIC_VECTOR(2*WIDTH-1 downto 0);
begin

    divisor_s <= divisor & (WIDTH-1 downto 0 => '0'); -- trebalo bi da bude skalabilno
    dividend_s <= (2*WIDTH-1 downto WIDTH => '0') & dividend;
    
    divisor_reg: entity work.shift_reg(Behavioral)
        Generic map(WIDTH => 2*WIDTH)
        Port map( clk => clk,
                  rst => rst,
                  ctrl => divisor_ctrl_cp,
                  d => divisor_s,
                  q => q_divisor_s
        );
    
    quotient_reg: entity work.shift_reg_d0(Behavioral)
        Generic map(WIDTH => WIDTH)
        Port map( clk => clk,
                  rst => rst,
                  ctrl => quotient_ctrl_cp,
                  d => d_quotient_cp,
                  q => q_quotient_s
        );
    
    alu: entity work.alu(Behavioral)
        Generic map(WIDTH => 2*WIDTH)
        Port map( op1 => q_remainder_s,
                  op2 => q_divisor_s,
                  en => alu_en_cp,
                  sel => alu_sel_cp,
                  result => alu_out_s
        );
    
    mux: entity work.mux2on1(Behavioral)
        Generic map(WIDTH => 2*WIDTH)
        Port map( x0 => alu_out_s,
                  x1 => dividend_s,
                  sel => load_sel_cp,
                  y => d_remainder_s
        ); 
    
    remainder_reg: entity work.pipo_reg(Behavioral)
        Generic map(WIDTH => 2*WIDTH)
        Port map( clk => clk,
                  rst => rst,
                  d => d_remainder_s,
                  q => q_remainder_s,
                  we => rmn_we_cp
        );
        
        quotient <= q_quotient_s;
        remainder <= q_remainder_s(WIDTH-1 downto 0);
        rmn_val_cp <= q_remainder_s;

end Struct;
