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