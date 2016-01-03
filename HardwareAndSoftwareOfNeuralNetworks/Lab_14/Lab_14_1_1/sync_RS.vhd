library ieee;
use ieee. std_logic_1164.all;
entity sync_RS is
	PORT(S: in std_logic;
		R: in std_logic;
		CLOCK: in std_logic;
		CLR: in std_logic;
		PRESET: in std_logic;
		Q: out std_logic;
		QN: out std_logic);
end sync_RS;
Architecture Arch_sync_RS of sync_RS is
begin
	FF: process (CLOCK, CLR, PRESET)
	variable x: std_logic;
	begin
		if (CLR='0') then
			x:='0';
		elsif (PRESET='0') then
			x:='1';
		elsif (CLOCK='1' and CLOCK'EVENT) then
			if (S='0' and R='0') then
				x:=x;
			elsif (S='1' and R='1')then
				x:='Z';
			elsif (S='0' and R='1')then
				x:='0';
			else
				x:='1';
			end if;
		end if;
		Q <= x;
		QN <= not x;
	end process FF;
end Arch_sync_RS;