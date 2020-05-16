library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.utils.all;

entity matrix_tanh is
	port (
		clk, en: in std_logic;
		matrix: in matrix_1_8;
		result: out  matrix_1_8
		);
end matrix_tanh;

architecture imp of matrix_tanh is
	component tanh_module is
	Port (
		clk : in std_logic;
		enable : in std_logic;
		input : in real;
		output : out real);
end component;

begin
	gen_tanh: for i in 0 to 7 generate
		st: tanh_module port map (clk, en, matrix(0, i), result(0, i));
	end generate gen_tanh;
end imp;