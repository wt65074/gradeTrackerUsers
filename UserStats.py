import MySQLdb
import urllib
import time


statsConnector = MySQLdb.connect(host="127.0.0.1",user="root",
            passwd="open",db="Stats")
statsCursor = statsConnector.cursor()

logsConnector = MySQLdb.connect(host="127.0.0.1",user="root",
            passwd="open",db="UserLogs")
logsCursor = logsConnector.cursor()

query = """SELECT date, count(*) as 'Count' FROM Daily GROUP BY date"""
logsCursor.execute(query)

#store query results
data = logsCursor.fetchall()

statsCursor.execute("""DROP TABLE DailyCount""")
statsCursor.execute("""CREATE TABLE `DailyCount` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=latin1;""")

for row in data:

    query = """INSERT INTO DailyCount (date, count) VALUES ('%s', %s)""" % (row[0], row[1])
    statsCursor.execute(query)

query = """SELECT date, count(*) as 'Count' FROM Weekly GROUP BY date"""
logsCursor.execute(query)

#store query results
data = logsCursor.fetchall()

statsCursor.execute("""DROP TABLE WeeklyCount""")
statsCursor.execute("""CREATE TABLE `WeeklyCount` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=latin1;""")

for row in data:

    query = """INSERT INTO WeeklyCount (date, count) VALUES ('%s', %s)""" % (row[0], row[1])
    statsCursor.execute(query)

logsConnector.commit()
statsConnector.commit()

logsCursor.close()
statsCursor.close()

statsConnector.close()
logsConnector.close()



#average over the last 7 days not with the last day
#average over the last 7 days with the last day
#average over the last 30 days
#all time average
#median number
#number for every day of the year
#done
