library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

library work;
use work.utils.all;

entity test_bench is

end test_bench;

architecture arch of test_bench is
	component Neural_netowrk is
	generic (
		n : integer := 20
		);

	port (
		clk : in std_logic;
		xt_s: in matrix_1_4_array (0 to 19, 0 to 0);
		uc, uo, ui, uf: in matrix_8_8;
		wc, wo, wi, wf: in matrix_4_8;
		bo, bi, bf, bc: in matrix_1_8;
		biases : in matrix_1_2;
		weight: in matrix_8_2;
		classify_out: out matrix_1_2
		);
end component;

signal clk, start, ready : std_logic;
signal classify_out: matrix_1_2;
signal xt_s:  matrix_1_4_array (0 to 19, 0 to 0);
signal uc, uo, ui, uf: matrix_8_8;
signal wc, wo, wi, wf: matrix_4_8;
signal bo, bi, bf, bc: matrix_1_8;
signal biases : matrix_1_2;
signal 	weight:  matrix_8_2;
type read_type is (none, t_wi, t_wf, t_wc, t_wo, t_ui, t_uf, t_uc, t_uo, t_bi, t_bf, t_bc, t_bo, t_biases, t_weight, t_xt);

begin
	ut: Neural_netowrk port map (clk, xt_s, uc, uo, ui, uf, wc, wo, wi, wf, bo, bi, bf, bc,biases,weight, classify_out);
	start <= '1';
	clk_gen: process
	begin
		clk <= '0';
		wait for 50 ns;    clk <= '1' and ready;
		wait for 50 ns;
	end process clk_gen;

	read_file : process(start) is
	variable l1: line;                               
	variable v1: real;                        
	file f1: text open read_mode is "data.txt";
	variable l_counter: integer := 0;
	variable reading_type : read_type;
	variable v_uc, v_uo, v_ui, v_uf:matrix_8_8;
	variable v_wc, v_wo, v_wi, v_wf:matrix_4_8;
	variable v_bo, v_bi, v_bf, v_bc: matrix_1_8;
	variable v_xt_s: matrix_1_4_array (0 to 19, 0 to 0);
	variable v_biases :  matrix_1_2;
	variable v_weight:  matrix_8_2;

	begin
		l_counter := 0;
		reading_type := t_wi;
		ready <= '0';
		while true loop
			case reading_type is
			when t_wi =>
			for i in 0 to 3 loop
				readline (f1, l1);
				for j in 0 to 7 loop
					read(l1, v_wi(i, j));
				end loop;
			end loop;
			reading_type := t_wf;

			when t_wf =>
			for i in 0 to 3 loop
				readline (f1, l1);
				for j in 0 to 7 loop
					read(l1, v_wf(i, j));
				end loop;
			end loop;
			reading_type := t_wc;

			when t_wc =>
			for i in 0 to 3 loop
				readline (f1, l1);
				for j in 0 to 7 loop
					read(l1, v_wc(i, j));
				end loop;
			end loop;
			reading_type := t_wo;

			when t_wo =>
			for i in 0 to 3 loop
				readline (f1, l1);
				for j in 0 to 7 loop
					read(l1, v_wo(i, j));
				end loop;
			end loop;
			reading_type := t_ui;

			when t_ui =>
			for i in 0 to 7 loop
				readline (f1, l1);
				for j in 0 to 7 loop
					read(l1, v_ui(i, j));
				end loop;
			end loop;
			reading_type := t_uf;

			when t_uf =>
			for i in 0 to 7 loop
				readline (f1, l1);
				for j in 0 to 7 loop
					read(l1, v_uf(i, j));
				end loop;
			end loop;
			reading_type := t_uc;

			when t_uc =>
			for i in 0 to 7 loop
				readline (f1, l1);
				for j in 0 to 7 loop
					read(l1, v_uc(i, j));
				end loop;
			end loop;
			reading_type := t_uo;

			when t_uo =>
			for i in 0 to 7 loop
				readline (f1, l1);
				for j in 0 to 7 loop
					read(l1, v_uo(i, j));
				end loop;
			end loop;
			reading_type := t_bi;

			when t_bi =>
			readline (f1, l1);
			for i in 0 to 7 loop
				read(l1, v_bi(0, i));
			end loop;
			reading_type := t_bf;

			when t_bf =>
			readline (f1, l1);
			for i in 0 to 7 loop
				read(l1, v_bf(0, i));
			end loop;
			reading_type := t_bc;

			when t_bc =>
			readline (f1, l1);
			for i in 0 to 7 loop
				read(l1, v_bc(0, i));
			end loop;
			reading_type := t_bo;

			when t_bo =>
			readline (f1, l1);
			for i in 0 to 7 loop
				read(l1, v_bo(0, i));
			end loop;
			reading_type := t_weight;

			when t_weight =>
			for i in 0 to 7 loop
				readline (f1, l1);
				for j in 0 to 1 loop
					read(l1, v_weight(i, j));
				end loop;
			end loop;
			reading_type := t_biases;

			when t_biases =>
			readline (f1, l1);
			for i in 0 to 1 loop
				read(l1, v_biases(0, i));
			end loop;
			reading_type := t_xt;

			when t_xt =>
			for i in 0 to 19 loop
				readline (f1, l1);
				for j in 0 to 3 loop
					read(l1, v_xt_s(i,0)(0, j));
				end loop;
			end loop;
			reading_type := none;

			when others =>
			exit;
		end case;
	end loop;

	uc <= v_uc;
	uo <= v_uo;
	ui <= v_ui;
	uf <= v_uf;
	wc <= v_wc;
	wo <= v_wo;
	wi <= v_wi;
	wf <= v_wf;
	bo <= v_bo;
	bi <= v_bi;
	bf <= v_bf;
	bc <= v_bc;
	biases <= v_biases;
	weight <= v_weight;
	xt_s <= v_xt_s;
	ready <= '1';
end process read_file;

end arch;