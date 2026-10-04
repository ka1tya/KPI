Feature: Сценарії стунедтів: записи на курси та їхній пошук

  Scenario: Успішний запис до старту групи
    Given Groups.start_date ще не настала
    And студент ще не має запису для цієї групи
    When студент подає заявку на участь у групі
    Then створюється запис у Enrollments з mark = NULL, final_score = NULL, certificate_issued = false

  Scenario: Спроба запису після старту групи
    Given Groups.start_date вже минула
    When студент подає заявку на участь у групі
    Then система відхиляє заявку з кодом "GROUP_CLOSED"

  Scenario: Автоматична видача сертифіката
    Given студент має запис у Enrollments без виставленого final_score
    When викладач виставляє final_score = 75%
    Then certificate_issued встановлюється в true
    And студент отримує email-сповіщення протягом 10 хвилин

  Scenario: Недостатній бал для сертифіката
    Given студент має запис у Enrollments без виставленого final_score
    When викладач виставляє final_score = 45%
    Then certificate_issued залишається false

  Scenario: Заборона редагування після завершення групи
    Given Groups.end_date вже минула
    When викладач намагається змінити final_score для запису цієї групи
    Then система відхиляє зміну

  Scenario: Фільтрація курсів за категорією
    Given існують курси з категоріями "Python", "ML", "SQL"
    And студент обирає категорію "ML"
    When студент переглядає список курсів
    Then система показує лише курси, що мають категорію "ML"