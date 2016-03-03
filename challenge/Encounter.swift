//
//  Encounter.swift
//  challenge
//
//  Created by Subash Luitel on 2/19/16.
//  Copyright © 2016 Luitel. All rights reserved.
//

import Foundation

class Encounter: NSObject {

	/* user1 and user2 are the two users in an encounter. user1 comes before user2 in an ascending alphabetical order of their userNames. location1 and location2 correspond to user1 and user2 respectively.
	*/

	var user1: User?
	var user2: User?
	var location1 = Location()
	var location2 = Location()
	var time = NSDate()
	var userLocationDictionary = [String : AnyObject]()

	// initialize an encounter
	init(encounteredUser1: User, encounteredUser2: User, encounteredTime: NSDate) {
		user1 = encounteredUser1
		user2 = encounteredUser2
		location1 = encounteredUser1.lastLocation
		location2 = encounteredUser2.lastLocation
		time = encounteredTime
	}
}
