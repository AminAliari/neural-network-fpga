library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.utils.all;

entity Classify is
	port (
		en, clk : in std_logic;
		ht : in matrix_1_8;
		biases : in matrix_1_2;
		weight: in matrix_8_2;
		classify_out : out matrix_1_2
		);
end Classify;

architecture imp of Classify is

	component matrix_sig is
	port (
		clk, en: in std_logic;
		matrix: in farray;
		result: out  farray
		);
end component;
signal sig_in : matrix_1_2;

begin
	ms: matrix_sig port map(clk, en, sig_in, classify_out);

	calc : process(clk) is
	variable t0 : matrix_1_2;
	
	begin
		if (rising_edge(clk)) then
			t0 := matrix_mul(ht, weight);
			sig_in <= matrix_add(biases, t0);
		end if;
	end process;
end imp;