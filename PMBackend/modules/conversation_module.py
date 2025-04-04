from config.database import link

def create_conversation(iduser1, iduser2):
    cursor = link.cursor()
    query = "INSERT INTO conversation (iduser1, iduser2) VALUES (%s, %s)"
    values = (iduser1, iduser2)
    cursor.execute(query, values)
    link.commit()
    cursor.close()
