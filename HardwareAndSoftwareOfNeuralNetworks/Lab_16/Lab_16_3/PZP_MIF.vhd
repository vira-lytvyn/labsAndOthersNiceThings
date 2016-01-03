library ieee, altera;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use altera.altera_syn_attributes.all;
entity PZP_MIF is
	port (clk: in std_logic;
		  addr: in natural range 0 to 63;
		q: out std_logic_vector (7 downto 0));
end entity;
architecture rtl of PZP_MIF is
	type PZP_MIF_t is array (63 downto 0) of std_logic_vector(7 downto 0);
	signal rom: PZP_MIF_t;
	attribute ram_init_file: string;
	attribute ram_init_file of rom: signal is "PZP_MIF.mif";
begin
	process(clk)
	begin
	if(rising_edge(clk)) then
		q <= rom(addr);
	end if;
	end process;
end rtl;
