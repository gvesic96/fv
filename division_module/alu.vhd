----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/18/2025 11:11:32 PM
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
--use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
    Generic(WIDTH : positive := 64);
    Port (
        op1 : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        op2 : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        sel : in std_logic;
        en : in std_logic;
        
        result : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)        
        
     );
end alu;

architecture Behavioral of alu is

begin

    alu: process (en, sel) is
    begin
      if(en = '1') then
        if(sel ='0') then
            
            result <= std_logic_vector(unsigned(op1) + unsigned(op2));
          else
            
            result <= std_logic_vector(unsigned(op1) + (not(unsigned(op2))+1));
        
        end if;
        else
        result <= (others=>'1');
      end if;
      
    end process alu;



end Behavioral;
