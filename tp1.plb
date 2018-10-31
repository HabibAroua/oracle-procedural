Declare 
begin
     insert into countries values('Tn','Tunisia',4);
End;

set SERVEROUTPUT on
Declare
    v_nom varchar2(50) ;
    v_prenom varchar2(50);
begin
     select first_name , last_name
     into v_prenom , v_nom
     From employees
     Where employee_id=100;
     dbms_output.put_line('Nom :'||v_nom||' prenom : '||v_prenom);
End;

set serveroutput on
Declare
    v_nom varchar2(50); --employees.first_name%type;
    v_prenom varchar2(50); -- employees.last_name%type;
Begin
    select first_name, last_name
    into v_prenom, v_nom
    FROM EMPLOYEES
    where employee_id = 100;
    SYS.dbms_output.put_line('NOM : '||v_nom||' Prenom : '||v_prenom);
END;

Declare
    v_commision employees.commission_pct%TYPE;
    v_salalire employees.salary%TYPE;
Begin
    select commission_pct , salary
    into v_commision , v_salalire
    FROM employees
    where employee_id = 145;
    if v_commision is null then
        DBMS_OUTPUT.PUT_LINE('Le salaire est '||v_salalire);
        else
           DBMS_OUTPUT.PUT_line('Le salaire est  '||v_salalire||' commision '||v_commision);
    end if;
END;