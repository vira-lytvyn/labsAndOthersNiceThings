library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PZP_CASE is
port(clock : in  std_logic;
	address : in  std_logic_vector(7 downto 0);
	data_out: out std_logic_vector(3 downto 0));
end PZP_CASE;

architecture behav of PZP_CASE is
begin
process(clock)
	begin
		if rising_edge (clock) then
			case address is
				when "00000000"=> data_out <= "0000";
				when "00000001"=> data_out <= "0001";
				when "00000010"=> data_out <= "0010";
				when "00000011"=> data_out <= "0011";
				when "00000100"=> data_out <= "0100";
				when "00000101"=> data_out <= "0101";
				when "00000110"=> data_out <= "0110";
				when "00000111"=> data_out <= "0111";
				when "00001000"=> data_out <= "1000";
				when "00001001"=> data_out <= "1001";
				when "00001010"=> data_out <= "1010";
				when "00001011"=> data_out <= "1011";
				when "00001100"=> data_out <= "1100";
				when "00001101"=> data_out <= "1101";
				when "00001110"=> data_out <= "1110";
				when others=> data_out <= "1111";
			end case;
		end if;
end process;
end behav;