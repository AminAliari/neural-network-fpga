library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.numeric_std.all;

entity sigmoid_module is
  Port (
   clk : in std_logic;
   enable : in std_logic;
   input : in real;
   output : out real);
end sigmoid_module;

architecture high_level_sim of sigmoid_module is
  type fifo is array(0 to 5) of real;
  signal internal_regs : fifo;
  begin

    process(clk)
    variable ii : real;
    variable oo : real;
    begin
      if rising_edge(clk) then
        if enable='1' then
          internal_regs(0) <= 1.0 / (1.0 + EXP(-1.0 * input));
        end if;
      end if;
    end process;

    process(clk)

    begin
      if rising_edge(clk) then
        if enable='1' then
          internal_regs(1) <= internal_regs(0);
        end if;
      end if;
    end process;

    process(clk)
    begin
      if rising_edge(clk) then
        if enable='1' then
          internal_regs(2) <= internal_regs(1);
        end if;
      end if;
    end process;

    process(clk)
    begin
      if rising_edge(clk) then
        if enable='1' then
          internal_regs(3) <= internal_regs(2);
        end if;
      end if;
    end process;


    process(clk)
    begin
      if rising_edge(clk) then
        if enable='1' then
          internal_regs(4) <= internal_regs(3);
        end if;
      end if;
    end process;

    process(clk)
    begin
      if rising_edge(clk) then
        if enable='1' then
          internal_regs(5) <= internal_regs(4);
        end if;
      end if;
    end process;
    output <= internal_regs(5);

  end high_level_sim;

