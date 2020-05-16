library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.utils.all;

entity HT_module is
	port (
		en, clk : in std_logic;
		nct, ot : in matrix_1_8;
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

begin
	ms: matrix_tanh port map(clk, en, nct, tan_res);

	calc : process(clk) is
	begin
		if (rising_edge(clk)) then
			ht <= matrix_element_mul(tan_res, ot);
		end if;
	end process;
end imp;