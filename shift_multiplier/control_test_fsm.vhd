----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2025 02:28:45 PM
-- Design Name: 
-- Module Name: control_test_fsm - Behavioral
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
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_test_fsm is
    Generic (WIDTH : integer := 64);
    Port (clk : in STD_LOGIC;
          rst : in STD_LOGIC;
          start : in STD_LOGIC;
          multiplier : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
          --op1, op2 : in STD_LOGIC_VECTOR (63 downto 0);
          
          ready : out STD_LOGIC;
          alu_en : out STD_LOGIC;
          product_we : out STD_LOGIC;
          ctrl_multiplicand : out STD_LOGIC_VECTOR (1 downto 0);
          ctrl_multiplier : out STD_LOGIC_VECTOR (1 downto 0)
    );
end control_test_fsm;

architecture Behavioral of control_test_fsm is

    type mc_state_type is (IDLE, LOAD, MULTIPLY_1, MULTIPLY_2, MULTIPLY_3);
    signal state_reg, state_next : mc_state_type;
    signal count_s : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');

begin

    --process that implements state register
    state_proc: process (clk, rst) is
    begin
        if(rst='1') then
          state_reg <= IDLE;
        else
            if(clk'event and clk='1') then
              state_reg <= state_next;
            end if;
        end if;
    end process state_proc;

    --process that implements logic for Moore FSM
    control_proc: process (state_reg, start) is
    begin
        case state_reg is
            when IDLE =>
              if(start='1') then
                count_s <= "0000000";
                ready <= '0';
                state_next <= LOAD;
              else
                state_next <= IDLE;
                --maybe add signal to hold and set output to zero?
              end if;
            when LOAD =>
              ctrl_multiplier <= "11"; --load value
              ctrl_multiplicand <= "11"; --load value
              state_next <= MULTIPLY_1;
            when MULTIPLY_1 =>
              if (multiplier(0)='1') then
                alu_en <= '1'; --sumarize inputs of ALU
                product_we <= '1'; --enable writing value into product register
                state_next <= MULTIPLY_2;
              else
                state_next <= MULTIPLY_2;
              end if;
            when MULTIPLY_2 =>
              product_we <= '0';
              alu_en <= '0';
              ctrl_multiplicand <= "01";
              ctrl_multiplier <= "10";
              state_next <= MULTIPLY_3;
            when MULTIPLY_3 =>
              --UVECATI BROJAC za jedan i vratiti se u MULTIPLY_1 stanje
              ctrl_multiplicand <= "00";
              ctrl_multiplier <= "00";
              count_s <= count_s + 1;
              if(count_s < conv_std_logic_vector(64, 7)) then
                state_next <= MULTIPLY_1;
                else
                ready <= '1';
                state_next <= IDLE;
              end if;
            when others =>
              state_next <= IDLE;
        end case;
    
    end process control_proc;

end Behavioral;
