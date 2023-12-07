----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2023 01:25:01 PM
-- Design Name: 
-- Module Name: z2_2 - Behavioral
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

entity z2_2 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           a : in STD_LOGIC;
           b : in STD_LOGIC;
           c : in STD_LOGIC;
           d : in STD_LOGIC;
           e : in STD_LOGIC;
           f : in STD_LOGIC;
           out2 : out STD_LOGIC;
           out1 : out STD_LOGIC);
end z2_2;

architecture Behavioral of z2_2 is

    --MUX DESIGN signals
    signal sel      : std_logic_vector(2 downto 0);
    signal mux_out  : std_logic;
    signal reg_out1 : std_logic;
    
    --LUT DESIGN signals
    signal lut1_s, lut2_s, lut3_s : std_logic;
    signal lut_out  : std_logic;
    signal reg_out2 : std_logic;
    
begin

--MULTIPLEKSER
    sel <= d & e & f;
    
    mux8on1: process(sel, b, c, a)
    begin
        case sel is
            when "000" => mux_out <= b;
            when "001" => mux_out <= b;
            when "010" => mux_out <= c;
            when "011" => mux_out <= a;
            when "100" => mux_out <= '1';
            when "110" => mux_out <= '1';
            when others => mux_out <= '0';        
        end case;
    
    end process;

--LUTOVI
LUT_1 : entity work.lut4
	generic map(INIT => "0101001101010000")
	port map(
		I3 => b,
		I2 => d,
		I1 => e,
		I0 => f,
		O => lut1_s
		);

	LUT_2 : entity work.lut4
	generic map(INIT => "0000010000000000")
	port map(
		I3 => c,
		I2 => d,
		I1 => e,
		I0 => f,
		O => lut2_s
		);

	LUT_3 : entity work.lut4
	generic map(INIT => "0000100000000000")
	port map(
		I3 => a,
		I2 => d,
		I1 => e,
		I0 => f,
		O => lut3_s
		);

	LUT_4 : entity work.lut4
	generic map(INIT => "1111111111111110")
	port map(
		I3 => '0',
		I2 => lut3_s,
		I1 => lut1_s,
		I0 => lut2_s,
		O => lut_out --VAZNO
		);

--D FF for MUX design
    D_reg_mux: process(clk, rst)
    begin
        if(rst = '0') then
            if(clk'event and clk='1') then
                reg_out1 <= mux_out;            
            end if;
        else
            reg_out1 <= '0';
        end if;
                      
    end process;
    out1 <= reg_out1;


--D FF for LUT design
    D_reg_LUT: process(clk, rst)
    begin
        if(rst = '0') then
            if(clk'event and clk='1') then
                reg_out2 <= lut_out;            
            end if;
        else
            reg_out2 <= '0';
        end if;        
              
    end process;
    out2 <= reg_out2;

end Behavioral;
