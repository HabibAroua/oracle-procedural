DECLARE 
    n1 NUMBER;
    n2 NUMBER;
    n3 NUMBER;
BEGIN
    n1:=2;
    n2:=5;
    n3:=n1+n2;
    dbms_output.put_line('La somme est '||n3);
END;