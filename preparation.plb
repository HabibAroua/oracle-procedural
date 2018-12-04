/*
    La direction des ressources humaines d'une entreprise utilise les tables suivantes pour gérer les salaires de ses employés:
	Employe(p:Matricule,Nom,Prenom,Date_recrutement,#code_grade,#code_categorie_fiscale)
	Grade(p:Code_grade,Nom_grade,Mnt_Salaire)
	Categorie(p:Code_categorie_fiscale,Designation,Taux_imposition)
	Historique_fiscale(p:#Matricule,p:#Mois,Mnt_Salaire_brut,mnt_impot)
	Masse_salariale_mensuelle(p:Mois,masse_salariale)
	p: => clé primaire 
	#: => clé étrangére
	p:# => clé primaire + étrangére
	Sachant que le salaire brut d'un employé est en fonction de son grade et le montant d'impôt déduire du salaire brut dépend de sa catégorie
	fiscale.
*/

/*
    1)Ecrire un bloc PL/SQL qui permet d'afficher pour chaque employé le matricule , le nom , le prénom le montant de salaire correspondant
	  à son grade et le taux d'imposition correspondant à sa catégorie fiscale.
*/
DECALRE 
    CURSOR CUR IS SELECT E.matricule , E.nom , E.prenom , G.Mnt_Salaire , CF.taux_impression
	              FROM Employe E , Grade G , Categorie_fiscale CF
				  WHERE E.code_grade=G.code_grade AND E.code_categorie_fiscale=CF.code_categorie_fiscale
				  ORDER BY E.nom , E.prenom ;
    BEGIN
	    FOR v_cur in cur LOOP
		    dbms_output.put_line(v_cur.nom||' '||v_cur.prenom||' '||v_cur.Mnt_Salaire||' '||v_cur.taux_impression);
		END LOOP;
		EXCEPTION 
		    WHEN NO_DATA_FOUND THEN
			    dbms_output.put_line('Aucun Employe');
			WHEN OTHERS THEN
			    dbms_output.put_line('Erreur');
	END;
	
/*
    2)Ecrire une fonction cataloguée <<Calc_Salaire_Emp>> qui permet de retourner le montant de salaire et le montant d'impôt pour un employé
	  ayant un matricule donné.
*/
