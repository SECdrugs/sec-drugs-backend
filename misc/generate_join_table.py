def generate_code():
    t1 = str(input("t1: "))
    t2 = str(input("t2: "))
    join_table = f'{t1}_{t2}'

    print(f'''create table {join_table} (
      {t1}_id uuid not null,
      {t2}_id uuid not null,
      created_at timestamp not null default now(),
      updated_at timestamp not null default now()
      );

      CREATE TRIGGER update_{join_table}_timestamp BEFORE UPDATE ON {join_table} FOR EACH ROW EXECUTE PROCEDURE update_modified_column();

      alter table {join_table} add
      constraint fk_{t1}
      foreign key({t1}_id)
      references {t1}(id);

      alter table {join_table} add
      constraint fk_{t2}
      foreign key({t2}_id)
      references {t2}(id);''')


generate_code()
