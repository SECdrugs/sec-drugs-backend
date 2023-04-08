
def main():
    table = input("table: ")
    query = f'''{table} as (
             select * from {table} t1
             inner join compound_{table} j1 on j1.{table}_id = t1.id
             where j1.compound_id = (
                select id
                from compound
              )          
             )'''
    print(query)


if __name__ == "__main__":
    main()
