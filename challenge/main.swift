//
//  main.swift
//  challenge
//
//  Created by Subash Luitel on 2/19/16.
//  Copyright © 2016 Luitel. All rights reserved.
//

import Foundation
import CoreLocation

// No of hours to count a user as inactive
let activeValidationHour = 6.0

// no of hours until two users can have another encounter
let encounterValidationHour = 24.0

// file with input data
let datafile = "userdata.txt"

// output file
let outputfile = "output.txt"

// Run Encounter Finder
let finder = EncounterFinder()
finder.processDataFromInputFile()