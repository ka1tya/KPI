REQ-001 (Event-driven): WHEN студент подає заявку на участь у Group,
система SHALL створити запис Enrollment зі значеннями mark = NULL,
final_score = NULL, certificate_issued = false.

REQ-002 (Event-driven): WHEN поточна дата досягає Group.start_date,
система SHALL заблокувати можливість нових Enrollment для цієї Group.

REQ-003 (Unwanted behavior): IF студент намагається створити Enrollment
для Group, чия start_date вже минула, THEN система SHALL відхилити
заявку з кодом помилки "GROUP_CLOSED".

REQ-004 (Event-driven): WHEN викладач виставляє final_score для Enrollment,
система SHALL автоматично встановити certificate_issued = true,
якщо final_score ≥ 60% від максимального балу.

REQ-005 (Event-driven): WHEN certificate_issued змінюється на true,
система SHALL надіслати студенту сповіщення через Службу email-сповіщень
протягом 10 хвилин.

REQ-006 (Ubiquitous): Система SHALL гарантувати, що кожен Enrollment
посилається рівно на одну пару (student_id, group_id), і ця пара є
унікальною (складений PK).

REQ-007 (Event-driven): WHEN створюється нова Group для Course,
система SHALL вимагати, щоб Group.start_date була раніше за Group.end_date.

REQ-008 (State-driven): WHILE Group.end_date вже минула, система SHALL
забороняти зміну mark та final_score для пов'язаних Enrollment
(дані курсу "заморожені").
