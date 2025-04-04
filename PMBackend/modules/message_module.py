from config.database import link

def create_message(idcnv, contenu):
    cursor = link.cursor()
    query = "INSERT INTO message (idcnv, contenu) VALUES (%s, %s)"
    values = (idcnv, contenu)
    cursor.execute(query, values)
    link.commit()
    cursor.close()
