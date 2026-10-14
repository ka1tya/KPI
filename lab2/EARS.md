REQ-001 (Event-driven): WHEN студент подає заявку на участь у групі,
система SHALL створити запис у Enrollments зі значеннями mark = NULL,
final_score = NULL, certificate_issued = false.

REQ-002 (Event-driven): WHEN поточна дата досягає Groups.start_date,
система SHALL заблокувати можливість нових записів для цієї групи.

REQ-003 (Unwanted behavior): IF студент намагається створити запис
для групи, чия start_date вже настала чи минула, THEN система SHALL відхилити
заявку з кодом помилки "GROUP_CLOSED".

REQ-004 (Event-driven): WHEN final_score обчислено і final_score >= 60%, система SHALL встановити certificate_issued = true.

REQ-005 (Event-driven): WHEN certificate_issued змінюється на true,
система SHALL надіслати студенту сповіщення через службу email-сповіщень
протягом 10 хвилин.

REQ-006 (Ubiquitous): Система SHALL гарантувати, що кожен запис
посилається рівно на одну пару (student_id, group_id), і ця пара є
унікальною (складений PK).

REQ-007 (Event-driven): WHEN створюється нова група для курсу,
система SHALL вимагати, щоб Groups.start_date була раніше за Groups.end_date.

REQ-008 (State-driven): WHILE Groups.end_date вже минула, система SHALL
забороняти зміну mark та final_score для пов'язаних записів (дані групи "заморожені").

REQ-010 (Event-driven): WHEN студент фільтрує список курсів за категорією,
система SHALL повернути лише ті курси, що належать обраній категорії.

REQ-011 (Ubiquitous): Система SHALL дозволяти курсам належати
одночасно декільком категоріям (зв'язок n to n без атрибутів).

REQ-012 (Event-driven): WHEN final_score обчислено і final_score < 60%, система SHALL встановити certificate_issued = false.

REQ-013 (Event-driven): WHEN викладач змінює mark у Enrollments (додає бали або виправляє нараховані), система SHALL обчислити final_score як відсоток mark від максимуму в 100 балів.

REQ-014 (Unwanted behavior): IF викладач вводить mark менше 0 або більше 100, THEN система SHALL відхилити значення з кодом помилки "MARK_OUT_OF_RANGE" і залишити mark без змін.

REQ-015 (Event-driven): WHEN поточна дата досягає Groups.start_date, система SHALL надіслати кожному студенту, який має запис у цій групі, сповіщення про початок групи через Службу email-сповіщень протягом 10 хвилин.

REQ-016 (Event-driven): WHEN поточна дата досягає Groups.end_date, система SHALL надіслати кожному студенту, який має запис у цій групі, сповіщення про завершення групи через Службу email-сповіщень протягом 10 хвилин.
