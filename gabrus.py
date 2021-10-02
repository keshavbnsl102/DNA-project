import subprocess as sp
import pymysql
import pymysql.cursors
import sys

# 11 12

def groupExists(groupHandle):
	try:
		query = "SELECT * FROM GABRUS.GROUP WHERE Handle='%s'" % (groupHandle)
		cur.execute(query)
		results = cur.fetchall()
		if len(results) == 0:
			return False
		else:
			print("Selected Group:", results[0]["Name"])
			return True
		
	except Exception as e:
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>>>>>>>>>>>>>>>", e)

def teamDriveExists(teamID):
	try:
		query = "SELECT * FROM TEAM_DRIVE WHERE TeamId='%s'" % (teamID)
		cur.execute(query)
		results = cur.fetchall()
		if len(results) == 0:
			return False
		else:
			print("Selected Team Drive:", results[0]["Name"])
			return True
	
	except Exception as e:
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>>>>>>>>>>>>>>>", e)

def option1():
	try:
		groupHandle = input("Enter the Group Handle: ")
		if groupExists(groupHandle) == False:
			print("No such Group exists.")
		else:
			userHandleQuery = "SELECT * FROM USER WHERE UserHandle in (SELECT UserHandle FROM MEMBER_OF WHERE GroupHandle='%s');" % (groupHandle)
			cur.execute(userHandleQuery)
			results = cur.fetchall()
			for result in results:
				print("UserID:", result["UserId"], ", Name:", result["Name"], ", Handle:", result["UserHandle"])
			
		
	except Exception as e:
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>>>>>>>>>>>>", e)

def option2():
	try:
		teamID = input("Enter the Team Drive ID: ")
		query = "SELECT DOWNLOAD.Name FROM DOWNLOAD WHERE TeamID='%s' AND FolderFlag=0" % (teamID)
		cur.execute(query)
		results=cur.fetchall()
		for a in results:
			print(a['Name'])


	except Exception as e:
		con.rollback()
		print("Looks like we ran into some error!!")
		print(">>>>>>>>",e)


def option3():
	try:
		x = "Hi"
		while x.isnumeric() == False:
			x = input("Enter the decimal value of x: ")
		x = float(x)
		query = "SELECT TeamID FROM DOWNLOAD GROUP BY TeamID HAVING IF(SUM(NumberOfFiles) = NULL, 0, SUM(NumberOfFiles)) + COUNT(*) - COUNT(NumberOfFiles) >= '%f';" % (x)
		cur.execute(query)
		results = cur.fetchall()
		for result in results:
			print(result['TeamID'])

	except Exception as e:
		con.rollback()
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>",e)		

def option4():
	try:
		searchItem = input("Enter the file name: ")
		teamIDInput = input("Enter the Team Drive ID: ")
		if teamDriveExists(teamIDInput) == False:
			print("No such Team Drive exists!!")
		else:
			query = "SELECT Name, Size FROM DOWNLOAD WHERE TeamID='%s' AND Name LIKE '%%%s%%' ORDER BY Name;" % (teamIDInput, searchItem)
			cur.execute(query)
			results = cur.fetchall()
			for result in results:
				print("Name:", result["Name"], ", Size:", result["Size"], "GB")

	except Exception as e:
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>>>>>>>>>>>>>", e)


def option5():
	try:
		searchItem = input("Enter the file name: ")
		query = "SELECT Name, Size, TeamID FROM DOWNLOAD WHERE Name LIKE '%%%s%%' ORDER BY Name;" % (searchItem)	
		cur.execute(query)
		results = cur.fetchall()
		for result in results:
			print("Name:", result["Name"], ", Size:", result["Size"], "GB", ", Team Drive ID:", result["TeamID"])

	except Exception as e:
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>>>>>>>>>>>>>", e)


def option6():
	try:
		x = "temp"
		while x.isdigit() == False:
			x = input("Enter the decimal value of x: ")
		x = int(x)
		query = "SELECT UserHandle, COUNT(*) AS CNT FROM MEMBER_OF GROUP BY UserHandle HAVING CNT > %f ;" % (x)
		cur.execute(query)
		results = cur.fetchall()
		for y in results:
			print(y['UserHandle'])

	except Exception as e:
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>>>>>>>>>>>",e)


def option7():

	try:
		reqSize = "temp"
		while reqSize.isnumeric() == False:
			reqSize = input("Enter the size in GB: ")
		reqSize = float(reqSize)
		query = "SELECT a.UserHandle as Handle, SUM(a.Size) as Data FROM (SELECT UserHandle, Size FROM TASK t, DOWNLOAD d WHERE t.DownloadName = d.Name AND t.DownloadTeamDriveID = d.TeamID) a GROUP BY UserHandle HAVING Data > '%f';" % (reqSize)
		cur.execute(query)
		results = cur.fetchall()
		for result in results:
			print("User Handle:", result["Handle"], ", Data downloaded:", result["Data"])

	except Exception as e:
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>>>>>>>>>>>",e)


def option8():
	try:
		hostip = input("Enter the Host IP: ")
		username = input("Enter the Username for the Server: ")
		passw = input("Enter the new Password: ")
		query="UPDATE SERVER SET Password = '%s' WHERE Username = '%s' AND HostIP = '%s';" % (passw, username, hostip)
		cur.execute(query)
		con.commit()

		print("Successfully Updated!")

	except Exception as e:
		con.rollback()
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>>>>>>>>>>>>>>",e)
		
		
def option9():
	try:
		teamID = input("ENTER THE TEAM ID: ")

		queryCheckIfIsBackup = "SELECT BackupOf FROM TEAM_DRIVE WHERE TeamId = '%s';" % (teamID)
		cur.execute(queryCheckIfIsBackup)
		result = cur.fetchall()

		if result[0]["BackupOf"] == None:
			# It is not a Backup
			queryGetBots = "SELECT * FROM BOT WHERE Uploads_On = '%s';" % (teamID)
			cur.execute(queryGetBots)
			bots = cur.fetchall()
			if len(bots) == 0:
				query="DELETE FROM TEAM_DRIVE WHERE TeamID = '%s';"	% (teamID)
				cur.execute(query)
				con.commit()
				print("Successfully deleted!")
			else:
				print("The following bots upload on this Team Drive:\n")
				for bot in bots:
					print("\tHandle:", bot['Handle'], ", Name:", bot['Name'])
				print("\nUpdate their values first please.")

		else:
			# It is a Backup
			queryGetCountOfBackups = "SELECT BackupOf, COUNT(*) AS NUM_BACKUPS FROM TEAM_DRIVE GROUP BY BackupOf HAVING BackupOf IN (SELECT BackupOf FROM TEAM_DRIVE WHERE TeamId = '%s');" % (teamID)
			cur.execute(queryGetCountOfBackups)
			result = cur.fetchall()
			mainTDID = result[0]["BackupOf"]
			numOfBackups = result[0]["NUM_BACKUPS"]

			if numOfBackups == 2:
				print("This is a backup of Team Drive with ID %s and deleting it will make the number of backups less than 2. Please add more Backups first." % (mainTDID))
			else:
				query="DELETE FROM TEAM_DRIVE WHERE TeamID = '%s';"	% (teamID)
				cur.execute(query)
				con.commit()
				print("Successfully deleted!")

	except Exception as e:
		con.rollback()
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>>",e)

def option10():
	try:
		inp = input("ENTER THE TEAM ID: ")
		query = "SELECT SUM(Size) as TOTAL FROM DOWNLOAD GROUP BY TeamID HAVING TeamID = '%s';" %(inp) 
		cur.execute(query)
		results = cur.fetchall()
		for y in results:
			 print(y['TOTAL'], "GB")
	except Exception as e:
		con.rollback()
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>",e)

def option11():
	try:
		mainID = input("Enter the Team Drive ID: ")
		mainName = input("Enter the Name: ")
		bp1ID = input("Enter the first Backup Team Drive ID: ")
		bp1Name = input("Enter the name of the first Backup drive: ")
		bp2ID = input("Enter the second Backup Team Drive ID: ")
		bp2Name = input("Enter the name of the second Backup drive: ")
		query = "INSERT INTO TEAM_DRIVE VALUES ('%s','%s',NULL),('%s','%s','%s'),('%s','%s','%s');" % (mainID, mainName, bp1ID, bp1Name, mainID, bp2ID, bp2Name, mainID)
		cur.execute(query)
		con.commit()

		print("Added Successfully!")

	except Exception as e:
		con.rollback()
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>",e)

def option12():
	try:
		handle = input("Enter the bot handle for the first bot: ")
		api = input("Enter the API key for the bot: ")
		name = input("Enter the Name of the bot: ")
		createTime = input("Enter the creation time of the bot (YYYY-MM-DD HH:MM:SS): ")
		queryGetValidTD = "SELECT td.* FROM TEAM_DRIVE td WHERE td.BackupOf IS NULL AND td.TeamId NOT IN (SELECT r.Uploads_On FROM (SELECT Uploads_On, COUNT(*) FROM BOT GROUP BY Uploads_On HAVING COUNT(*) >= 5) r)"
		cur.execute(queryGetValidTD)
		results = cur.fetchall()

		validTeamDrives = [result["TeamId"] for result in results if result["BackupOf"] == None]

		if(len(validTeamDrives)==0):
			print("No Team Drives available!!")
		else:
			for i in range(len(validTeamDrives)):
				print(i+1, validTeamDrives[i])
			print("CHoadklfj")
			driveNumberChosen = input("Chose the number from 1-%d: " % (len(validTeamDrives)))
			driveChosen = validTeamDrives[int(driveNumberChosen) - 1]
		
			queryGetValidServer = "SELECT HostIP, Username, Password, COUNT(*) as CNT FROM BOT GROUP BY HostIP, Username, Password HAVING CNT < 2"
			cur.execute(queryGetValidServer)
			results = cur.fetchall()
			validServers = [[i["HostIP"], i["Username"], i["Password"]] for i in results]
			if len(validServers) == 0:
				print("No Servers available!!")
			else:
				for i in range(len(validServers)):
					server = validServers[i]
					print(i+1, "HostIP:", server[0], "Username:", server[1], "Password:", server[2])
				serverNumberChosen = int(input("Chose a number from 1-%d: " % (len(validServers))))
				serverChosen = validServers[serverNumberChosen - 1]
				queryInsertBot = "INSERT INTO BOT VALUES ('%s', '%s', '%s', '%s', '%s', '%s','%s','%s');" % (name, handle, api, createTime, driveChosen, serverChosen[0], serverChosen[1], serverChosen[2])
				cur.execute(queryInsertBot)
				con.commit()

				print("Bot successfully added!!")

	except Exception as e:
		con.rollback()
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>",e)

def option13():
	try:
		bot = input("Enter the Bot Handle: ")
		queryGetValidTD = "SELECT td.* FROM TEAM_DRIVE td WHERE td.BackupOf IS NULL AND td.TeamId NOT IN (SELECT r.Uploads_On FROM (SELECT Uploads_On, COUNT(*) FROM BOT GROUP BY Uploads_On HAVING COUNT(*) >= 5) r)"
		cur.execute(queryGetValidTD)
		results = cur.fetchall()

		validTeamDrives = [result["TeamId"] for result in results if result["BackupOf"] == None]

		if(len(validTeamDrives)==0):
			print("No Team Drives available!!")
		else:
			for i in range(len(validTeamDrives)):
				print(i+1, validTeamDrives[i])
			driveNumberChosen = input("Chose the number from 1-%d: " % (len(validTeamDrives)))
			driveChosen = validTeamDrives[int(driveNumberChosen) - 1]
			query = "UPDATE BOT SET Uploads_On='%s' WHERE Handle='%s';" % (driveChosen, bot)
			cur.execute(query)
			con.commit()

			print("Successfully Updated!!")

	except Exception as e:
		con.rollback()
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>",e)	

	
def option14():
	try:
		handle = input("Enter the Group Handle: ")
		newName = input("Enter the new Name: ")
		query = "UPDATE GABRUS.GROUP SET Name ='%s' WHERE Handle='%s';" % (newName,handle)
		cur.execute(query)
		con.commit()
		print("Successfully Updated!!")

	except Exception as e:
		con.rollback()
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>",e)

def option15():
	
	try:
		query = "SELECT * FROM USER"
		cur.execute(query)
		users = cur.fetchall()

		for user in users:
			print("Handle:", user["UserHandle"], ", Name:", user["Name"], ", User ID:", user["UserId"])
	
	except Exception as e:
		print("Looks like we ran into some error!!")
		print(">>>>>>>>", e)

def option16():

	try:
		query = "SELECT * FROM GABRUS.GROUP"
		cur.execute(query)
		groups = cur.fetchall()

		for group in groups:
			print("Handle:", group["Handle"], ", Name:", group["Name"], ", Start Date:", group["Start-Date"])

	except Exception as e:
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>", e)

def option17():
	try:

		mainID = input("Enter the Team Drive ID for which you want to add a backup: ")
		if teamDriveExists(mainID) == False:
			print("The team ID doesn't exist!!")
		else:
			queryNameMainID = "SELECT Name, BackupOf FROM TEAM_DRIVE WHERE TeamId = '%s';" % (mainID)
			cur.execute(queryNameMainID)
			mainDrive = cur.fetchall()

			if mainDrive[0]["BackupOf"] != None:

				print("Please Enter a Team ID which is not a Backup of some other Drive!!")
			else:

				teamID = input("Enter the Team Drive ID for the Backup: ")
				teamName = input("Enter the Name of the Backup Team Drive: ")

				query = "INSERT INTO TEAM_DRIVE VALUES ('%s', '%s', '%s');" % (teamID, teamName, mainID)
				cur.execute(query)
				con.commit()

				print("Successfully Added!!")

	except Exception as e:
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>", e)

def option18():
	try:
		query = "SELECT * FROM DOWNLOAD WHERE FolderFlag = 1;"
		cur.execute(query)
		folders = cur.fetchall()
		for folder in folders:
			print("Name:", folder["Name"], ", TeamDriveID:", folder["TeamID"], ", Number Of Files:", folder["NumberOfFiles"])
	except Exception as e:
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>", e)


def option19():
	try:
		teamID = input("Enter the Team Drive ID: ")
		if teamDriveExists(teamID) == True:
			query = "SELECT * FROM DOWNLOAD WHERE FolderFlag = 1 AND TeamID = '%s';" % (teamID)
			cur.execute(query)
			folders = cur.fetchall()
			for folder in folders:
				print("Name:", folder["Name"], ", Number Of Files:", folder["NumberOfFiles"])
		else:
			print("The Team Drive doesn't exist!!")
	except Exception as e:
		print("Looks like we ran into some error!!")
		print(">>>>>>>>>>", e)


def dispatch(ch):
	"""
	Function that maps helper functions to option entered
	"""

	if(ch == 1):
		option1()
	elif(ch == 2):
		option2()
	elif(ch == 3):
		option3()
	elif(ch == 4):
		option4()
	elif(ch == 5):
		option5()
	elif(ch == 6):
		option6()
	elif(ch == 7):
		option7()
	elif(ch == 8):
		option8()
	elif(ch == 9):
		option9()
	elif(ch == 10):
		option10()
	elif(ch == 11):
		option11()
	elif(ch == 12):
		option12()
	elif(ch == 13):
		option13()
	elif(ch == 14):
		option14()
	elif(ch == 15):
		option15()
	elif(ch == 16):
		option16()
	elif(ch == 17):
		option17()
	elif(ch == 18):
		option18()
	elif(ch == 19):
		option19()
	else:
		print("Error: Invalid Option")


# Global
while(1):
	tmp = sp.call('clear', shell=True)
	
	# Can be skipped if you want to hard core username and password
	username = input("Username: ")
	password = input("Password: ")
	portChange = input("Do you want to change the default port? (y/n, Default- n) ")

	try:
		# Set db name accordingly which have been create by you
		# Set host to the server's address if you don't want to use local SQL server

		if portChange == "y" or portChange == "Y" :
			port = int(input("Enter the port number that you want to use: "))
			con = pymysql.connect(host='localhost',
									user=username,
									password=password,
									db='GABRUS',
									port=port,
									cursorclass=pymysql.cursors.DictCursor
								)
		else:
			con = pymysql.connect(host='localhost',
									user=username,
									password=password,
									db='GABRUS',
									cursorclass=pymysql.cursors.DictCursor
								)
			
		tmp = sp.call('clear', shell=True)

		if(con.open):
			print("Connected")
		else:
			print("Failed to connect")

		tmp = input("Press Enter to CONTINUE")

		with con.cursor() as cur:
			while(1):
				tmp = sp.call('clear', shell=True)
				print("1.  Get all the Users in a Group")
				print("2.  Get all the Files in a Team Drive")
				print("3.  Given x, get all the Team Drives with greater than x files")
				print("4.  Given a string, find all the Downloads which have it as a substring in a given TeamID")
				print("5.  Given a string, find all the Downloads which have it as a substring in all Team Drives")
				print("6.  List all the USERS that are present in more than x GROUPs for a given x")
				print("7.  Given a size x GB, get all the USERS that have downloaded more than x GB of data till now.")
				print("8.  Update the Password of a SERVER.")
				print("9.  Delete a TEAM_DRIVE record if it gets deleted by GSuite Admin")
				print("10. Find the total size of a Team Drive")
				print("11. Insert new Team Drive in Database")
				print("12. Insert a new Bot and add it to a Group")
				print("13. Update the Team Drive on which a Bot is uploading")
				print("14. Update the Name of a Group")
				print("15. Display all the Users")
				print("16. Display all the Groups")
				print("17. Add a new Backup of a Team Drive")
				print("18. Get all the Folders")
				print("19. Get all the Folders in a Team Drive")
				print("20. Logout")
				print("21. Exit")
				ch = int(input("Enter choice> "))
				tmp = sp.call('clear', shell=True)
				if ch == 20:
					break
				elif ch == 21:
					exit()
				else:
					dispatch(ch)
					tmp = input("Press Enter to CONTINUE")

	except:
		tmp = sp.call('clear', shell=True)
		print("Connection Refused: Either username or password is incorrect or user doesn't have access to database")
		tmp = input("Press Enter to CONTINUE")

