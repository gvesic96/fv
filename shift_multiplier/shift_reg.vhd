----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/29/2025 11:33:01 PM
-- Design Name: 
-- Module Name: shift_reg - Behavioral
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


--TREBA DA NAPRAVIM UNIVERZALNI SHIFT REGISTAR KOJI POMERA U OBE STRANE
--TREBA DA IMA ASINHRONI RESET ILI BOLJE SINHRONI?

entity shift_reg is
    Generic(
    WIDTH : integer := 4);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ctrl : in STD_LOGIC_VECTOR (1 downto 0);
           d : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           q : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end shift_reg;

architecture Behavioral of shift_reg is

    signal q_s : std_logic_vector(WIDTH-1 downto 0);
    
begin

    
    shift_reg: process (clk,rst) is
    begin
        if (rst='1') then
            q_s <= (others => '0');
        elsif (clk'event and clk='1') then
            case ctrl is
                when "00" =>
                    --hold current value
                    q_s <= q_s;
                when "01" =>
                    --shift left for 1 and insert 0
                    q_s <= q_s(WIDTH-2 downto 0) & '0';
                when "10" =>
                    --shift right for 1 and insert 0
                    q_s <= '0' & q_s(WIDTH-1 downto 1);
                when others =>
                    --load value from d input
                    q_s <= d;
            end case;
            
        end if;        
    end process;

    q <= q_s;


end Behavioral;
