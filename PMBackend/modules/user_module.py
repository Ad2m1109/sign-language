from config.database import link

def create_user(name, email, password):
    cursor = link.cursor()
    query = "INSERT INTO user (name, email, password) VALUES (%s, %s, %s)"
    values = (name, email, password)
    cursor.execute(query, values)
    link.commit()
    cursor.close()

def find_user_by_email(email):
    cursor = link.cursor()
    query = "SELECT * FROM users WHERE email = %s"
    cursor.execute(query, (email,))
    user = cursor.fetchone()
    cursor.close()
    return user
