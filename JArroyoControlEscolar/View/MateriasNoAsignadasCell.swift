//
//  MateriasNoAsignadasCell.swift
//  JArroyoControlEscolar
//
//  Created by MacBookMBP1 on 09/06/23.
//

import UIKit

class MateriasNoAsignadasCell: UITableViewCell {
    
    @IBOutlet weak var lblMateria: UILabel!
    @IBOutlet weak var lblCosto: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
