//
//  AdultViewCell.swift
//  ParaMeds v1
//
//  Created by Stephen Smith on 4/27/18.
//  Copyright © 2018 Stephen Smith. All rights reserved.
//

import UIKit

class AdultViewCell: UITableViewCell {

    
    @IBOutlet weak var ainjectionLbl: UILabel!
    @IBOutlet weak var aInitialDose: UILabel!
    @IBOutlet weak var aSecondDose: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
