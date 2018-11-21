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