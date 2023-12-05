----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2023 01:34:56 PM
-- Design Name: 
-- Module Name: z_1_2 - Behavioral
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

entity z_1_2 is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           a : in STD_LOGIC;
           b : in STD_LOGIC;
           c : in STD_LOGIC;
           d : in STD_LOGIC;
           e : in STD_LOGIC;
           f : in STD_LOGIC;
           g : in STD_LOGIC;
           h : in STD_LOGIC;
           o2 : out STD_LOGIC;
           o1 : out STD_LOGIC);
end z_1_2;

architecture Behavioral of z_1_2 is

    signal sel             : std_logic_vector(3 downto 0);    
	signal o1_reg, o1_next : std_logic;
	signal o2_reg, o2_next : std_logic;    
	signal d1_s, d2_s      : std_logic_vector(3 downto 0);

begin
    --model bulovog kola za zadatak 1.2
    sel <= d & c & b & a;

	reg_proc : process(clk, rst) is   
	begin        
		if (rst = '1') then            
			o1_reg <= '0';
			o2_reg <= '0';             
		elsif rising_edge(clk) then            
			o1_reg <= o1_next;
			o2_reg <= o2_next;                 
		end if;    
	end process reg_proc;    
	
	o1 <= o1_reg;
	o2 <= o2_reg;

	o2_next <= ((((not a) and (not b) and (not c) and (not e) and (not f)) or
		     ((a)     and (not b) and (not c) and (e)     and (not f)) or
		     ((not a) and (b)     and (not c) and (not e) and (f))     or
		     ((a)     and (b)     and (not c) and (e)     and (f))     or
		     ((not a) and (not b) and (c)     and (not g) and (not h)) or
		     ((a)     and (not b) and (c)     and (g)     and (not h)) or
		     ((not a) and (b)     and (c)     and (not g) and (h))     or
		     ((a)     and (b)     and (c)     and (g)     and (h))) and (not d)) or d;

	o1_next_proc : process (sel, d1_s, d2_s) is
	begin
		case sel is
			when "0000" => o1_next <= d1_s(0);
			when "0001" => o1_next <= d1_s(1);
			when "0010" => o1_next <= d1_s(2);
			when "0011" => o1_next <= d1_s(3);
			when "0100" => o1_next <= d2_s(0);
			when "0101" => o1_next <= d2_s(1);
			when "0110" => o1_next <= d2_s(2);
			when "0111" => o1_next <= d2_s(3);
			when others => o1_next <= '1';
		end case;
	end process o1_next_proc;

	decoder1 : process (e, f, d1_s) is
		variable d1_in : std_logic_vector(1 downto 0);
	begin
		d1_in := f & e;
		
		case d1_in is
			when "00" => d1_s <= "0001";
			when "01" => d1_s <= "0010";
			when "10" => d1_s <= "0100";
			when "11" => d1_s <= "1000";
			when others => d1_s <= "0000";
		end case;
	end process decoder1;

	decoder2 : process (g, h, d2_s) is
		variable d2_in : std_logic_vector(1 downto 0);
	begin
		d2_in := h & g;
		
		case d2_in is
			when "00" => d2_s <= "0001";
			when "01" => d2_s <= "0010";
			when "10" => d2_s <= "0100";
			when "11" => d2_s <= "1000";			
			when others => d2_s <= "0000";
		end case;
	end process decoder2;

end Behavioral;
