/* 
    Ecrire une fonction catalogué qui met à jour les salaires des employés d'un département donné en les augmentation d'un taux donné.
    Elle retourne
    1  : Si tout s'est bien passé
    0  : Si aucun employé ne verifie la condition 
    -1 : En cas d'erreur.
    Emlployee(emp_id, First_name , Last_name , salaire , dept_id)
*/
Create function MiseSaFaire(p_taux in NUMBER(10) , p_dept in NUMBER(10)) IS Return NUMBER
   	BEGIN
	    UPDATE Employee Emp 
		Set Emp.Salaire = Emp.Salaire*(1+p_taux)
		Where Emp.dept_id=p_dept;
		return (1);
		EXCEPTION
		    WHEN NO_DATA_FOUND THEN
	            return (0);
			WHEN OTHERS THEN
			     return (-1);
	END;
	


/* 
    Ecrire une procedure catalogué qui calcule le nombre d'employé
	    - ayant un salaire <1000
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
	    END LOOP;
		EXCEPTION 
		    WHEN OTHERS THEN 
			    ps1:=0;
				ps2:=0;
				ps3:=0;
	END;
	
/*
    Ecrire un trigger qui met à jour le nombre d'employé dans la table Dept à l'insertion ou la suppression d'employé dans la table
	Employé.
	
	Emlployee(emp_id, First_name , Last_name , salaire , dept_id)
	Dept(dept_id , dept_name , nb_emp)
*/
Create Trigger Modif after insert or delete on Emlployee
for each Row
Begin
    IF Inserting THEN
	    update Dept
		set nb_emp=nb_emp+1
		WHERE dept_id=:new.dept_id;
		elsif DELETING THEN
		    update Dept 
			SET nb_emp=nb_emp-1
			WHERE dept_id=:old.dept_id;
	END IF;
	EXCEPTION 
	    WHEN OTHERS THEN
		null;
END;

/*
    Soit la table Historique (utilisateur , date_op , operation).
	Ecrire Trigger qui garde un historique de toute mise à jour (insert/update/delete) sur la Table T.
	Variable prédifinie Oracle.
	_ USER = utilisateur actuelement connecté
	_ SYSDATE = date systéme
*/
Create Trigger HIS AFTER INSERT or DELETE or UPDATE
on T
BEGIN
    IF INSERTING THEN
	    insert into Historique values(USER , SYSDATE , 'Insertion');
	END IF;
	
	IF DELETING THEN
	    insert into Historique values(USER , SYSDATE , 'Suppression');
	END IF;
	
	IF UPDATING THEN
	    insert into Historique values(USER , SYSDATE , 'Mise à jour');
	END IF;
END; 