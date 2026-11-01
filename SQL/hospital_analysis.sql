
-- =====================================================
-- PROJECT: Hospital Operations & Patient Analytics
-- DATABASE: hospital_analytics
-- TABLE/VIEW: hospital_er_clean
-- TOOL: MySQL
-- =====================================================

USE hospital_analytics;

-- 1. Total patient visits
SELECT
    COUNT(*) AS total_patient_visits
FROM hospital_er_clean;

-- 2. Admission analysis
SELECT
    CASE
        WHEN is_admitted = 1 THEN 'Admitted'
        ELSE 'Not Admitted'
    END AS admission_status,
    COUNT(*) AS total_visits
FROM hospital_er_clean
GROUP BY is_admitted;

-- 3. Admission rate
SELECT
    ROUND(
        SUM(CASE WHEN is_admitted = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS admission_rate_percentage
FROM hospital_er_clean;

-- 4. Patient distribution by gender
SELECT
    gender,
    COUNT(*) AS total_patients
FROM hospital_er_clean
GROUP BY gender
ORDER BY total_patients DESC;

-- 5. Patient distribution by race
SELECT
    race,
    COUNT(*) AS total_patients
FROM hospital_er_clean
GROUP BY race
ORDER BY total_patients DESC;

-- 6. Patient visits by age group
SELECT
    CASE
        WHEN patient_age < 18 THEN '0-17'
        WHEN patient_age < 35 THEN '18-34'
        WHEN patient_age < 50 THEN '35-49'
        WHEN patient_age < 65 THEN '50-64'
        ELSE '65+'
    END AS age_group,
    COUNT(*) AS total_patients
FROM hospital_er_clean
GROUP BY age_group
ORDER BY MIN(patient_age);

-- 7. Average waiting time by department
SELECT
    department_referral,
    ROUND(AVG(wait_time_minutes), 2) AS average_waiting_time
FROM hospital_er_clean
WHERE department_referral IS NOT NULL
GROUP BY department_referral
ORDER BY average_waiting_time DESC;

-- 8. Monthly patient visits
SELECT
    visit_month,
    COUNT(*) AS total_patient_visits
FROM hospital_er_clean
GROUP BY visit_month
ORDER BY visit_month;

-- 9. Monthly admission status comparison
SELECT
    visit_month,
    SUM(CASE WHEN is_admitted = 1 THEN 1 ELSE 0 END)
        AS admitted_visits,
    SUM(CASE WHEN is_admitted = 0 THEN 1 ELSE 0 END)
        AS not_admitted_visits
FROM hospital_er_clean
GROUP BY visit_month
ORDER BY visit_month;

-- 10. Average patient satisfaction
SELECT
    ROUND(AVG(satisfaction_score), 2) AS average_satisfaction
FROM hospital_er_clean;

-- 11. Overall average waiting time
SELECT
    ROUND(AVG(wait_time_minutes), 2) AS average_waiting_time
FROM hospital_er_clean;
