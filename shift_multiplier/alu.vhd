----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2025 01:32:31 PM
-- Design Name: 
-- Module Name: alu - Behavioral
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
--use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
    Generic(WIDTH : integer := 4);
    Port ( input_1 : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           input_2 : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           en : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR(WIDTH-1 downto 0));
end alu;

architecture Behavioral of alu is
    
    signal output_s : STD_LOGIC_VECTOR(WIDTH-1 downto 0); -- 1 bit more than operands
    
begin
    
    alu:process (en)
    begin
        if (en = '1') then
            output_s <= input_1 + input_2;
        end if;
    end process alu;
    
    output <= output_s(WIDTH-1 downto 0);--in case of overflow dropping highest bit

end Behavioral;
