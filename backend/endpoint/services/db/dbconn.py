import psycopg2

class DBpool:
    def __init__(self):
        # change the host and port to localhost if you are running the database locally
        self.conn = psycopg2.connect(
            "dbname=fleet_management user=postgres password=motdepasse host=172.17.0.2 port=5432")
        self.cur = self.conn.cursor()

    def query(self, query_string, params=None):
        try:
            if params:
                self.cur.execute(query_string, params)
            else:
                self.cur.execute(query_string)

            if query_string.strip().upper().startswith(('SELECT', 'RETURNING')):
                return self.cur.fetchall()
            return None

        except Exception as e:
            print(f"Erreur dans l'exécution de la requête: {str(e)}")
            raise e

    def __del__(self):
        self.cur.close()
        self.conn.close()


dbpool = DBpool()
