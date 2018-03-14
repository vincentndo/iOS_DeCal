//
//  FeedTableViewCell.swift
//  Snapchat Clone
//
//  Created by Vincent Ninh DO on 3/13/18.
//  Copyright © 2018 org.iosdecal. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var seenStatus: UIImageView!
    
    @IBOutlet weak var feedSender: UILabel!
    
    @IBOutlet weak var elapsedTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
