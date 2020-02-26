//
//  StudentCell.swift
//  hw-googleMap
//
//  Created by Mykhailo Tsyba on 2/26/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import UIKit

class StudentCell: UITableViewCell {

	@IBOutlet weak var cellContainerView: UIView!
	@IBOutlet weak var studentImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var surnameLabel: UILabel!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: - update cell
extension StudentCell {

	func updateStudentCell(student: Student) {
		studentImageView.image = UIImage(named: student.imageName ?? "")
		nameLabel.text = student.name ?? ""
		surnameLabel.text = student.surname ?? ""
	}
}
