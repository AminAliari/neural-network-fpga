library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.utils.all;

entity matrix_sig is
	port (
		clk, en: in std_logic;
		matrix: in farray;
		result: out  farray
		);
end matrix_sig;

architecture imp of matrix_sig is
	component sigmoid_module is
	port (
		clk: in std_logic;
		enable: in std_logic;
		input : in real;
		output : out real
		);
end component;

begin
	gen_sig: for i in 0 to matrix'length(2)-1 generate
		st: sigmoid_module port map (clk, en, matrix(0, i), result(0, i));
	end generate gen_sig;
end imp;