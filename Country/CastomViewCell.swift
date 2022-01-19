//
//  CastomViewCell.swift
//  Country
//
//  Created by Евгений Григоренко on 6.01.22.
//

import UIKit

class CastomViewCell: UITableViewCell {

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var ImageCountryView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countryLabel.lineBreakMode = .byWordWrapping // or NSLineBreakMode.ByWordWrapping
        countryLabel.numberOfLines = 0
        ImageCountryView.layer.cornerRadius = ImageCountryView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


