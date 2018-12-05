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

