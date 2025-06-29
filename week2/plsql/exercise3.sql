SET SERVEROUTPUT ON;
DECLARE
   -- Record for accounts
   TYPE AccountRec IS RECORD (
      account_id      NUMBER,
      account_type    VARCHAR2(10),
      balance         NUMBER
   );

   -- Record for employees
   TYPE EmployeeRec IS RECORD (
      employee_id     NUMBER,
      department_id   NUMBER,
      salary          NUMBER
   );

   -- Account and Employee Tables
   TYPE AccountTable IS TABLE OF AccountRec INDEX BY PLS_INTEGER;
   TYPE EmployeeTable IS TABLE OF EmployeeRec INDEX BY PLS_INTEGER;

   accounts  AccountTable;
   employees EmployeeTable;

   -- Procedure 1: Process Monthly Interest
   PROCEDURE ProcessMonthlyInterest IS
   BEGIN
      FOR i IN accounts.FIRST .. accounts.LAST LOOP
         IF accounts(i).account_type = 'SAVINGS' THEN
            accounts(i).balance := accounts(i).balance + (accounts(i).balance * 0.01);
            DBMS_OUTPUT.PUT_LINE('Interest added for Account ' || accounts(i).account_id ||
                                 '. New Balance: ₹' || accounts(i).balance);
         END IF;
      END LOOP;
   END;

   -- Procedure 2: Update Employee Bonus
   PROCEDURE UpdateEmployeeBonus(p_dept IN NUMBER, p_bonus_pct IN NUMBER) IS
   BEGIN
      FOR i IN employees.FIRST .. employees.LAST LOOP
         IF employees(i).department_id = p_dept THEN
            employees(i).salary := employees(i).salary + (employees(i).salary * p_bonus_pct / 100);
            DBMS_OUTPUT.PUT_LINE('Bonus added for Employee ' || employees(i).employee_id ||
                                 '. New Salary: ₹' || employees(i).salary);
         END IF;
      END LOOP;
   END;

   -- Procedure 3: Transfer Funds
   PROCEDURE TransferFunds(p_from IN NUMBER, p_to IN NUMBER, p_amt IN NUMBER) IS
      from_index PLS_INTEGER := -1;
      to_index   PLS_INTEGER := -1;
   BEGIN
      -- Find indexes for both accounts
      FOR i IN accounts.FIRST .. accounts.LAST LOOP
         IF accounts(i).account_id = p_from THEN
            from_index := i;
         ELSIF accounts(i).account_id = p_to THEN
            to_index := i;
         END IF;
      END LOOP;

      IF from_index = -1 OR to_index = -1 THEN
         DBMS_OUTPUT.PUT_LINE(' Account not found.');
         RETURN;
      END IF;

      IF accounts(from_index).balance < p_amt THEN
         DBMS_OUTPUT.PUT_LINE(' Insufficient funds in account ' || p_from);
      ELSE
         accounts(from_index).balance := accounts(from_index).balance - p_amt;
         accounts(to_index).balance := accounts(to_index).balance + p_amt;
         DBMS_OUTPUT.PUT_LINE(' Transferred ₹' || p_amt || ' from ' || p_from || ' to ' || p_to);
      END IF;
   END;

BEGIN
   -- Sample Data
   accounts(1) := AccountRec(1001, 'SAVINGS', 5000);
   accounts(2) := AccountRec(1002, 'CURRENT', 7000);
   accounts(3) := AccountRec(1003, 'SAVINGS', 8000);

   employees(1) := EmployeeRec(201, 10, 30000);
   employees(2) := EmployeeRec(202, 20, 40000);
   employees(3) := EmployeeRec(203, 10, 35000);

   -- Run Procedures
   DBMS_OUTPUT.PUT_LINE('--- Running Monthly Interest ---');
   ProcessMonthlyInterest;

   DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Updating Employee Bonus ---');
   UpdateEmployeeBonus(10, 15);  -- 15% bonus for department 10

   DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Transferring Funds ---');
   TransferFunds(1001, 1002, 2000);  -- Transfer ₹2000 from 1001 to 1002
END;
/
