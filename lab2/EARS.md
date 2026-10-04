REQ-001 (Event-driven): WHEN студент подає заявку на участь у групі,
система SHALL створити запис у Enrollments зі значеннями mark = NULL,
final_score = NULL, certificate_issued = false.

REQ-002 (Event-driven): WHEN поточна дата досягає Groups.start_date,
система SHALL заблокувати можливість нових записів для цієї групи.

REQ-003 (Unwanted behavior): IF студент намагається створити запис
для групи, чия start_date вже минула, THEN система SHALL відхилити
заявку з кодом помилки "GROUP_CLOSED".

REQ-004 (Event-driven): WHEN викладач виставляє final_score у Enrollments,
система SHALL автоматично встановити certificate_issued = true,
якщо final_score >= 60% від максимального балу.

REQ-005 (Event-driven): WHEN certificate_issued змінюється на true,
система SHALL надіслати студенту сповіщення через службу email-сповіщень
протягом 10 хвилин.

REQ-006 (Ubiquitous): Система SHALL гарантувати, що кожен запис
посилається рівно на одну пару (student_id, group_id), і ця пара є
унікальною (складений PK).

REQ-007 (Event-driven): WHEN створюється нова група для курсу,
система SHALL вимагати, щоб Groups.start_date була раніше за Groups.end_date.

REQ-008 (State-driven): WHILE Groups.end_date вже минула, система SHALL
забороняти зміну mark та final_score для пов'язаних записів
(дані курсу "заморожені").

REQ-010 (Event-driven): WHEN студент фільтрує список курсів за категорією,
система SHALL повернути лише ті курси, що належать обраній категорії.

REQ-011 (Ubiquitous): Система SHALL дозволяти курсам належати
одночасно декільком категоріям (зв'язок n to n без атрибутів).
