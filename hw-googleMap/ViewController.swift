//
//  ViewController.swift
//  hw-googleMap
//
//  Created by Mykhailo Tsyba on 2/25/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

enum MarkerName: String {
	case mike = "Mike's Home"
	case alex = "Alex's Home"
	case lera = "Lera's Home"
	case neo = "Neo's Home"
}

class ViewController: UIViewController {

	@IBOutlet weak var headerView: UIView!
	@IBOutlet weak var headerLabel: UILabel!
	//MARK: - set the custom class on your map view in your storyboard scene!!!
	@IBOutlet weak var mapaView: GMSMapView!

	var students = [Student]()
	var markerMike = GMSMarker()
	var markerAlex = GMSMarker()
	var markerLera = GMSMarker()
	var markerNeo = GMSMarker()
	var markerKyivFort = GMSMarker()
	var studentLatitude = CLLocationDegrees()
	var studentLongitude = CLLocationDegrees()
	var studentZoom = Float()
	var studentCoordinate = CLLocationCoordinate2D()
	var defaultCoordinate = CLLocationCoordinate2D(latitude: 50.4340132, longitude: 30.5276772)
	var isFromProfile = false

	override func viewDidLoad() {
		super.viewDidLoad()
		students = makeStudents()

		if isFromProfile {
			let camera = GMSCameraPosition.camera(withLatitude: studentLatitude, longitude: studentLongitude, zoom: studentZoom)
			mapaView.camera = camera
			mapaView.delegate = self
			isFromProfile = false
		} else {
			let camera = GMSCameraPosition.camera(withLatitude: 50.4340132, longitude: 30.5276772, zoom: 10.0)
			mapaView.camera = camera
			mapaView.delegate = self
		}

		makeMarkers(students: students)
	}

	@IBAction func didTapStudentsButton(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(withIdentifier: "StudentListController") as! StudentListController

		vc.students = self.students
		navigationController?.pushViewController(vc, animated: false)
	}
}

extension ViewController: GMSMapViewDelegate {
	func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
		guard let markerTitle = marker.title else {return false}
		switch markerTitle {
		case MarkerName.mike.rawValue:
			let student = students[0]
			navigateFromMarker(student: student)
		case MarkerName.alex.rawValue:
			let student = students[1]
			navigateFromMarker(student: student)
		case MarkerName.lera.rawValue:
			let student = students[2]
			navigateFromMarker(student: student)
		case MarkerName.neo.rawValue:
			let student = students[3]
			navigateFromMarker(student: student)
		default:
			break
		}
		return true
	}
}

extension ViewController {
	func navigateFromMarker(student: Student) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(withIdentifier: "StudentController") as! StudentController

		vc.student = student
		vc.isFromList = false
		navigationController?.pushViewController(vc, animated: false)
	}

	func makeStudents() -> [Student] {
		var studentsArray = [Student]()
		let studentMike = Student(name: "Mike", surname: "Tsyba", age: "41", city: "Kiev", phone: "+380503387901", email: "mike.tsyba@gmail.com", imageName: "mikeTelegram", latitude: 50.4122864, longitude: 30.529859)
		let studentAlex = Student(name: "Alex", surname: "Sorochan", age: "36", city: "Kiev", phone: "+380503387902", email: "alex@gmail.com", imageName: "alexTelegram", latitude: 50.4278579, longitude: 30.4321672)
		let studentLera = Student(name: "Lera", surname: "Zakharova", age: "28", city: "Kiev", phone: "+380503387903", email: "lera@gmail.com", imageName: "leraTelegram", latitude: 50.4238792, longitude: 30.5430915)
		let studentNeo = Student(name: "Neo", surname: "The One", age: "1", city: "Kiev", phone: "+380503387904", email: "neo@gmail.com", imageName: "neo", latitude: 50.4480624, longitude: 30.5701821)
		studentsArray = [studentMike, studentAlex, studentLera, studentNeo]
		return studentsArray
	}

	func makeMarkers(students: [Student]) {

		let coordinateMike = CLLocationCoordinate2D(latitude: students[0].latitude!, longitude: students[0].longitude!)
		markerMike = GMSMarker(position: coordinateMike)
		markerMike.title = MarkerName.mike.rawValue
		markerMike.map = mapaView

		let coordinateAlex = CLLocationCoordinate2D(latitude: students[1].latitude!, longitude: students[1].longitude!)
		markerAlex = GMSMarker(position: coordinateAlex)
		markerAlex.title = MarkerName.alex.rawValue
		markerAlex.map = mapaView

		let coordinateLera = CLLocationCoordinate2D(latitude: students[2].latitude!, longitude: students[2].longitude!)
		markerLera = GMSMarker(position: coordinateLera)
		markerLera.title = MarkerName.lera.rawValue
		markerLera.map = mapaView

		let coordinateNeo = CLLocationCoordinate2D(latitude: students[3].latitude!, longitude: students[3].longitude!)
		markerNeo = GMSMarker(position: coordinateNeo)
		markerNeo.title = MarkerName.neo.rawValue
		markerNeo.map = mapaView
	}
}
