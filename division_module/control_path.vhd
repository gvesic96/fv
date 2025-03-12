----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2025 04:34:42 PM
-- Design Name: 
-- Module Name: control_path - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_path is
    Generic( WIDTH : positive := 64);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start : in STD_LOGIC;
           rmn_val : in STD_LOGIC_VECTOR(2*WIDTH-1 downto 0);
           
           
           d_quotient : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
           
           rmn_we : out STD_LOGIC;
           load_sel : out STD_LOGIC;
           alu_en : out STD_LOGIC;
           alu_sel : out STD_LOGIC;
           quotient_ctrl : out STD_LOGIC_VECTOR (1 downto 0);
           divisor_ctrl : out STD_LOGIC_VECTOR (1 downto 0);
           
           ready : out STD_LOGIC);
end control_path;

architecture Behavioral of control_path is

    type mc_state_type is (IDLE, LOAD, DIV_1, DIV_1a, DIV_2, DIV_3a, DIV_3b, READY_STATE);
    signal state_reg, state_next : mc_state_type;

    signal cnt_s : unsigned (6 downto 0) := (others => '0');
begin

    state_proc: process (rst, clk) is
    begin
      if (rst = '1') then
        state_reg <=  IDLE;
      elsif (clk'event and clk = '1') then
        state_reg <= state_next;
      end if;
    end process state_proc;

    control_proc: process (state_reg, start) is
    begin
      --NEED TO ASSIGN DEFAULT VALUES TO OUTPUT SIGNALS
      --cnt_s <= (others => '0');
      d_quotient <= (others => '0');
      rmn_we <= '0';
      load_sel <= '0';
      alu_en <= '0';
      alu_sel <= '0';
      quotient_ctrl <= "00";
      divisor_ctrl <= "00";
      ready <= '0';
      case state_reg is
        when IDLE =>
          if(start = '0') then
            state_next <= IDLE;
          else
            state_next <= LOAD;
          end if;
        when LOAD =>
          divisor_ctrl <= "11";
          load_sel <= '1';
          rmn_we <= '1';
          ready <= '0';
          state_next <= DIV_1;
        when DIV_1 =>
          divisor_ctrl <= "00";
          load_sel <= '0';
          rmn_we <= '1';
          alu_en <=  '1';
          alu_sel <= '1';
          state_next <= DIV_1a;
        when DIV_1a =>
          alu_en <= '0';
          rmn_we <= '0';
          state_next <= DIV_2;
        when DIV_2 =>
          rmn_we <= '0';
          alu_en <= '0';
          if(rmn_val(2*WIDTH-1) = '0') then --TESTING ONLY MSB BIT FOR <0 or >0
            state_next <= DIV_3a;
          else
            state_next <= DIV_3b;
          end if;
        when DIV_3a =>
          --REMAINDER IS POSITIVE
          alu_en <= '0';
          rmn_we <= '0';
          d_quotient(0) <= '1'; --shift '1' from left into quotient register
          quotient_ctrl <= "01";
          divisor_ctrl <= "10";
          cnt_s <= cnt_s +1;
          if(cnt_s < 64) then
            --STARTED COUNTIG FROM 0 -> 64 is the 65th iteration !
            state_next <= DIV_1;
          else
            state_next <= READY_STATE;
            --ready <= '1';
          end if;
          --state_next <= BUFF_STATE;
        when DIV_3b =>
          --REMAINDER IS NEGATIVE
          rmn_we <= '1';
          alu_en <= '1';
          alu_sel <= '0'; --set to zero for ADDITION
          d_quotient(0) <= '0'; --shift '0' from left into quotient register
          quotient_ctrl <= "01";
          divisor_ctrl <= "10";
          cnt_s <= cnt_s + 1;
          if(cnt_s < 64) then
            --STARTED COUNTIG FROM 0 -> 64 is the 65th iteration !
            state_next <= DIV_1;
          else
            state_next <= READY_STATE;
            --ready <= '1';
          end if;
          when READY_STATE =>
            cnt_s <= (others => '0');
            ready <= '1';
            state_next <= IDLE;
          
      end case;
    end process control_proc;
    


end Behavioral;
