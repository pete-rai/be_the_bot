import csv

def dequote(text):
    return text.replace("'", "''")

def main():
    csv_path = '../raw/mmlu.csv'
    sql_path = './sql/mmlu.sql'

    with open(sql_path, 'w', encoding='utf-8') as sql_file:
        with open(csv_path, newline='', encoding='utf-8') as csv_file:
            reader = csv.reader(csv_file)
            next(reader)  # skip header

            for row in reader:
                if len(row) < 8:
                    continue  # should not happen

                index, question, option_a, option_b, option_c, option_d, answer, subject = row

                question = dequote(question)
                option_a = dequote(option_a)
                option_b = dequote(option_b)
                option_c = dequote(option_c)
                option_d = dequote(option_d)
                subject  = dequote(subject)

                sql = f"INSERT INTO multichoice (question, option_a, option_b, option_c, option_d, answer, subject_id) " \
                      f"VALUES ('{question}', '{option_a}', '{option_b}', '{option_c}', '{option_d}', '{answer}', " \
                      f"(SELECT id FROM subject WHERE name = '{subject}'));\n"

                sql_file.write(sql)

if __name__ == '__main__':
    main()
