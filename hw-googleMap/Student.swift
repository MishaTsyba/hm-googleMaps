//
//  Student.swift
//  hw-googleMap
//
//  Created by Mykhailo Tsyba on 2/25/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class Student {
	var imageName: String?
	var name: String?
	var surname: String?
	var age: String?
	var city: String?
	var phone: String?
	var email: String?
	var latitude: CLLocationDegrees?
	var longitude: CLLocationDegrees?

	init(name: String, surname: String, age: String, city: String, phone: String, email: String, imageName: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
		self.name = name
		self.surname = surname
		self.age = age
		self.city = city
		self.phone = phone
		self.email = email
		self.imageName = imageName
		self.latitude = latitude
		self.longitude = longitude
	}
}
