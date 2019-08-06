//
//  ShowMoreTableViewCell.swift
//  WeatherApplication
//
//  Created by Harsha on 06/08/19.
//  Copyright © 2019 Ixigo. All rights reserved.
//

import UIKit

class ShowMoreTableViewCell: UITableViewCell {

    @IBOutlet weak var showMoreButton: UIButton!
    @IBAction func showMoreTapped(_ sender: UIButton) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configureButton()
    }
    
    private func configureButton() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: "Show More", attributes: [NSMutableAttributedString.Key.paragraphStyle : paragraphStyle , NSMutableAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
                                                                                           NSMutableAttributedString.Key.foregroundColor : UIColor.white
            ]
        )
        showMoreButton.setAttributedTitle(attributedString, for: .normal)
        showMoreButton.backgroundColor = UIColor(red: 70/255, green: 174/255, blue: 255/255, alpha: 1)
        showMoreButton.layer.cornerRadius = 16
    }
}
