import psycopg2


class DBpool:
    def __init__(self):
        # TODO : Mettre les paramètres de connexion dans un fichier de configuration
        self.conn = psycopg2.connect(
            "dbname=postgres user=postgres password=motdepasse host=localhost port=10000")
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
