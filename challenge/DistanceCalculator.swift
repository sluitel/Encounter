//
//  DistanceCalculator.swift
//  challenge
//
//  Created by Subash Luitel on 2/19/16.
//  Copyright © 2016 Luitel. All rights reserved.
//

import Foundation

class DistanceCalculator {

	// Haversine formula for geodesic distance calculation
	func distanceBetweenTwoLocations(location1: Location, location2: Location) -> Double {
		let latitude1rad = location1.latitude * M_PI/180
		let longitude1rad = location1.longitude * M_PI/180
		let latitude2rad = location2.latitude * M_PI/180
		let longitude2rad = location2.longitude * M_PI/180

		let dLatitude = latitude2rad - latitude1rad
		let dLongitude = longitude2rad - longitude1rad
		let a = sin(dLatitude/2) * sin(dLatitude/2) + sin(dLongitude/2) * sin(dLongitude/2) * cos(latitude1rad) * cos(latitude2rad)
		let c = 2 * asin(sqrt(a))

		//assume the radius of the earth is 6,371,009 meters
		let R = 6371009.0

		return R * c
	}
}

