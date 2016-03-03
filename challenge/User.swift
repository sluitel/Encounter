//
//  User.swift
//  challenge
//
//  Created by Subash Luitel on 2/19/16.
//  Copyright © 2016 Luitel. All rights reserved.
//

import Foundation


class User: NSObject {
	var userName = String()
	var lastRecorded = NSDate()
	var lastLocation = Location()

	// initialize a user
	init(name: String, time: String, latitude: String, longitude: String) {
		userName = name

		// String to NSDate
		if let interval = Double(time) {
			let timeStamp = NSDate(timeIntervalSince1970: interval)
			lastRecorded = timeStamp
		}

		// convert latitude and longitude to CLLocation
		if let locationLatitude = Double(latitude) {
			if let locationLongitude = Double(longitude) {
				let location = Location(lat: locationLatitude, long: locationLongitude)
				lastLocation = location
			}
		}
	}

	// update a user
	func updateLocation(time: String, latitude: String, longitude: String) {

		// Update user time
		if let interval = Double(time) {
			let timeStamp = NSDate(timeIntervalSince1970: interval)
			lastRecorded = timeStamp
		}

		// Update user location
		if let locationLatitude = Double(latitude) {
			if let locationLongitude = Double(longitude) {
				let location = Location(lat: locationLatitude, long: locationLongitude)
				lastLocation = location
			}
		}
	}
}
