//
//  TableViewCell.swift
//  CrimeMap
//
//  Created by Jiatai Sun on 4/20/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var DetailLabel: UILabel!
    @IBOutlet weak var IncidentLabel: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
