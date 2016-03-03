//
//  Location.swift
//  challenge
//
//  Created by Subash Luitel on 2/20/16.
//  Copyright © 2016 Luitel. All rights reserved.
//

import Foundation

class Location: NSObject {
	var latitude = 0.0
	var longitude = 0.0

	init(lat: Double, long: Double) {
		latitude = lat
		longitude = long
	}

	override init() {
		latitude = 0.0
		longitude = 0.0
	}
}
