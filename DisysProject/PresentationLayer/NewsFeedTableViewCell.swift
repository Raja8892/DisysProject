//
//  NewsFeedTableViewCell.swift
//  DisysProject
//
//  Created by Moses on 12/08/19.
//  Copyright © 2019 Raja Inbam. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage


class NewsFeedTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var feedTitle: UILabel!
    @IBOutlet weak var feedDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(payload:Payload){
        
        self.feedTitle.text = payload.title
        self.feedDescription.text = payload.description 
        self.dateLbl.text = payload.date
        self.feedImage.sd_setImage(with: URL(string: payload.image), placeholderImage: UIImage(named: "placeholder.png"))

    }

}
