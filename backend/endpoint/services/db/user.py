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
    
