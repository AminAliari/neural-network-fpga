library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.utils.all;

entity CT_module is
	port (
		en, clk : in std_logic;
		ft, ct_1, nct, it : in matrix_1_8;
		ct: out matrix_1_8
		);
end CT_module;

architecture imp of CT_module is
	begin

		calc : process(clk) is
		variable t0, t1 : matrix_1_8;

		begin
			if (rising_edge(clk)) then
				t0 := matrix_element_mul(ft, ct_1);
				t1 := matrix_element_mul(it, nct);
				t0:= matrix_add(t0, t1);
				ct <= t0;
			end if;
		end process;
	end imp;