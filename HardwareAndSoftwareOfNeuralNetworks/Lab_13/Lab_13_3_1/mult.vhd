Library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_signed.all;
entity mult is 
	generic (k : integer := 4);
	port(   carryin  : in std_logic ;
			A, B	 : in std_logic_vector (k-1 downto 0); 
			S		 : out std_logic_vector (k-1 downto 0); 
			carryout : out std_logic);
end entity mult; 
architecture Behave of mult is 
	signal Sum : std_logic_vector (k downto 0);
	begin 
		Sum <= ( '0' & A) - ( '0' & B) - carryin ;
		S <= Sum (k-1 downto 0);
		carryout <= Sum(k) ;
	end Behave; 

