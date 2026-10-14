Feature: Сценарії онлайн-платформи курсів з програмування

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
    Given студент має запис у Enrollments з mark = 50
    When викладач змінює mark на 75
    Then final_score обчислюється як 75%
    And certificate_issued встановлюється в true
    And студент отримує email-сповіщення протягом 10 хвилин

  Scenario: Рівно на порозі сертифіката
    Given студент має запис у Enrollments з mark = NULL
    When викладач змінює mark на 60
    Then final_score обчислюється як 60%
    And certificate_issued встановлюється в true

  Scenario: Недостатній бал для сертифіката
    Given студент має запис у Enrollments без виставленого final_score
    When викладач виставляє final_score = 45%
    Then certificate_issued залишається false

  Scenario: Виправлення балів знімає сертифікат
    Given студент має запис у Enrollments з mark = 70 і certificate_issued = true
    When викладач виправляє mark на 50
    Then final_score обчислюється як 50%
    And certificate_issued встановлюється в false

  Scenario: Бали поза допустимим діапазоном
    Given студент має запис у Enrollments з mark = 95
    When викладач змінює mark на 101
    Then система відхиляє значення з кодом "MARK_OUT_OF_RANGE"
    And mark залишається 95

  Scenario: Заборона редагування після завершення групи
    Given Groups.end_date вже минула
    When викладач намагається змінити final_score для запису цієї групи
    Then система відхиляє зміну

  Scenario: Створення групи з некоректними датами
    Given адміністратор створює нову групу для курсу
    When він вказує Groups.start_date = "01.10.2026" та Groups.end_date = "01.09.2026"
    Then система відхиляє створення групи

  Scenario: Фільтрація курсів за категорією
    Given існують курси з категоріями "Python", "ML", "SQL"
    And студент обирає категорію "ML"
    When студент переглядає список курсів
    Then система показує лише курси, що мають категорію "ML"

  Scenario: Сповіщення про початок групи
    Given студент має запис у Enrollments для групи з Groups.start_date = "01.09.2026"
    And інший студент не має запису для цієї групи
    When поточна дата досягає Groups.start_date
    Then студент отримує email-сповіщення про початок групи протягом 10 хвилин
    But студент без запису в цій групі сповіщення не отримує

  Scenario: Сповіщення про завершення групи
    Given студент має запис у Enrollments для групи з Groups.end_date = "01.10.2026"
    When поточна дата досягає Groups.end_date
    Then студент отримує email-сповіщення про завершення групи протягом 10 хвилин
