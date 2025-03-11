----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/18/2025 11:11:10 PM
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
    Generic(WIDTH : positive := 64);
    Port ( clk : in std_logic;
           rst : in std_logic;
           we : in std_logic;
           d : in std_logic_vector(WIDTH-1 downto 0);
           
           q : out std_logic_vector(WIDTH-1 downto 0)
    );
end pipo_reg;

architecture Behavioral of pipo_reg is

    signal q_s : std_logic_vector(WIDTH-1 downto 0) := (others => '0');

begin

    pipo_reg: process (rst, clk) is
    begin
      if(rst = '1') then
        q_s <= (others => '0');
      else
        if(clk'event and clk='1') then
          if (we = '1') then
            q_s <= d;
          else
            q_s <= q_s;
          end if;
        end if;
      end if;
    end process pipo_reg;

    q <= q_s;

end Behavioral;
