Feature: Виставлення та виправлення балів студенту (згідно UC-5)
  
  User story: Як викладач, я хочу виставляти та виправляти бали студентів, щоб система автоматично обчислювала підсумковий відсоток і визначала, чи має студент право на сертифікат.

  Background:
    Given викладач відкрив поточні результати студента
    And система відобразила наявні дані оцінювання або повідомила, що бал ще не встановлено

  Scenario: Успішне виставлення бала вище порогу сертифіката
    Given у записі Enrollments mark = NULL
    And certificate_issued = false
    And поточна дата не пізніша за Groups.end_date
    When викладач змінює mark на 75
    Then система зберігає mark = 75
    And система обчислює final_score як 75%
    And система встановлює certificate_issued = true

  Scenario: Виставлення бала рівно на порозі сертифіката
    Given у записі Enrollments mark = NULL
    And certificate_issued = false
    And поточна дата не пізніша за Groups.end_date
    When викладач змінює mark на 60
    Then система зберігає mark = 60
    And система обчислює final_score як 60%
    And система встановлює certificate_issued = true

  Scenario: Виставлення бала нижче порогу сертифіката
    Given у записі Enrollments mark = NULL
    And certificate_issued = false
    And поточна дата не пізніша за Groups.end_date
    When викладач змінює mark на 45
    Then система зберігає mark = 45
    And система обчислює final_score як 45%
    And система залишає certificate_issued = false

  Scenario: Виправлення бала змінює статус сертифіката
    Given студент має запис у Enrollments з mark = 70 
    And final_score = 70%
    And certificate_issued = true
    And поточна дата не пізніша за Groups.end_date
    When викладач виправляє mark на 50
    Then система зберігає mark = 50
    And система обчислює final_score = 50%
    And система встановлює certificate_issued = false

  Scenario Outline: Відхилення бала поза допустимим діапазоном
    Given студент має запис у Enrollments з mark = 95
    And final_score = 95%
    And поточна дата не пізніша за Groups.end_date
    When викладач змінює mark на <new_mark>
    Then система відхиляє значення з кодом "MARK_OUT_OF_RANGE"
    And mark залишається 95
    And final_score залишається 95%
    
    Examples:
      | new_mark |
      | -1       |
      | 101      |

  Scenario: Заборона редагування бала після завершення групи
    Given поточна дата пізніша за Groups.end_date
    And студент має запис у Enrollments з mark = 70
    When викладач намагається змінити mark на 80
    Then система відхиляє зміну
    And mark залишається 70
    And final_score залишається 70%
