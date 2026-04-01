-- 1. Bảng Bệnh nhân (patients)
CREATE TABLE patients
(
    patient_id SERIAL PRIMARY KEY,
    full_name  VARCHAR(100) NOT NULL, -- Thêm NOT NULL để tránh dữ liệu trống
    phone      VARCHAR(20) UNIQUE,    -- Số điện thoại nên là duy nhất
    city       VARCHAR(50),
    symptoms   TEXT[]                 -- Mảng chứa danh sách các triệu chứng
);

-- 2. Bảng Bác sĩ (doctors)
CREATE TABLE doctors
(
    doctor_id  SERIAL PRIMARY KEY,
    full_name  VARCHAR(100) NOT NULL,
    department VARCHAR(50)  NOT NULL -- Chuyên khoa
);

-- 3. Bảng Cuộc hẹn (appointments)
CREATE TABLE appointments
(
    appointment_id   SERIAL PRIMARY KEY,
    patient_id       INT NOT NULL,
    doctor_id        INT NOT NULL,
    appointment_date DATE DEFAULT CURRENT_DATE,       -- Mặc định là ngày hiện tại
    diagnosis        VARCHAR(200),
    fee              NUMERIC(10, 2) CHECK (fee >= 0), -- Đảm bảo phí khám không âm

    -- Khai báo khóa ngoại với tên ràng buộc rõ ràng
    CONSTRAINT fk_patient FOREIGN KEY (patient_id)
        REFERENCES patients (patient_id) ON DELETE CASCADE,
    CONSTRAINT fk_doctor FOREIGN KEY (doctor_id)
        REFERENCES doctors (doctor_id) ON DELETE CASCADE
);

-- 1.1. Chèn 5 bệnh nhân
INSERT INTO patients (full_name, phone, city, symptoms)
VALUES ('Nguyen Van A', '0901234567', 'Ho Chi Minh', ARRAY ['ho', 'sot']),
       ('Tran Thi B', '0912345678', 'Ha Noi', ARRAY ['dau dau', 'chong mat']),
       ('Le Van C', '0923456789', 'Da Nang', ARRAY ['dau bung']),
       ('Pham Thi D', '0934567890', 'Can Tho', ARRAY ['phat ban', 'ngua']),
       ('Hoang Van E', '0945678901', 'Ho Chi Minh', ARRAY ['dau lung', 'moi co']);

-- 1.2. Chèn 5 bác sĩ
INSERT INTO doctors (full_name, department)
VALUES ('BS. Chien', 'Noi tong quat'),
       ('BS. Huong', 'Nhi khoa'),
       ('BS. Minh', 'Da lieu'),
       ('BS. Lan', 'Phu san'),
       ('BS. Tuan', 'Chan thuong chinh hinh');

-- 1.3. Chèn 10 cuộc hẹn
INSERT INTO appointments (patient_id, doctor_id, appointment_date, diagnosis, fee)
VALUES (1, 1, '2026-03-01', 'Cam cum', 150.00),
       (2, 1, '2026-03-02', 'Suy nhuoc', 200.00),
       (3, 3, '2026-03-05', 'Nhiem trung da', 300.00),
       (4, 3, '2026-03-10', 'Di ung thời tiết', 100.00),
       (5, 5, '2026-03-12', 'Thoat vi dia dem', 500.00),
       (1, 2, '2026-03-15', 'Kiem tra dinh ky', 120.00),
       (2, 4, '2026-03-18', 'Kiem tra thai nhi', 450.00),
       (3, 1, '2026-03-20', 'Rối loạn tiêu hóa', 180.00),
       (4, 3, '2026-03-22', 'Viêm da cơ địa', 250.00),
       (5, 5, '2026-03-25', 'Cang co', 350.00);

-- B-tree: Tối ưu tìm kiếm chính xác hoặc theo khoảng (Thường dùng cho phone)
CREATE INDEX idx_patients_phone ON patients(phone);

-- Hash: Tối ưu cho phép so sánh "=" (Chỉ dùng cho city)
CREATE INDEX idx_patients_city_hash ON patients USING hash (city);

-- GIN: Tối ưu tìm kiếm trong mảng (symptoms)
CREATE INDEX idx_patients_symptoms_gin ON patients USING gin (symptoms);

-- GiST: Thường dùng cho dữ liệu hình học hoặc khoảng. Ở đây áp dụng cho fee.
-- Lưu ý: Trong PostgreSQL thực tế, B-tree cho fee thường nhanh hơn, nhưng đây là yêu cầu thực hành GiST.


-- Clustered Index: Sắp xếp vật lý bảng appointments theo ngày khám
CREATE INDEX idx_appointments_date ON appointments(appointment_date);
CLUSTER appointments USING idx_appointments_date;

CREATE OR REPLACE VIEW vw_hospital_report AS
SELECT
    p.full_name AS patient_name,
    p.city,
    d.full_name AS doctor_name,
    a.appointment_date,
    a.fee
FROM appointments a
         JOIN patients p ON a.patient_id = p.patient_id
         JOIN doctors d ON a.doctor_id = d.doctor_id;

-- Top 3 bệnh nhân có tổng phí khám cao nhất
SELECT patient_name, SUM(fee) as total_fee
FROM vw_hospital_report
GROUP BY patient_name
ORDER BY total_fee DESC
LIMIT 3;

-- Tổng số lượt khám theo bác sĩ
SELECT doctor_name, COUNT(*) as total_appointments
FROM vw_hospital_report
GROUP BY doctor_name;

-- Tạo View cập nhật thành phố
CREATE OR REPLACE VIEW vw_patient_location AS
SELECT patient_id, full_name, city
FROM patients;

-- Thử cập nhật thành phố của bệnh nhân có ID = 1 qua View
UPDATE vw_patient_location
SET city = 'Da Lat'
WHERE patient_id = 1;

-- Kiểm tra lại bảng patients để xác nhận thay đổi
SELECT * FROM patients WHERE patient_id = 1;