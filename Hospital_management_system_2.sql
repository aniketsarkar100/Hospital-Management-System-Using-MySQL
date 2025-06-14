-- ============================
-- HOSPITAL MANAGEMENT SYSTEM
-- ============================
CREATE DATABASE Hospital;
USE Hospital;

-- 1. Create Patients table
CREATE TABLE Patients (
    patient_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    dob DATE,
    gender CHAR(1),
    contact VARCHAR(15),
    address VARCHAR(100)
);
SELECT * FROM Patients;

-- 2. Create Doctors table
CREATE TABLE Doctors (
    doctor_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    specialization VARCHAR(50),
    contact VARCHAR(15),
    department VARCHAR(50)
);
SELECT * FROM doctors;


-- 3. Create Appointments table
CREATE TABLE Appointments (
    appointment_id VARCHAR(10) PRIMARY KEY,
    patient_id VARCHAR(10),
    doctor_id VARCHAR(10),
    appointment_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- 4. Create Medications table
CREATE TABLE Medications (
    medication_id VARCHAR(10) PRIMARY KEY,
    patient_id VARCHAR(10),
    medicine_name VARCHAR(50),
    dosage VARCHAR(30),
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- 5. Create Bills table
CREATE TABLE Bills (
    bill_id VARCHAR(10) PRIMARY KEY,
    patient_id VARCHAR(10),
    amount DECIMAL(10,2),
    billing_date DATE,
    payment_status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- ============================
-- INSERT DATA
-- ============================

-- Insert Patients
INSERT INTO Patients VALUES
('P001', 'Aman Roy', '1995-03-10', 'M', '9876543210', 'Kolkata'),
('P002', 'Ritika Sharma', '1992-08-15', 'F', '9765432190', 'Delhi'),
('P003', 'Karan Mehta', '1988-05-23', 'M', '9123456780', 'Mumbai');

-- Insert Doctors
INSERT INTO Doctors VALUES
('D001', 'Dr. Arjun Sen', 'Cardiology', '9988776655', 'Cardiology'),
('D002', 'Dr. Neha Kapoor', 'Orthopedics', '8877665544', 'Orthopedics'),
('D003', 'Dr. Ravi Iyer', 'Neurology', '7766554433', 'Neurology');

-- Insert Appointments
INSERT INTO Appointments VALUES
('A001', 'P001', 'D001', '2025-06-20', 'Scheduled'),
('A002', 'P002', 'D002', '2025-06-22', 'Completed'),
('A003', 'P003', 'D003', '2025-06-25', 'Scheduled');

-- Insert Medications
INSERT INTO Medications VALUES
('M001', 'P001', 'Aspirin', '75mg once daily', '2025-06-20', '2025-07-20'),
('M002', 'P002', 'Calcium', '500mg twice daily', '2025-06-22', '2025-07-22'),
('M003', 'P003', 'Gabapentin', '300mg three times daily', '2025-06-25', '2025-07-25');

-- Insert Bills
INSERT INTO Bills VALUES
('B001', 'P001', 4500.00, '2025-06-21', 'Unpaid'),
('B002', 'P002', 6200.00, '2025-06-23', 'Paid'),
('B003', 'P003', 8000.00, '2025-06-26', 'Unpaid');
SELECT * FROM patients;
SELECT * FROM doctors;
SELECT * FROM appointments;
SELECT * FROM Medications;
SELECT * FROM bills;



-- ============================
-- QUERIES (TEST OUTPUT)
-- ============================

-- 1. List all patients assigned to 'Dr. Arjun Sen'
SELECT p.name, p.contact
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE d.name = 'Dr. Arjun Sen';

-- 2. Calculate total revenue generated this month
SELECT SUM(amount) AS total_revenue
FROM Bills
WHERE MONTH(billing_date) = MONTH(CURRENT_DATE())
AND YEAR(billing_date) = YEAR(CURRENT_DATE());

-- 3. Find patients with unpaid bills
SELECT p.name, b.amount, b.billing_date
FROM Patients p
JOIN Bills b ON p.patient_id = b.patient_id
WHERE b.payment_status = 'Unpaid';

-- 4. Medicines prescribed to 'Ritika Sharma'
SELECT m.medicine_name, m.dosage, m.start_date, m.end_date
FROM Medications m
JOIN Patients p ON m.patient_id = p.patient_id
WHERE p.name = 'Ritika Sharma';

-- 5. Number of appointments handled by each doctor
SELECT d.name AS doctor_name, COUNT(*) AS total_appointments
FROM Doctors d
JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.name;

