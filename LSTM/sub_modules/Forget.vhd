library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.utils.all;

entity Forget is
	port (
		en, clk : in std_logic;
		uf : in matrix_8_8;
		wf : in matrix_4_8;
		xt : in matrix_1_4;
		ht_1 : in matrix_1_8;
		bf : in matrix_1_8;
		ft : out matrix_1_8
		);
end Forget;

architecture imp of Forget is

	component matrix_sig is
	port (
		clk, en: in std_logic;
		matrix: in farray;
		result: out  farray
		);
end component;

signal sig_in : matrix_1_8;

begin
	ms: matrix_sig port map(clk, en, sig_in, ft);

	calc : process(clk) is
	variable t0, t1 : matrix_1_8;
	
	begin
		if (rising_edge(clk)) then
			t0 := matrix_mul(xt, wf);
			t1 := matrix_mul(ht_1, uf);
			t0:= matrix_add(t0, t1);
			t0 := matrix_add(t0, bf);
			sig_in <= t0;
		end if;
	end process;
end imp;