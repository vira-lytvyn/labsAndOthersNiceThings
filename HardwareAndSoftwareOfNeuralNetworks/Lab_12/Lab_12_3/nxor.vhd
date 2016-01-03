Library IEEE; 
use IEEE.std_logic_1164.all; 
entity nxor is 
	port(  A: in std_logic_vector (2 downto 0); 
		Q: out std_logic_vector (0 downto 0)); 
end entity nxor; 
architecture Behave of nxor is 
	begin 
		process (A) 
			begin 
				case A is 
					when "000" => Q <= "0"; 
					when "001" => Q <= "1"; 
					when "010" => Q <= "1"; 
					when "011" => Q <= "0"; 
					when "100" => Q <= "1"; 
					when "101" => Q <= "0"; 
					when "110" => Q <= "0"; 
					when "111" => Q <= "1"; 										
					when others => Q <= "0"; 
				end case; 
		end process; 
	end Behave; 