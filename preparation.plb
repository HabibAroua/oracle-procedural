/*
    La direction des ressources humaines d'une entreprise utilise les tables suivantes pour gérer les salaires de ses employés:
	Employe(p:Matricule,Nom,Prenom,Date_recrutement,#code_grade,#code_categorie_fiscale)
	Grade(p:Code_grade,Nom_grade,Mnt_Salaire)
	Categorie_fiscale(p:Code_categorie_fiscale,Designation,Taux_imposition)
	Historique_Salaire(p:#Matricule,p:#Mois,Mnt_Salaire_brut,mnt_impot)
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
CREATE function calc_Salaire_Emp(v_matricule in varchar , v_mnt_imp out NUMBER , v_mnt_Sal out NUMBER)
    return NUMBER IS
	BEGIN
	    SELECT G.Mnt_Salaire , CA.taux_impression*G.Mnt_Salaire
		into v_mnt_Sal , v_mnt_imp
		FROM Employe E , Grade G , Categorie_fiscale CA
        WHERE E.matricule = v_matricule AND G.code_grade=E.code_grade ;
        return 0;
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN
                return -1;
            WHEN OTHERS THEN
                return -1;			
	END;
	
/*
    3)Ecrire une procedure cataloguée <<Calc_Salaire_Mois>> qui permet de calculer le montant de salaire et le montant d'impôt de tous 
	  les employés pour un mois donné et insère ces données dans la table Historique_Salaire
*/
CREATE procedure Calc_Salaire_Mois (p_mois in Date)
IS 
    CURSOR cur is SELECT matricule FROM Employe
BEGIN
    FOR sal in cur LOOP
	    x:=calc_Salaire_Emp(sal.matricule,v_sal,v_mnt);
		if x = THEN
		    insert into Historique_Salaire VALUES(sal.matricule,p_mois,v_sal,v_mnt);
			ELSE
			    raise erreur;
		END IF;
	END LOOP;
	EXCEPTION 
	    WHEN OTHERS THEN
		    NULL;
END;