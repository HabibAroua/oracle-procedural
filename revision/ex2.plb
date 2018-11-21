/* 
    Ecrire une procedure catalogué qui calcule le nombre d'employé
	    - ayant un salaire <100
		- ayant un salaire entre 1000 et 2000
		- ayant un salaire > 2000
*/

Create procedure Caclcul(ps1 out NUMBER , ps2 out NUMBER , ps3 out NUMBER)IS
    DECLARE 
	    Cursor cur IS Select salaire from Employee;
	BEGIN
	    ps1:=0;
		ps2:=0;
		ps3:=0;
		FOR Sal_enrg in cur LOOP
		    IF(Sal_enrg<1000) THEN
			    ps1:=ps1+1;
				ELSIF (Sal_enrg>2000) THEN
					ps2:=ps2+1;
				ELSE
				    ps3:=ps3+1;
			END IF;
	    END FOR;
		EXCEPTION 
		    WHEN OTHERS THEN 
			    ps1:=0;
				ps2:=0;
				ps3:=0;
	END;