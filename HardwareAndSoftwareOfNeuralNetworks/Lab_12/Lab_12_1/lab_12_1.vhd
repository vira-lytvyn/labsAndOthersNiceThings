Library IEEE; 
use IEEE.std_logic_1164.all; 
entity lab_12_1 is 
	port(  A: in std_logic_vector (2 downto 0); 
		Q: out std_logic_vector (7 downto 0)); 
end entity lab_12_1; 
architecture Behave of lab_12_1 is 
	begin 
		process (A) 
			begin 
				case A is 
					when "000" => Q <= "00000001"; 
					when "001" => Q <= "00000010"; 
					when "010" => Q <= "00000100"; 
					when "011" => Q <= "00001000"; 
					when "100" => Q <= "00010000"; 
					when "101" => Q <= "00100000"; 
					when "110" => Q <= "01000000"; 
					when "111" => Q <= "10000000"; 
					when others => Q <= "00000000"; 
				end case; 
		end process; 
	end Behave; 