library ieee; 
use ieee.std_logic_1164. all ; 
use ieee.std_logic_unsigned. all ; 
use ieee.numeric_std. all ;

entity mem  is
port (clk   :  in std_logic ; 
      Wn_R  :  in std_logic ; 
      CSn   :  in std_logic ; 
      Addr  :  in std_logic_vector ( 4   downto   0 ); 
      Di    :  in std_logic_vector ( 3   downto   0 ); 
      Do    :  out std_logic_vector( 3   downto   0 )); 
end mem; 

architecture syn  of mem  is
type ram_type  is   array ( 15   downto   0 )  of std_logic_vector ( 3   downto   0 ); 
signal RAM : ram_type; 
begin
process (clk, CSn) 
begin
if CSn =  '0'   then
if (clk 'event   and clk =  '1' )  then
if (Wn_R =  '0' )  then
RAM(to_integer( unsigned (addr))) <= Di; 
Do <=  "ZZZZ" ; 
else Do <= RAM(to_integer( unsigned (addr))); 
end   if ; 
end   if ; 
else
Do <=  "ZZZZ" ; 
end   if ; 
end   process ; 
end syn; 