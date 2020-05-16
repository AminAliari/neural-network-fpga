library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

library work;
use work.utils.all;

entity LSTM_Cell is
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
end LSTM_Cell;

architecture arch of LSTM_Cell is

	component Forget is
	port (
		en, clk : in std_logic;
		uf : in matrix_8_8;
		wf : in matrix_4_8;
		xt : in matrix_1_4;
		ht_1 : in matrix_1_8;
		bf : in matrix_1_8;
		ft : out matrix_1_8
		);
end component;

component Input is
port (
	en, clk : in std_logic;
	ui : in matrix_8_8;
	wi : in matrix_4_8;
	xt : in matrix_1_4;
	ht_1 : in matrix_1_8;
	bi : in matrix_1_8;
	it : out matrix_1_8
	);
end component;

component CondidateValue is
port (
	en, clk : in std_logic;
	uc : in matrix_8_8;
	wc : in matrix_4_8;
	xt : in matrix_1_4;
	ht_1 : in matrix_1_8;
	bc : in matrix_1_8;
	nct: out matrix_1_8
	);
end component;

component Output is
port (
	en, clk : in std_logic;
	uo : in matrix_8_8;
	wo : in matrix_4_8;
	xt : in matrix_1_4;
	ht_1 : in matrix_1_8;
	bo : in matrix_1_8;
	ot : out matrix_1_8
	);
end component;

component CT_module is
port (
	en, clk : in std_logic;
	ft, ct_1, nct, it : in matrix_1_8;
	ct: out matrix_1_8
	);
end component;

component HT_module is
port (
	en, clk : in std_logic;
	nct, ot : in matrix_1_8;
	ht: out matrix_1_8
	);
end component;

signal ft_from_forget, it_from_input, ot_from_output, nct_from_condidate: matrix_1_8;

begin
	ut_forget: Forget port map('1', clk, uf, wf, xt, ht_1, bf, ft_from_forget);
	ut_input: Input port map('1', clk, ui, wi, xt, ht_1, bi, it_from_input);
	ut_condidate_value: CondidateValue port map('1', clk, uc, wc, xt, ht_1, bc, nct_from_condidate);
	ut_output: Output port map('1', clk, uo, wo, xt, ht_1, bo, ot_from_output);

	ut_ct: CT_module port map ('1', clk, ft_from_forget, ct_1, nct_from_condidate, it_from_input, ct);
	ut_ht: HT_module port map ('1', clk, nct_from_condidate, ot_from_output, ht);

	ready <= '1';
end arch;