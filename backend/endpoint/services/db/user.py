from .dbconn import dbpool

def get_users():
    try:
        result = dbpool.query("SELECT * FROM utilisateur")
        return result
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e
    
def get_user_by_id(id: int):
    try:
        result = dbpool.query("SELECT * FROM utilisateur WHERE id = %s", (id,))
        return result
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e
    
def get_user_name_by_id(id: int):
    try:
        result = dbpool.query("SELECT nom FROM utilisateur WHERE id = %s", (id,))
        return result
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e
    
def user_exists(id: int)-> bool:
    try:
        result = dbpool.query("SELECT * FROM utilisateur WHERE id = %s", (id,))
        return len(result) > 0
    except Exception as e:
        dbpool.query("ROLLBACK")

def validate_user(email: str, password: str) -> bool:
    try:
        result = dbpool.query("SELECT * FROM utilisateur WHERE email = %s AND password = %s", (email, password))
        return len(result) > 0
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e
    
def authenticate_user(email: str, password: str):
    try:
        # Exécuter la requête avec les paramètres
        result = dbpool.query("SELECT id_utilisateur, email, password FROM utilisateur WHERE email = %s", (email,))
        
        if not result:
            return {
                "success": False,
                "error": "Email ou mot de passe incorrect"
            }
        
        # Conversion du tuple en dictionnaire
        user = {
            "id_utilisateur": result[0][0],  # Premier élément du tuple
            "email": result[0][1],           # Deuxième élément
            "password": result[0][2]         # Troisième élément
        }
        
        if user["password"] == password:
            return {
                "success": True,
                "data": {
                    "token": f"fake_token_{user['id_utilisateur']}",
                    "email": user["email"]
                }
            }
        
        return {
            "success": False,
            "error": "Email ou mot de passe incorrect"
        }
        
    except Exception as e:
        # En cas d'erreur, faire un rollback
        dbpool.query("ROLLBACK")
        print(f"Erreur d'authentification: {str(e)}")
        return {
            "success": False,
            "error": f"Erreur serveur: {str(e)}"
        }