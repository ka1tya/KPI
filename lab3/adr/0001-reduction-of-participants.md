# ADR 0001: Учасники діаграм відповідають ER-моделі та сервісам

- Статус: прийнято
- Дата: 27.10.2026

## Контекст

Перша версія діаграм, які згенерував АІ, мала сім учасників (Викладач, EnrollmentView, GradeController, GradeService, EnrollmentRepository, GroupRepository, Clock). Учасників Clock і View немає ні в моделі lab1, ні в Gherkin-сценаріях lab2, а Clock додавав кроки today() і currentDate, яких сценарії не описують.

## Розглянуті альтернативи

1. Залишити всіх сімох учасників - повніше, але Clock і View нічого не додають до сценаріїв Gherkin, а кожен виклик today() ускладнює діаграму.
2. Прибрати Clock і View, лишити GradeController і GradeService, а сутності Enrollments і Groups показати учасниками.
3. Об'єднати GradeController і GradeService в один компонент - ще коротше, але activation bar через фрагмент alt тоді тримається на контролері, а логіка перевірок змішується з прийомом запиту.

## Рішення

Було прибрано учасників Clock і View, а EnrollmentRepository і GroupRepository показано сутностями Enrollments і Groups, яким вони відповідають. Тому у UC-5 беруть участь Викладач, GradeController, GradeService, Enrollments і Groups, а в UC-6 Викладач, GradeController і Enrollments. Поточну дату GradeService перевіряє всередині викликом isGroupEnded(end_date).

## Наслідки

Кожна сутність-учасник є в моделі lab1. GradeController і GradeService не мають відповідників у ER, оскільки вони є сервісами застосунку. Поточна дата не показана окремим учасником, тому в діаграмі видно лише результат перевірки групи.
