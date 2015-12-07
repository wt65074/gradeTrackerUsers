import MySQLdb
import urllib
import time


statsConnector = MySQLdb.connect(host="127.0.0.1",user="root",
            passwd="open",db="Stats")
statsCursor = statsConnector.cursor()

logsConnector = MySQLdb.connect(host="127.0.0.1",user="root",
            passwd="open",db="UserLogs")
logsCursor = statsConnector.cursor()

query = """SELECT date, count(*) as 'Count' FROM Daily GROUP BY date"""
logsCursor.execute(query)

#store query results
data = logsCursor.fetchall()

statsCursor.execute("""TRUNCATE TABLE DailyCount""")

for row in data:

    query = "INSERT INTO DailyCount (date, count) VALUES (%s, %s)" % [row[0], row[1]]
    statsCursor.execute(query)





#average over the last 7 days not with the last day
#average over the last 7 days with the last day
#average over the last 30 days
#all time average
#median number
#number for every day of the year
