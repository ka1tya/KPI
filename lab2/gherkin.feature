Feature: Запис студента на групу курсу

  Scenario: Успішний запис до старту групи
    Given Group.start_date ще не настала
    And студент ще не має Enrollment для цієї Group
    When студент подає заявку на участь у Group
    Then створюється Enrollment з mark = NULL, final_score = NULL, certificate_issued = false

  Scenario: Спроба запису після старту групи
    Given Group.start_date вже минула
    When студент подає заявку на участь у Group
    Then система відхиляє заявку з кодом "GROUP_CLOSED"

  Scenario: Автоматична видача сертифіката
    Given студент має Enrollment без виставленого final_score
    When викладач виставляє final_score = 75%
    Then certificate_issued встановлюється в true
    And студент отримує email-сповіщення протягом 10 хвилин

  Scenario: Недостатній бал для сертифіката
    Given студент має Enrollment без виставленого final_score
    When викладач виставляє final_score = 45%
    Then certificate_issued залишається false

  Scenario: Заборона редагування після завершення групи
    Given Group.end_date вже минула
    When викладач намагається змінити final_score для Enrollment цієї Group
    Then система відхиляє зміну