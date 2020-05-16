library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.utils.all;

entity Neural_netowrk is
	generic (
		n : integer := 20
		);

	port (
		clk : in std_logic;
		xt_s: in  matrix_1_4_array (0 to 19, 0 to 0);
		uc, uo, ui, uf: in matrix_8_8;
		wc, wo, wi, wf: in matrix_4_8;
		bo, bi, bf, bc: in matrix_1_8;
		biases : in matrix_1_2;
		weight: in matrix_8_2;
		classify_out: out matrix_1_2
		);
end Neural_netowrk;

architecture arch of Neural_netowrk is
	component LSTM_Cell is
	port (
		clk : in std_logic;
		xt : in matrix_1_4;
		ct_1, ht_1 : in matrix_1_8;
		ht, ct : out matrix_1_8;
		uc, uo, ui, uf: in matrix_8_8;
		wc, wo, wi, wf: in matrix_4_8;
		bo, bi, bf, bc: in matrix_1_8;
		ready : out std_logic 
		);
end component;

component Classify is
port (
	en, clk : in std_logic;
	ht : in matrix_1_8;
	biases : in matrix_1_2;
	weight: in matrix_8_2;
	classify_out : out matrix_1_2
	);
end component;

signal zero_matrix_1_8: matrix_1_8;

signal ct_1_s, ht_1_s: matrix_1_8_array (0 to 0, 0 to n-1);
signal ready_s : std_logic_vector (0 to n-1);

begin
	gen: for i in 0 to 7 generate
		zero_matrix_1_8(0, i) <= 0.0;
	end generate gen;

	lstm0: LSTM_Cell port map (clk,xt_s(0,0),zero_matrix_1_8,zero_matrix_1_8,ht_1_s(0, 0),ct_1_s(0, 0),uc, uo, ui, uf, wc, wo, wi, wf, bo, bi, bf, bc,ready_s(0));

	lstm_cells : for i in 1 to n-1 generate
		lstmi: LSTM_Cell port map (clk,xt_s(i, 0),ct_1_s(0, i-1),ht_1_s(0, i-1),ht_1_s(0, i),ct_1_s(0, i),uc, uo, ui, uf, wc, wo, wi, wf, bo, bi, bf, bc,ready_s(i));
	end generate lstm_cells;
	
	ut_classify: Classify port map ('1', clk, ht_1_s(0, n-1),biases,weight,classify_out);
end arch;