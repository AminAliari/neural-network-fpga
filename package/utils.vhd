library ieee;
use ieee.std_logic_1164.all;

package utils is

-- types
type farray is array (natural range<>, natural range<>) of real;
subtype matrix_1_2 is farray (0 to 0, 0 to 1);
subtype matrix_1_4 is farray (0 to 0, 0 to 3);
subtype matrix_1_8 is farray (0 to 0, 0 to 7);
subtype matrix_8_1 is farray (0 to 7, 0 to 0);
subtype matrix_8_2 is farray (0 to 7, 0 to 1);
subtype matrix_4_8 is farray (0 to 3, 0 to 7);
subtype matrix_8_8 is farray (0 to 7, 0 to 7);

type matrix_1_4_array is array (natural range<>, natural range<>) of matrix_1_4;
type matrix_1_8_array is array (natural range<>, natural range<>) of matrix_1_8;

-- operators
function "+" (l: farray; r : real) return farray;
function "+" (l: real; r : farray) return farray;

-- functions
function matrix_add(a: in farray; b: in farray) return farray;
function matrix_element_mul(a: in farray; b: in farray) return farray;
function matrix_mul(a: in farray; b: in farray) return farray;

end package utils;

package body utils is

-- operators
function "+" (l: farray; r : real) return farray is

variable t : farray;
variable row, column: integer;

begin
	row := l'length(1)-1;
	column := l'length(2)-1;

	for i in 0 to row loop
		for j in 0 to column loop
			t(i, j) := l(i, j) + r;
		end loop;
	end loop;
	
	return t;
end;

function "+" (l: real; r : farray) return farray is

variable t : farray;
variable row, column: integer;

begin
	row := r'length(1)-1;
	column := r'length(2)-1;

	for i in 0 to row loop
		for j in 0 to column loop
			t(i, j) := r(i, j) + l;
		end loop;
	end loop;
	
	return t;
end;

-- functions
function matrix_add(a: in farray; b: in farray) return farray is

variable t: farray(0 to a'length(1)-1, 0 to b'length(2)-1);
variable row, column: integer;

begin
	row := a'length(1)-1;
	column := b'length(2)-1;

	for i in 0 to row loop
		for j in 0 to column loop
			t(i, j) := a(i, j) + b(i, j);
		end loop;
	end loop;

	return t;
end;

function matrix_element_mul(a: in farray; b: in farray) return farray is

variable t: farray(0 to a'length(1)-1, 0 to b'length(2)-1);
variable row, column: integer;

begin
	row := a'length(1)-1;
	column := b'length(2)-1;

	for i in 0 to row loop
		for j in 0 to column loop
			t(i, j) := a(i, j) * b(i, j);
		end loop;
	end loop;

	return t;
end;

function matrix_mul(a: in farray; b: in farray) return farray is

variable t: farray(0 to a'length(1)-1, 0 to b'length(2)-1);
variable a_row, a_column, b_row, b_column: integer;

begin
	a_row := a'length(1)-1;
	a_column := a'length(2) -1 ;
	b_row := b'length(1) -1;
	b_column := b'length(2)-1;

	for i in 0 to a_row loop
		for j in 0 to b_column loop
			t(i, j) := 0.0;
			for k in 0 to a_column loop
				t(i, j) := t(i,j) + (a(i,k) * b(k,j));
			end loop;
		end loop;
	end loop;
	
	return t;
end;

end package body;