//
//  StudentListController.swift
//  hw-googleMap
//
//  Created by Mykhailo Tsyba on 2/26/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import UIKit

class StudentListController: UIViewController {

	@IBOutlet weak var headerView: UIView!
	@IBOutlet weak var headerLabel: UILabel!
	@IBOutlet weak var backButton: UIButton!
	@IBOutlet weak var tableView: UITableView!

	var students = [Student]()

    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UINib(nibName: "StudentCell", bundle: nil), forCellReuseIdentifier: "StudentCell")
		tableView.reloadData()

    }
    
	@IBAction func didTapBackButton(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
}

//MARK: - UITableViewDelegate
extension StudentListController: UITableViewDelegate, UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return students.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentCell
		cell.updateStudentCell(student: students[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

		debugPrint("*********** SearchResultController didSelectRowAt  **************")

		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(withIdentifier: "StudentController") as! StudentController

		vc.student = students[indexPath.row]
		vc.isFromList = true
		navigationController?.pushViewController(vc, animated: false)
    }

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}
