# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html
import pymysql
from itemadapter import ItemAdapter

class BooksListPipeline:
    def __init__(self):
        self.create_connection()
        self.create_table()

    def create_connection(self):
        self.conn = pymysql.connect(
            host='localhost',
            user='root',
            password='Panther@123',
            database='ws'
        )
        self.cursor = self.conn.cursor()

    def create_table(self):
        self.cursor.execute('''
            CREATE TABLE IF NOT EXISTS books (
                id INT AUTO_INCREMENT PRIMARY KEY,
                title VARCHAR(255),
                price VARCHAR(50),
                ratings VARCHAR(50)
            )
        ''')
        self.conn.commit()

    def close_spider(self, spider):
        self.conn.close()

    def process_item(self, item, spider):
       item['title'] = item['title'][0] if item['title'] else ''
       item['price'] = item['price'][0] if item['price'] else ''
       item['Ratings'] = item['Ratings'][0].split()[-1] if item['Ratings'] else 'No rating'
    
    
       print(f"Inserting into DB: {item}")

       self.cursor.execute('''
        INSERT INTO books (title, price, ratings) VALUES (%s, %s, %s)
       ''', (item['title'], item['price'], item['Ratings']))
       self.conn.commit()
    
       return item
