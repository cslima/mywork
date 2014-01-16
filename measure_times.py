#!/usr/bin/python

import requests
import sqlite3
import json
import os
import sys
from datetime import datetime, timedelta

# check for single instance
pid = str(os.getpid())
pidfile = __file__ + ".pid"
run_time = datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S")

if os.path.isfile(pidfile):
	print run_time + "%s already exists, exiting" % pidfile
	sys.exit()
else:
	file(pidfile,'w').write(pid)
	print run_time + " starting..."

# read tests from database
db = sqlite3.connect(__file__.replace('.py','.db'))

cursor1 = db.cursor()
cursor1.execute('''SELECT id,verb,url,params,headers,payload,content_to_match,expected_response FROM tests WHERE active=1 ORDER BY id''')
all_rows = cursor1.fetchall()
cursor2 = db.cursor()

for row in all_rows:
	run_time = datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S")
	print run_time + " id=" + str(row[0]) + " verb=" + row[1] + " url=" + row[2] + " params=" + row[3] + " headers=" + row[4]+ " payload=" + row[5] + " content_to_match=" + row[6] + " expected_response=" + str(row[7])
	test_ok = 0
	test_ms = 0
	if (row[1]=='GET'):
		try:
			r = requests.get(row[2],params=row[3],headers=json.loads(row[4]),data=row[5],timeout=10)
			test_ms = r.elapsed.total_seconds()*1000
			if r.status_code==row[7]:
				test_ok = 1
				# check for content also!
		except Exception as e:
			print run_time + " Exception:" + str(e)
	elif (row[1]=='PUT'):
		try:
			r = requests.put(row[2],params=row[3],headers=json.loads(row[4]),data=row[5],timeout=10)
			test_ms = r.elapsed.total_seconds()*1000
			if r.status_code==row[7]:
				test_ok = 1
				# check for content also!
		except Exception as e:
			print run_time + " Exception:" + str(e)
	cursor2.execute('''INSERT INTO results (test_id,dt,ms,ok) VALUES (?,datetime(?),?,?)''',(row[0],run_time,test_ms,test_ok))
	db.commit()

run_time = datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S")
print run_time + " finished."
	
os.unlink(pidfile)
