//
//  StudentController.swift
//  hw-googleMap
//
//  Created by Mykhailo Tsyba on 2/26/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import UIKit
import MessageUI

class StudentController: UIViewController {

    @IBOutlet weak var headerView: UIView!
	@IBOutlet weak var headerLabel: UILabel!
	@IBOutlet weak var backButton: UIButton!

	@IBOutlet weak var studentView: UIView!
	@IBOutlet weak var studentImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var surnameLabel: UILabel!
	@IBOutlet weak var ageLabel: UILabel!
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var locationButton: UIButton!

	var student: Student?
	var isFromList = false

    override func viewDidLoad() {
        super.viewDidLoad()
		updateUI()
		locationButton.isHidden = isFromList ? false : true

    }

	@IBAction func didTapStudentPhoneButton(_ sender: Any) {
		debugPrint("call phone")
		guard let item = student else { return }
		callPhone(phoneNumber: item.phone ?? "")
	}

	@IBAction func didTapStudentSMSButton(_ sender: Any) {
		debugPrint("sms")
		if MFMessageComposeViewController.canSendText() {
			print("SMS services are not available")
			guard let item = student else { return }
			let composeSMSVC = MFMessageComposeViewController()
			composeSMSVC.messageComposeDelegate = self

			// Configure the fields of the interface.
			composeSMSVC.recipients = [(item.phone ?? "")]
			composeSMSVC.body = "Hello from \(item.name ?? "")"

			// Present the view controller modally.
			self.present(composeSMSVC, animated: true, completion: nil)
		}
	}

	@IBAction func didTapStudentEmailButton(_ sender: Any) {
		debugPrint("email")
		if MFMailComposeViewController.canSendMail() {
			let composeEmailVC = MFMailComposeViewController()
			composeEmailVC.mailComposeDelegate = self
			guard let item = student else { return }
			// Configure the fields of the interface.
			composeEmailVC.setToRecipients([item.email ?? ""])
			composeEmailVC.setSubject("Hi there")
			composeEmailVC.setMessageBody("Hello from \(item.name ?? "")", isHTML: false)

			// Present the view controller modally.
			self.present(composeEmailVC, animated: true, completion: nil)
		}
	}

	@IBAction func didTapStudentLocationButton(_ sender: Any) {
		debugPrint("Location")
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController

		guard let item = self.student else {return}
		vc.studentLatitude = item.latitude ?? 50.4480624
		vc.studentLongitude = item.longitude ?? 30.5701821
		vc.studentZoom = 16
		vc.isFromProfile = true
		
		navigationController?.pushViewController(vc, animated: false)
	}

	@IBAction func didTapBackButton(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}

}

//MARK: - update UI
extension StudentController {
	func updateUI() {
		guard let item = student else { return }
		studentImageView.image = UIImage(named: item.imageName ?? "")
		nameLabel.text = item.name ?? ""
		surnameLabel.text = item.surname ?? ""
		ageLabel.text = item.age ?? ""
		cityLabel.text = item.city ?? ""
	}
}

//MARK: - Send SMS
extension StudentController: MFMessageComposeViewControllerDelegate {
	func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {

		switch result {
        case .sent:
            print("SMS sent")
        case .cancelled:
            print("SMS cancelled")
        case  .failed:
            print("SMS failed")
		default:
			print("default case")
		}
        controller.dismiss(animated: true, completion: nil)
	}
}

//MARK: - Send Email
extension StudentController: MFMailComposeViewControllerDelegate {
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {

		switch result {
        case .sent:
            print("Email sent")
        case .saved:
            print("Draft saved")
        case .cancelled:
            print("Email cancelled")
        case  .failed:
            print("Email failed")
		default:
			print("default case")
		}
        controller.dismiss(animated: true, completion: nil)
	}

	func callPhone(phoneNumber: String) {
		guard let number = URL(string: "tel://" + phoneNumber) else {
			return
		}
		UIApplication.shared.open(number)
	}
}
