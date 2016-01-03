library ieee;
 use ieee.std_logic_1164.all;
 
entity T_FF is
 PORT ( T:       in   std_logic;
        CLK:     in   std_logic;
        RST:     in   std_logic;
        PRST:     in   std_logic;
        Q:       out   std_logic);
        
     end T_FF;
     
     Architecture Arch_T_FF of T_FF is

     begin
      FF:process(CLK,RST,PRST)
                variable x:std_logic;
begin
  if (RST='0') then
    x:='0';
   else
     if (RST='1' and PRST='0') then
    x:='1';  
   else
       if (CLK='1' and CLK'EVENT ) then
    if (T='1') then
        x:= not x;   
        
            end if;         
        end if;
         end if;
       end if;
       Q<=x;
            
                end process FF;
                end Arch_T_FF;