//
//  AdultDoseCell.swift
//  ParaMeds v1
//
//  Created by Stephen Smith on 4/26/18.
//  Copyright © 2018 Stephen Smith. All rights reserved.
//

import UIKit

class AdultDoseCell: UITableViewCell {

    
    @IBOutlet weak var drugLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
