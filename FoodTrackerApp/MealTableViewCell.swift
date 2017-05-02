//
//  MealTableViewCell.swift
//  FoodTrackerApp
//
//  Created by Tulio Marcos Franca on 23/04/17.
//  Copyright © 2017 0neTech. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layoutCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Layout
    private func layoutCell() {
        photoImageView.layer.cornerRadius = photoImageView.frame.size.width / 2 //10
        //photoImageView.clipsToBounds = true // Clip to bounds in attributes inspector
        photoImageView.layer.borderWidth = 3
        photoImageView.layer.borderColor = UIColor.orange.cgColor
    }

}
