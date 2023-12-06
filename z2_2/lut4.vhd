----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2023 11:44:22 PM
-- Design Name: 
-- Module Name: lut4 - Behavioral
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

entity lut4 is
    generic(INIT : std_logic_vector(15 downto 0));
    Port ( I3 : in STD_LOGIC;
           I2 : in STD_LOGIC;
           I1 : in STD_LOGIC;
           I0 : in STD_LOGIC;
           O : out STD_LOGIC);
end lut4;

architecture Behavioral of lut4 is
    signal input : std_logic_vector(3 downto 0);
begin
    LUT4_proc : process(input)
	begin
		case input is
			when "0000" => O <= INIT(0);
			when "0001" => O <= INIT(1);
			when "0010" => O <= INIT(2);
			when "0011" => O <= INIT(3);
			when "0100" => O <= INIT(4);
			when "0101" => O <= INIT(5);
			when "0110" => O <= INIT(6);
			when "0111" => O <= INIT(7);
			when "1000" => O <= INIT(8);
			when "1001" => O <= INIT(9);
			when "1010" => O <= INIT(10);
			when "1011" => O <= INIT(11);
			when "1100" => O <= INIT(12);
			when "1101" => O <= INIT(13);
			when "1110" => O <= INIT(14);
			when others => O <= INIT(15);
		end case;
	end process LUT4_proc;
	
	input <= I3 & I2 & I1 & I0;

end Behavioral;
