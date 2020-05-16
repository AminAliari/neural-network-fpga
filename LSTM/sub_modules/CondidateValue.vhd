library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.utils.all;

entity CondidateValue is
	port (
		en, clk : in std_logic;
		uc : in matrix_8_8;
		wc : in matrix_4_8;
		xt : in matrix_1_4;
		ht_1 : in matrix_1_8;
		bc : in matrix_1_8;
		nct: out matrix_1_8
		);
end CondidateValue;

architecture imp of CondidateValue is

	component matrix_tanh is
	port (
		clk, en: in std_logic;
		matrix: in matrix_1_8;
		result: out  matrix_1_8
		);
end component;

signal sig_in : matrix_1_8;

begin
	ms: matrix_tanh port map(clk, en, sig_in, nct);

	calc : process(clk) is
	variable t0, t1 : matrix_1_8;

	begin
		if (rising_edge(clk)) then
			t0 := matrix_mul(xt, wc);
			t1 := matrix_mul(ht_1, uc);
			t0:= matrix_add(t0, t1);
			t0 := matrix_add(t0, bc);
			sig_in <= t0;
		end if;
	end process;
end imp;