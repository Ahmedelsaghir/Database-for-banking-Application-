
Build a Database for Application Bank System in USA.
The client ask to design DB system depend on his requirements which are listed as follow:

• System can store data about every branch like Branch ID, Location and Branch Name.
• We need to store data about accounts and their owners, every account has account type (saving or current), account number, balance, account status (active or not active), open date, cards with properties (card number, card type, expiry date, status which is active or not active).
• Customer who linked to account must have id, first name, last name, gender, email, birthdate, phones and age which is depend on birthdate.
• Every branch can make loan to his customers, properties of loan are loan id, loan type, amount, interest rate, start date, end date, duration.
• Many employees work in every branch have id, first name, last name, salary, position.
• Any customer through his account can make many transactions by ATM or in branch without ATM.
• Transaction has Transaction id, Transaction type, Transaction date and amount.
• Every ATM with atm id, location, status is owned by one branch but branch must have many ATM.
• A branch must maintain many accounts and one account at least is maintained by one branch.
• Customer must have one or more account and any account must owned by a customer.
• One customer may make one loan and a loan already is made by a customer.
• Loan must be offered by a branch but a branch offers many loans.
• A branch must contain on many employees and each employee must work in one branch.
• Some of employees in each branch are supervisors, each supervisor supervises the rest of employees who works in the same branch.
• Bank system contain departments with id, name, manager ID from employees, each department must have one employee at least, in the same time every employee must works in one department.


![erd](https://github.com/Ahmedelsaghir/Sales/assets/69742253/aebcf5dd-63ae-4fc2-ba70-6a12a8adfad5)



PHASE I of project begins
1) Create a database for a banking application called ‘Bank Union’.
• Using Our Database ‘Bank Union'.
2) Create all the tables mentioned in the database diagram.
• CREATE TABLE & ADD CONSTRAINTS Section
3) Create all the constraints based on the database diagram.
4) Insert at least 10 rows in each table.
• INSERT rows section
PHASE II of project begins
1) Create Views
   - to get employee details along with department name
   - name of manager employee
   - Create View to view the Loan Summary
   - view to count each transaction and display the sum of transactions
   - create a view to get customer and their account details with the availability loans amount
  
2) Create functions (scalar-inline-table valued)
   - Function to calculate total salary for each department
   - -Returns the name of an employee's supervisor based on their employeeid
   - create function Calculate Monthly payment
   - create function calculate Interest Amount
   - function to getalldataabout info
   - Create table function to return loan customer data
     
3) Create stored procedures
   - Procedure to count employees in each department
   - proc that return the transactions that specific customer had done
   - proc that return the amount of money of specific transaction type
   - Create a stored procedure to add "Dear" as a prefix to customer's name
   - Create a stored procedure that accepts AccountId as a parameter and returns customer's full name and account's details
   - Write a query to remove cstate column from Customer table
    
4) Create triggers
   - Trigger to update last_updated column when an employee is updated
   - Trigger that update balance depend on the transaction type
     
5) Create index
   - Non-clustered index on customer and account joind table
     
6) Default
   - set a default on employee salary at avg of company's salaries
7)  rules
   - set a rule on employee salary bigger than specific number
