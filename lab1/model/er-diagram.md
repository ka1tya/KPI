```mermaid
COURSES ||--o{ GROUPS : "has"
TEACHERS ||--o{ COURSES : "teaches"
CATEGORIES }o--o{ COURSES : "refers to"
STUDENTS ||--o{ ENROLLMENTS: "credited"
GROUPS ||--o{ ENROLLMENTS: "has"

COURSES {
    int id PK
    int teacher_id FK
    string name
}
STUDENTS {
    int id PK
    string first_name
    string last_name
}
TEACHERS {
    int id PK
    string first_name
    string last_name
    int experience
}
ENROLLMENTS {
    int student_id PK, FK
    int group_id PK, FK
    int mark
    int final_score
    boolean certificate_issued
}
CATEGORIES {
    int id PK
    string name
}
GROUPS {
    int id PK
    int course_id FK
    string code
    date start_date
    date end_date
}
```
