library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.utils.all;

entity HT_module is
	port (
		en, clk : in std_logic;
		ct, ot : in matrix_1_8;
		ht: out matrix_1_8
		);
end HT_module;

architecture imp of HT_module is
	component matrix_tanh is
	port (
		clk, en: in std_logic;
		matrix: in matrix_1_8;
		result: out  matrix_1_8
		);
end component;

signal tan_res : matrix_1_8;
type matrix_1_8_fifo is array (0 to 6) of matrix_1_8;
signal ot_delay : matrix_1_8_fifo;

begin
	ms: matrix_tanh port map(clk, en, ct, tan_res);

	calc : process(clk) is
	begin
		if (rising_edge(clk)) then
			if en = '1' then
				ot_delay(0) <= ot;
				for i in 1 to 6 loop
					ot_delay(i) <= ot_delay(i-1);
				end loop;
				ht <= matrix_element_mul(tan_res, ot_delay(6));
			end if;
		end if;
	end process;
end imp;