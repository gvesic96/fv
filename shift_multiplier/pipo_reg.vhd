----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2025 01:18:49 PM
-- Design Name: 
-- Module Name: pipo_reg - Behavioral
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

entity pipo_reg is
    Generic( WIDTH : integer := 4);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           we : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           q : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end pipo_reg;

architecture Behavioral of pipo_reg is

begin
    pipo_reg:process (clk, rst) is
    begin

        if(rst='1') then
            q <= (others => '0');
        elsif(clk'event and clk='1') then
            if(we='1') then
               q <= d;
            end if;
        end if;
    
    end process pipo_reg;

end Behavioral;
