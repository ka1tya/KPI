# Лабораторна робота 1 - ER-модель домену «Онлайн-платформа курсів з програмування»

## Обраний домен

Це онлайн-платформа на якій представлені курси з програмування, наприклад, курс Data Science, Java Developer чи DevOps Engineer.
Основні сутності: Courses, Students, Teachers, Enrollments, Categories, Groups.
Я обрала даний домен, оскільки його тема досить близька мені, а також, що за допомогою нього можна продемонструвати багато різноманітних випадків, як-от наявність чистого зв'язку n to n (Categories - Courses) чи зв'язки, де потрібна асоціативна сутність (Enrollments у Students - Groups).

## Структура репозиторію

```
lab1/
   adr/
     0001-marks-as-associative-entity.md
     0002-enrollments-tied-to-groups.md
     0003-composite-key-for-enrollments.md
   ai/
     prompts.md
   model/
     er-diagram.md
   audit.md
   README.md
   spec.md
```

**0001-marks-as-associative-entity.md** - рішення чому Marks стала Enrollments, а не лишились окремою незалежною сутністю;
**0002-enrollments-tied-to-groups.md** - рішення чому Enrollments пов'язана саме з Groups, а не напряму з Courses;
**0003-composite-key-for-enrollments.md** - рішення чому складений ключ замість окремого id;
**prompts.md** - слід промптів та аудит помилок AI;
**er-diagram.md** - декларативний код та рендер діаграми;
**audit.md** - розбіжності моделі проти spec.md, знайдені й виправлені;
**README.md** - опис лабораторної роботи
**spec.md** - опис усіх сутностей: їх атрибути, зв'язки, бізнес-правила;

## Як переглянути ER-діаграму

Діаграма рендериться одразу на GitHub у model/er-diagram.md
