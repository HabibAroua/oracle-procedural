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
    1)
*/