import psycopg2

class DBpool:
    def __init__(self):
        self.conn = psycopg2.connect("dbname=postgres user=postgres password=motdepasse host=localhost port=19876")
        self.cur = self.conn.cursor()
    
    def query(self, query):
        self.cur.execute(query)
        return self.cur.fetchall()
    
    def __del__(self):
        self.cur.close()
        self.conn.close()

dbpool = DBpool()   