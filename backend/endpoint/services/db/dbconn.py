import psycopg2
class DBpool:
    def __init__(self):
        self.conn = psycopg2.connect(
            "dbname=fleet_management user=postgres password=postgres host=db port=5432"
        )
        self.cur = self.conn.cursor()

    def query(self, query_string, params=None):
        try:
            if params:
                self.cur.execute(query_string, params)
            else:
                self.cur.execute(query_string)
            if query_string.strip().upper().startswith(('SELECT', 'RETURNING')):
                return self.cur.fetchall()
            self.conn.commit()
            return None
        except Exception as e:
            self.conn.rollback()
            print(f"Erreur dans l'exécution de la requête: {str(e)}")
            raise e

    def execute(self, query_string, params=None):
        try:
            if params:
                self.cur.execute(query_string, params)
            else:
                self.cur.execute(query_string)
            self.conn.commit()
        except Exception as e:
            self.conn.rollback()
            raise e

    def __del__(self):
        if hasattr(self, 'cur'):
            self.cur.close()
        if hasattr(self, 'conn'):
            self.conn.close()

dbpool = DBpool()
