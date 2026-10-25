REQ-004 (Event-driven): WHEN система обчислює final_score і final_score >= 60%, система SHALL встановити certificate_issued = true.

REQ-008 (State-driven): WHILE поточна дата пізніша за Groups.end_date, система SHALL відхиляти спроби викладача змінити mark у записах Enrollments цієї групи.

REQ-012 (Event-driven): WHEN система обчислює final_score і final_score < 60%, система SHALL встановити certificate_issued = false.

REQ-013 (Event-driven): WHEN система приймає нове значення mark, система SHALL обчислити final_score як відсоток mark від максимуму в 100 балів.

REQ-014 (Unwanted behavior): IF викладач вводить mark менше 0 або більше 100, THEN система SHALL відхилити значення з кодом помилки "MARK_OUT_OF_RANGE" і залишити попередні значення mark, final_score та certificate_issued без змін.

REQ-017 (Event-driven): WHEN викладач відкриває запис Enrollments певного студента, система SHALL відобразити поточні значення mark, final_score і certificate_issued, якщо оцінювання вже було виконано, або показати повідомлення "Оцінку ще не виставлено", якщо бал відсутній.
