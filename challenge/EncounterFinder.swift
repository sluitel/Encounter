//
//  EncounterFinder.swift
//  challenge
//
//  Created by Subash Luitel on 2/19/16.
//  Copyright © 2016 Luitel. All rights reserved.
//

import Foundation

class EncounterFinder {

	var users = Set<User>()
	var encounterDictionary = [String : [Encounter]]()
	var outputString = ""
	var startDate = NSDate()
	let distanceCalculator = DistanceCalculator()

	func processDataFromInputFile() {
		print("Processing")
		// Locate the data file
		let fileManager = NSFileManager.defaultManager()
		let currentPath = fileManager.currentDirectoryPath
		let inputPath = currentPath + "/" + datafile
		let outputPath = currentPath + "/" + outputfile
		let filemgr = NSFileManager.defaultManager()
		if filemgr.fileExistsAtPath(inputPath) {
			do {
				let readFile = try String(contentsOfFile: inputPath, encoding: NSUTF8StringEncoding)

				// Enumerate by new line
				readFile.enumerateLines({ (line, stop) -> () in
					let locationPoints = line.characters.split{$0 == "|"}.map(String.init)
					if locationPoints.count == 4 {
						let name = locationPoints[0]
						let time = locationPoints[1]
						let latitude  = locationPoints[2]
						let longitude = locationPoints[3]

						if let index = self.users.indexOf({$0.userName == name}) {
							// if user already exists update time and location
							let theUser = self.users[index]
							theUser.updateLocation(time, latitude: latitude, longitude: longitude)
							self.checkEncounter(theUser)
						}
						else {
							// otherwise create a new user and add it to the users array
							let theUser = User(name: name, time: time, latitude: latitude, longitude: longitude)
							self.users.insert(theUser)
							self.checkEncounter(theUser)
						}
					}
				})

				// Write to file
				do {
					try outputString.writeToFile(outputPath, atomically: true, encoding: NSUTF8StringEncoding)
				} catch let error as NSError {
					print("Write Error: \(error)")
				}

			} catch let error as NSError {
				print("Read Error: \(error)")
			}
		}
		else {
			print("File does not exist")
		}

		let interval = NSDate().timeIntervalSinceDate(startDate)
		print("Completed (\(interval) seconds)\nEncounters are saved to output.txt file")

	}

	// check for encounters for a user
	func checkEncounter(user: User) {

		var validUsers = [User]()
		let	lastValidTimeForUser = user.lastRecorded.dateByAddingTimeInterval(-activeValidationHour * 60 * 60)
		let	lastValidTimeForEncounter = user.lastRecorded.dateByAddingTimeInterval(-encounterValidationHour * 60 * 60)

		// filter through users to get active users
		validUsers = users.filter({ (theUser) -> Bool in
			if theUser.userName != user.userName {
				return theUser.lastRecorded.compare(lastValidTimeForUser) == NSComparisonResult.OrderedDescending
			}
			return false
		})

		for validUser in validUsers {
			var user1 = user
			var user2 = validUser

			// sort user by username. user1 comes before user2 when sorted by their username in ascending order.
			if user1.userName.compare(user2.userName) == NSComparisonResult.OrderedDescending	{
				user1 = validUser
				user2 = user
			}

			// create new encounter if users didn't have any encounter in past 24 hours and they are within 150m range
			if !usersEncounteredBefore(user1, user2: user2, lastValidtime: lastValidTimeForEncounter) &&
				distanceCalculator.distanceBetweenTwoLocations(user1.lastLocation, location2: user2.lastLocation) <= 150 {

				// Create outpur string
				let timestamp = UInt64(user.lastRecorded.timeIntervalSince1970)
				let user1Name = user1.userName
				let user1Latitude = user1.lastLocation.latitude
				let user1Longitude = user1.lastLocation.longitude
				let user2Name = user2.userName
				let user2Latitude = user2.lastLocation.latitude
				let user2Longitude = user2.lastLocation.longitude

				outputString += "\(timestamp)|\(user1Name)|\(user1Latitude)|\(user1Longitude)|\(user2Name)|\(user2Latitude)|\(user2Longitude)\n"

				// Add encounter to dictionary
				let record = Encounter(encounteredUser1: user1, encounteredUser2: user2, encounteredTime: user.lastRecorded)
				let key = user1.userName + user2.userName
				if var encounters = encounterDictionary[key] {
					encounters.append(record)
					encounterDictionary.updateValue(encounters, forKey: key)
				}
				else {
					encounterDictionary[key] = [record]
				}
			}
		}
	}

	// Check if the users have encountered within last 24 hours
	func usersEncounteredBefore(user1: User, user2: User, lastValidtime: NSDate) -> Bool {
		let key = user1.userName + user2.userName
		if let encounters = encounterDictionary[key] {
			if let lastEncounter = encounters.last {
				let lastEncounterTime = lastEncounter.time
				return lastEncounterTime.compare(lastValidtime) == NSComparisonResult.OrderedDescending
			}
		}
		return false
	}
}
