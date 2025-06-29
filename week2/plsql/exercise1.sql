SET SERVEROUTPUT ON;
DECLARE
   -- Define a structure for customer details
   TYPE CustomerInfo IS RECORD (
      full_name         VARCHAR2(100),
      years             NUMBER,
      account_balance   NUMBER,
      vip_status        CHAR(1),
      interest_rate     NUMBER,
      due_date          DATE
   );

   -- Collection to simulate database table
   TYPE CustomerList IS TABLE OF CustomerInfo INDEX BY PLS_INTEGER;
   c_data CustomerList;

   current_date DATE := SYSDATE;
   limit_date   DATE := SYSDATE + 30;
BEGIN
   -- Dummy data to test logic
   c_data(1) := CustomerInfo('Suresh', 67, 15000, 'N', 9.5, SYSDATE + 8);
   c_data(2) := CustomerInfo('Meena', 55, 8700, 'N', 8.0, SYSDATE + 45);
   c_data(3) := CustomerInfo('Lakshmi', 72, 20050, 'N', 10.5, SYSDATE + 25);

   -- Apply discount for seniors
   DBMS_OUTPUT.PUT_LINE('--- Checking senior citizens for interest rate reduction ---');
   FOR idx IN c_data.FIRST .. c_data.LAST LOOP
      IF c_data(idx).years > 60 THEN
         c_data(idx).interest_rate := c_data(idx).interest_rate - 1;
         DBMS_OUTPUT.PUT_LINE(c_data(idx).full_name || ' is eligible. New Rate: ' || c_data(idx).interest_rate || '%');
      END IF;
   END LOOP;

   -- Promote high balance users to VIP
   DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Identifying potential VIP customers ---');
   FOR idx IN c_data.FIRST .. c_data.LAST LOOP
      IF c_data(idx).account_balance > 10000 THEN
         c_data(idx).vip_status := 'Y';
         DBMS_OUTPUT.PUT_LINE(c_data(idx).full_name || ' upgraded to VIP.');
      END IF;
   END LOOP;

   -- Notify users with upcoming due loans
   DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Sending loan due alerts for the next 30 days ---');
   FOR idx IN c_data.FIRST .. c_data.LAST LOOP
      IF c_data(idx).due_date BETWEEN current_date AND limit_date THEN
         DBMS_OUTPUT.PUT_LINE('Notice: ' || c_data(idx).full_name || ', your loan is due on ' || TO_CHAR(c_data(idx).due_date, 'DD-Mon-YYYY'));
      END IF;
   END LOOP;
END;
/
