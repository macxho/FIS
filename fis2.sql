drop table deductions cascade constraints;
drop table allowance cascade constraints;
drop table overtime cascade constraints;
drop table leave cascade constraints;
drop table salary cascade constraints;
drop table payslip cascade constraints;
drop table payroll cascade constraints;
drop table employee cascade constraints;
drop table department cascade constraints;
drop table job_title cascade constraints;

create table job_title (
    job_title_id number(10) primary key,
    job_title_name varchar2(50) not null,
    job_description varchar2(255),
    minimum_salary number(7, 2),
    maximum_salary number(8, 2),
    job_level varchar2(20)
);

create table department (
    department_id number(10) primary key,
    department_name varchar2(50) not null,
    location varchar2(50),
    phone_number char(10),
    email varchar2(100)
);

create table employee (
    employee_id number(10) primary key,
    employee_name varchar2(100) not null,
    id_number char(13) not null unique,
    phone_number char(10),
    date_employed date,
    department_id number(10),
    job_title_id number(10),
    constraint fk_employee_department 
    foreign key (department_id) 
    references department (department_id),
    constraint fk_employee_job_title 
    foreign key (job_title_id) 
    references job_title (job_title_id)
);

create table payroll (
    payroll_id number(10) primary key,
    employee_id number(10) not null,
    pay_period date not null,
    basic_salary number(8, 2) not null,
    overtime_hours number(4, 2) default 0,
    overtime_pay number(7, 2) default 0,
    bonus number(7, 2) default 0,
    total_allowance number(7, 2) default 0,
    total_deduction number(7, 2) default 0,
    gross_salary number(8, 2) not null,
    net_salary number(8, 2) not null,
    payment_date date,
    payment_method varchar2(30),
    constraint fk_employee_payroll 
    foreign key (employee_id) 
    references employee (employee_id)
);

create table payslip (
    payslip_id number(10) primary key,
    payroll_id number(10) not null,
    employee_id number(10) not null,
    issue_date date,
    constraint fk_payroll_payslip 
    foreign key (payroll_id) 
    references payroll (payroll_id),
    constraint fk_employee_payslip 
    foreign key (employee_id) 
    references employee (employee_id)
);

create table salary (
    salary_id number(10) primary key,
    employee_id number(10) not null,
    basic_salary number(8, 2) not null,
    effective_date date not null,
    end_date date,
    constraint fk_employee_salary 
    foreign key (employee_id) 
    references employee (employee_id)
);

create table leave (
    leave_id number(10) primary key,
    employee_id number(10) not null,
    leave_type varchar2(30) not null,
    start_date date not null,
    end_date date not null,
    number_of_days number(3) not null,
    application_date date,
    leave_reason varchar2(255),
    approval_status varchar2(20) default 'PENDING',
    approved_by number(10),
    approval_date date,
    constraint fk_employee_leave 
    foreign key (employee_id) 
    references employee (employee_id),
    constraint fk_leave_approved_by 
    foreign key (approved_by) 
    references employee (employee_id)
);

create table overtime (
    overtime_id number(10) primary key,
    employee_id number(10) not null,
    overtime_date date not null,
    overtime_hours number(4, 2) not null,
    overtime_rate number(4, 2) not null,
    overtime_pay number(7, 2) not null,
    approval_status varchar2(20) default 'PENDING',
    approved_by number(10),
    constraint fk_employee_overtime 
    foreign key (employee_id) 
    references employee (employee_id),
    constraint fk_overtime_approved_by 
    foreign key (approved_by) 
    references employee (employee_id)
);

create table allowance (
    allowance_id number(10) primary key,
    employee_id number(10) not null,
    housing_allowance number(7, 2) default 0,
    transport_allowance number(7, 2) default 0,
    medical_aid_allowance number(7, 2) default 0,
    effective_date date,
    constraint fk_employee_allowance 
    foreign key (employee_id) 
    references employee (employee_id)
);

create table deductions (
    deductions_id number(10) primary key,
    employee_id number(10) not null,
    deduction_type varchar2(50) not null,
    amount number(7, 2) not null,
    effective_date date,
    constraint fk_employee_deductions 
    foreign key (employee_id) 
    references employee (employee_id)
);

insert into job_title (job_title_id, job_title_name, job_description, minimum_salary, maximum_salary, job_level) values (1, 'Director', 'Top level executive management', 60000.00, 99999.00, 'Executive');
insert into job_title (job_title_id, job_title_name, job_description, minimum_salary, maximum_salary, job_level) values (2, 'Manager', 'Department head and operations manager', 40000.00, 75000.00, 'Senior');
insert into job_title (job_title_id, job_title_name, job_description, minimum_salary, maximum_salary, job_level) values (3, 'Officer', 'Standard administrative staff', 20000.00, 45000.00, 'Mid-Level');
insert into job_title (job_title_id, job_title_name, job_description, minimum_salary, maximum_salary, job_level) values (4, 'Associate', 'Frontline operational staff', 12000.00, 25000.00, 'Entry-Level');

insert into department (department_id, department_name, location, phone_number, email) values (1, 'Management and Administration', 'Building A', '0115550100', 'admin@kwenzakwenzeke.co.za');
insert into department (department_id, department_name, location, phone_number, email) values (2, 'Human Resources', 'Building A', '0115550200', 'hr@kwenzakwenzeke.co.za');
insert into department (department_id, department_name, location, phone_number, email) values (3, 'Finance and Accounting', 'Building A', '0115550300', 'finance@kwenzakwenzeke.co.za');
insert into department (department_id, department_name, location, phone_number, email) values (4, 'Purchasing and Supply Management', 'Building B', '0115550400', 'supply@kwenzakwenzeke.co.za');
insert into department (department_id, department_name, location, phone_number, email) values (5, 'Cashiers and Sales Personnel', 'Main Store', '0115550500', 'sales@kwenzakwenzeke.co.za');
insert into department (department_id, department_name, location, phone_number, email) values (6, 'Stock and Inventory Management', 'Warehouse', '0115550600', 'stock@kwenzakwenzeke.co.za');
insert into department (department_id, department_name, location, phone_number, email) values (7, 'Customer Service', 'Main Lobby', '0115550700', 'support@kwenzakwenzeke.co.za');
insert into department (department_id, department_name, location, phone_number, email) values (8, 'Information Technology', 'Server Room', '0115550800', 'it@kwenzakwenzeke.co.za');
insert into department (department_id, department_name, location, phone_number, email) values (9, 'Security and Safety', 'Gatehouse', '0115550900', 'security@kwenzakwenzeke.co.za');

insert into employee (employee_id, employee_name, id_number, phone_number, date_employed, department_id, job_title_id) values (101, 'Keletso Phiri', '8801155123081', '0721112222', to_date('2020-01-15', 'YYYY-MM-DD'), 1, 1);
insert into employee (employee_id, employee_name, id_number, phone_number, date_employed, department_id, job_title_id) values (102, 'Ziziphiwo Xango', '9205200124083', '0832223333', to_date('2021-06-01', 'YYYY-MM-DD'), 2, 2);
insert into employee (employee_id, employee_name, id_number, phone_number, date_employed, department_id, job_title_id) values (103, 'Emihle Mcilongo', '9508125034082', '0823334444', to_date('2022-03-10', 'YYYY-MM-DD'), 3, 2);
insert into employee (employee_id, employee_name, id_number, phone_number, date_employed, department_id, job_title_id) values (104, 'Lebohang Tsotetsi', '9103040156087', '0614445555', to_date('2023-11-20', 'YYYY-MM-DD'), 4, 3);
insert into employee (employee_id, employee_name, id_number, phone_number, date_employed, department_id, job_title_id) values (105, 'Junior Mlaba', '8911235067085', '0745556666', to_date('2024-02-01', 'YYYY-MM-DD'), 5, 4);
insert into employee (employee_id, employee_name, id_number, phone_number, date_employed, department_id, job_title_id) values (106, 'Liyabona Mpumlwana', '9402285123089', '0766667777', to_date('2024-05-12', 'YYYY-MM-DD'), 6, 4);
insert into employee (employee_id, employee_name, id_number, phone_number, date_employed, department_id, job_title_id) values (107, 'Phemelo Selepe', '9607195142084', '0817778888', to_date('2024-08-22', 'YYYY-MM-DD'), 7, 4);
insert into employee (employee_id, employee_name, id_number, phone_number, date_employed, department_id, job_title_id) values (108, 'Takatso Matlala', '9310055189082', '0848889999', to_date('2025-01-10', 'YYYY-MM-DD'), 8, 3);
insert into employee (employee_id, employee_name, id_number, phone_number, date_employed, department_id, job_title_id) values (109, 'Mbasa Klaas', '9712125234081', '0639990000', to_date('2025-04-05', 'YYYY-MM-DD'), 9, 4);

insert into salary (salary_id, employee_id, basic_salary, effective_date, end_date) values (1, 101, 95000.00, to_date('2020-01-15', 'YYYY-MM-DD'), null);
insert into salary (salary_id, employee_id, basic_salary, effective_date, end_date) values (2, 102, 58000.00, to_date('2021-06-01', 'YYYY-MM-DD'), null);
insert into salary (salary_id, employee_id, basic_salary, effective_date, end_date) values (3, 103, 55000.00, to_date('2022-03-10', 'YYYY-MM-DD'), null);
insert into salary (salary_id, employee_id, basic_salary, effective_date, end_date) values (4, 104, 35000.00, to_date('2023-11-20', 'YYYY-MM-DD'), null);
insert into salary (salary_id, employee_id, basic_salary, effective_date, end_date) values (5, 105, 18000.00, to_date('2024-02-01', 'YYYY-MM-DD'), null);
insert into salary (salary_id, employee_id, basic_salary, effective_date, end_date) values (6, 106, 17500.00, to_date('2024-05-12', 'YYYY-MM-DD'), null);
insert into salary (salary_id, employee_id, basic_salary, effective_date, end_date) values (7, 107, 16000.00, to_date('2024-08-22', 'YYYY-MM-DD'), null);
insert into salary (salary_id, employee_id, basic_salary, effective_date, end_date) values (8, 108, 38000.00, to_date('2025-01-10', 'YYYY-MM-DD'), null);
insert into salary (salary_id, employee_id, basic_salary, effective_date, end_date) values (9, 109, 15000.00, to_date('2025-04-05', 'YYYY-MM-DD'), null);

insert into allowance (allowance_id, employee_id, housing_allowance, transport_allowance, medical_aid_allowance, effective_date) values (1, 101, 5000.00, 3000.00, 4000.00, to_date('2020-01-15', 'YYYY-MM-DD'));
insert into allowance (allowance_id, employee_id, housing_allowance, transport_allowance, medical_aid_allowance, effective_date) values (2, 102, 3500.00, 2000.00, 2500.00, to_date('2021-06-01', 'YYYY-MM-DD'));
insert into allowance (allowance_id, employee_id, housing_allowance, transport_allowance, medical_aid_allowance, effective_date) values (3, 103, 3500.00, 2000.00, 2500.00, to_date('2022-03-10', 'YYYY-MM-DD'));
insert into allowance (allowance_id, employee_id, housing_allowance, transport_allowance, medical_aid_allowance, effective_date) values (4, 104, 2000.00, 1500.00, 2000.00, to_date('2023-11-20', 'YYYY-MM-DD'));
insert into allowance (allowance_id, employee_id, housing_allowance, transport_allowance, medical_aid_allowance, effective_date) values (5, 105, 1000.00, 800.00, 1200.00, to_date('2024-02-01', 'YYYY-MM-DD'));
insert into allowance (allowance_id, employee_id, housing_allowance, transport_allowance, medical_aid_allowance, effective_date) values (6, 106, 1000.00, 800.00, 1200.00, to_date('2024-05-12', 'YYYY-MM-DD'));
insert into allowance (allowance_id, employee_id, housing_allowance, transport_allowance, medical_aid_allowance, effective_date) values (7, 107, 1000.00, 800.00, 1200.00, to_date('2024-08-22', 'YYYY-MM-DD'));
insert into allowance (allowance_id, employee_id, housing_allowance, transport_allowance, medical_aid_allowance, effective_date) values (8, 108, 2000.00, 1500.00, 2000.00, to_date('2025-01-10', 'YYYY-MM-DD'));
insert into allowance (allowance_id, employee_id, housing_allowance, transport_allowance, medical_aid_allowance, effective_date) values (9, 109, 1000.00, 800.00, 0.00, to_date('2025-04-05', 'YYYY-MM-DD'));

insert into deductions (deductions_id, employee_id, deduction_type, amount, effective_date) values (1, 101, 'Tax', 28500.00, to_date('2020-01-15', 'YYYY-MM-DD'));
insert into deductions (deductions_id, employee_id, deduction_type, amount, effective_date) values (2, 102, 'Tax', 14500.00, to_date('2021-06-01', 'YYYY-MM-DD'));
insert into deductions (deductions_id, employee_id, deduction_type, amount, effective_date) values (3, 103, 'Tax', 13750.00, to_date('2022-03-10', 'YYYY-MM-DD'));
insert into deductions (deductions_id, employee_id, deduction_type, amount, effective_date) values (4, 104, 'Tax', 7000.00, to_date('2023-11-20', 'YYYY-MM-DD'));
insert into deductions (deductions_id, employee_id, deduction_type, amount, effective_date) values (5, 105, 'Tax', 1800.00, to_date('2024-02-01', 'YYYY-MM-DD'));
insert into deductions (deductions_id, employee_id, deduction_type, amount, effective_date) values (6, 106, 'Tax', 1750.00, to_date('2024-05-12', 'YYYY-MM-DD'));
insert into deductions (deductions_id, employee_id, deduction_type, amount, effective_date) values (7, 107, 'Tax', 1600.00, to_date('2024-08-22', 'YYYY-MM-DD'));
insert into deductions (deductions_id, employee_id, deduction_type, amount, effective_date) values (8, 108, 'Tax', 7600.00, to_date('2025-01-10', 'YYYY-MM-DD'));
insert into deductions (deductions_id, employee_id, deduction_type, amount, effective_date) values (9, 109, 'Tax', 1500.00, to_date('2025-04-05', 'YYYY-MM-DD'));

insert into leave (leave_id, employee_id, leave_type, start_date, end_date, number_of_days, application_date, leave_reason, approval_status, approved_by, approval_date) values (1, 104, 'Annual', to_date('2026-12-15', 'YYYY-MM-DD'), to_date('2026-12-20', 'YYYY-MM-DD'), 5, to_date('2026-12-01', 'YYYY-MM-DD'), 'Holiday', 'APPROVED', 101, to_date('2026-12-02', 'YYYY-MM-DD'));

insert into overtime (overtime_id, employee_id, overtime_date, overtime_hours, overtime_rate, overtime_pay, approval_status, approved_by) values (1, 105, to_date('2026-10-15', 'YYYY-MM-DD'), 10.00, 1.50, 1350.00, 'APPROVED', 101);
insert into overtime (overtime_id, employee_id, overtime_date, overtime_hours, overtime_rate, overtime_pay, approval_status, approved_by) values (2, 106, to_date('2026-10-16', 'YYYY-MM-DD'), 5.00, 1.50, 562.50, 'APPROVED', 101);

insert into payroll (payroll_id, employee_id, pay_period, basic_salary, overtime_hours, overtime_pay, bonus, total_allowance, total_deduction, gross_salary, net_salary, payment_date, payment_method) values (1, 101, to_date('2026-10-31', 'YYYY-MM-DD'), 95000.00, 0.00, 0.00, 0.00, 12000.00, 28500.00, 107000.00, 78500.00, to_date('2026-10-31', 'YYYY-MM-DD'), 'EFT');
insert into payroll (payroll_id, employee_id, pay_period, basic_salary, overtime_hours, overtime_pay, bonus, total_allowance, total_deduction, gross_salary, net_salary, payment_date, payment_method) values (2, 102, to_date('2026-10-31', 'YYYY-MM-DD'), 58000.00, 0.00, 0.00, 2000.00, 8000.00, 14500.00, 68000.00, 53500.00, to_date('2026-10-31', 'YYYY-MM-DD'), 'EFT');
insert into payroll (payroll_id, employee_id, pay_period, basic_salary, overtime_hours, overtime_pay, bonus, total_allowance, total_deduction, gross_salary, net_salary, payment_date, payment_method) values (3, 103, to_date('2026-10-31', 'YYYY-MM-DD'), 55000.00, 0.00, 0.00, 0.00, 8000.00, 13750.00, 63000.00, 49250.00, to_date('2026-10-31', 'YYYY-MM-DD'), 'EFT');
insert into payroll (payroll_id, employee_id, pay_period, basic_salary, overtime_hours, overtime_pay, bonus, total_allowance, total_deduction, gross_salary, net_salary, payment_date, payment_method) values (4, 104, to_date('2026-10-31', 'YYYY-MM-DD'), 35000.00, 0.00, 0.00, 0.00, 5500.00, 7000.00, 40500.00, 33500.00, to_date('2026-10-31', 'YYYY-MM-DD'), 'EFT');
insert into payroll (payroll_id, employee_id, pay_period, basic_salary, overtime_hours, overtime_pay, bonus, total_allowance, total_deduction, gross_salary, net_salary, payment_date, payment_method) values (5, 105, to_date('2026-10-31', 'YYYY-MM-DD'), 18000.00, 10.00, 1350.00, 0.00, 3000.00, 1800.00, 22350.00, 20550.00, to_date('2026-10-31', 'YYYY-MM-DD'), 'EFT');
insert into payroll (payroll_id, employee_id, pay_period, basic_salary, overtime_hours, overtime_pay, bonus, total_allowance, total_deduction, gross_salary, net_salary, payment_date, payment_method) values (6, 106, to_date('2026-10-31', 'YYYY-MM-DD'), 17500.00, 5.00, 562.50, 0.00, 3000.00, 1750.00, 21062.50, 19312.50, to_date('2026-10-31', 'YYYY-MM-DD'), 'EFT');
insert into payroll (payroll_id, employee_id, pay_period, basic_salary, overtime_hours, overtime_pay, bonus, total_allowance, total_deduction, gross_salary, net_salary, payment_date, payment_method) values (7, 107, to_date('2026-10-31', 'YYYY-MM-DD'), 16000.00, 0.00, 0.00, 0.00, 3000.00, 1600.00, 19000.00, 17400.00, to_date('2026-10-31', 'YYYY-MM-DD'), 'EFT');
insert into payroll (payroll_id, employee_id, pay_period, basic_salary, overtime_hours, overtime_pay, bonus, total_allowance, total_deduction, gross_salary, net_salary, payment_date, payment_method) values (8, 108, to_date('2026-10-31', 'YYYY-MM-DD'), 38000.00, 0.00, 0.00, 0.00, 5500.00, 7600.00, 43500.00, 35900.00, to_date('2026-10-31', 'YYYY-MM-DD'), 'EFT');
insert into payroll (payroll_id, employee_id, pay_period, basic_salary, overtime_hours, overtime_pay, bonus, total_allowance, total_deduction, gross_salary, net_salary, payment_date, payment_method) values (9, 109, to_date('2026-10-31', 'YYYY-MM-DD'), 15000.00, 0.00, 0.00, 0.00, 1800.00, 1500.00, 16800.00, 15300.00, to_date('2026-10-31', 'YYYY-MM-DD'), 'EFT');

insert into payslip (payslip_id, payroll_id, employee_id, issue_date) values (1, 1, 101, to_date('2026-10-31', 'YYYY-MM-DD'));
insert into payslip (payslip_id, payroll_id, employee_id, issue_date) values (2, 2, 102, to_date('2026-10-31', 'YYYY-MM-DD'));
insert into payslip (payslip_id, payroll_id, employee_id, issue_date) values (3, 3, 103, to_date('2026-10-31', 'YYYY-MM-DD'));
insert into payslip (payslip_id, payroll_id, employee_id, issue_date) values (4, 4, 104, to_date('2026-10-31', 'YYYY-MM-DD'));
insert into payslip (payslip_id, payroll_id, employee_id, issue_date) values (5, 5, 105, to_date('2026-10-31', 'YYYY-MM-DD'));
insert into payslip (payslip_id, payroll_id, employee_id, issue_date) values (6, 6, 106, to_date('2026-10-31', 'YYYY-MM-DD'));
insert into payslip (payslip_id, payroll_id, employee_id, issue_date) values (7, 7, 107, to_date('2026-10-31', 'YYYY-MM-DD'));
insert into payslip (payslip_id, payroll_id, employee_id, issue_date) values (8, 8, 108, to_date('2026-10-31', 'YYYY-MM-DD'));
insert into payslip (payslip_id, payroll_id, employee_id, issue_date) values (9, 9, 109, to_date('2026-10-31', 'YYYY-MM-DD'));

commit;

select 
    e.employee_id,
    e.employee_name,
    d.department_name,
    j.job_title_name,
    j.job_level,
    to_char(p.pay_period, 'YYYY-MM') as pay_month,
    p.basic_salary,
    p.total_allowance,
    p.total_deduction,
    p.gross_salary,
    p.net_salary,
    p.payment_method
from employee e
join department d on e.department_id = d.department_id
join job_title j on e.job_title_id = j.job_title_id
join payroll p on e.employee_id = p.employee_id
order by e.employee_id;