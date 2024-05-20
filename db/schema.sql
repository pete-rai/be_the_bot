
-- be_the_bot schema

DROP DATABASE IF EXISTS be_the_bot;
CREATE DATABASE be_the_bot;
CONNECT be_the_bot;

-- subject table

CREATE TABLE subject
(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    area VARCHAR(255) NOT NULL
);

-- list below from https://github.com/openai/simple-evals/blob/main/mmlu_eval.py

INSERT
  INTO subject(name, area)
VALUES ("abstract_algebra", "stem"),
       ("anatomy", "other"),
       ("astronomy", "stem"),
       ("business_ethics", "other"),
       ("clinical_knowledge", "other"),
       ("college_biology", "stem"),
       ("college_chemistry", "stem"),
       ("college_computer_science", "stem"),
       ("college_mathematics", "stem"),
       ("college_medicine", "other"),
       ("college_physics", "stem"),
       ("computer_security", "stem"),
       ("conceptual_physics", "stem"),
       ("econometrics", "social_sciences"),
       ("electrical_engineering", "stem"),
       ("elementary_mathematics", "stem"),
       ("formal_logic", "humanities"),
       ("global_facts", "other"),
       ("high_school_biology", "stem"),
       ("high_school_chemistry", "stem"),
       ("high_school_computer_science", "stem"),
       ("high_school_european_history", "humanities"),
       ("high_school_geography", "social_sciences"),
       ("high_school_government_and_politics", "social_sciences"),
       ("high_school_macroeconomics", "social_sciences"),
       ("high_school_mathematics", "stem"),
       ("high_school_microeconomics", "social_sciences"),
       ("high_school_physics", "stem"),
       ("high_school_psychology", "social_sciences"),
       ("high_school_statistics", "stem"),
       ("high_school_us_history", "humanities"),
       ("high_school_world_history", "humanities"),
       ("human_aging", "other"),
       ("human_sexuality", "social_sciences"),
       ("international_law", "humanities"),
       ("jurisprudence", "humanities"),
       ("logical_fallacies", "humanities"),
       ("machine_learning", "stem"),
       ("management", "other"),
       ("marketing", "other"),
       ("medical_genetics", "other"),
       ("miscellaneous", "other"),
       ("moral_disputes", "humanities"),
       ("moral_scenarios", "humanities"),
       ("nutrition", "other"),
       ("philosophy", "humanities"),
       ("prehistory", "humanities"),
       ("professional_accounting", "other"),
       ("professional_law", "humanities"),
       ("professional_medicine", "other"),
       ("professional_psychology", "social_sciences"),
       ("public_relations", "social_sciences"),
       ("security_studies", "social_sciences"),
       ("sociology", "social_sciences"),
       ("us_foreign_policy", "social_sciences"),
       ("virology", "other"),
       ("world_religions", "humanities");

-- multichoice table

CREATE TABLE multichoice
(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    question TEXT NOT NULL,
    option_a TEXT,
    option_b TEXT,
    option_c TEXT,
    option_d TEXT,
    answer CHAR(1),
    subject_id INT UNSIGNED,
    FOREIGN KEY (subject_id) REFERENCES subject(id)
);

SOURCE ./sql/mmlu.sql

-- create users

DROP USER IF EXISTS be_the_bot@localhost;
CREATE USER be_the_bot@localhost IDENTIFIED BY 'be_the_bot';
GRANT SELECT ON be_the_bot.* TO be_the_bot@localhost;
