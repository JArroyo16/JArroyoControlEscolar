//
//  AlumnoCell.swift
//  JArroyoControlEscolar
//
//  Created by MacBookMBP1 on 06/06/23.
//

import UIKit

class AlumnoCell: UITableViewCell {
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblFecha: UILabel!
    
    @IBOutlet weak var lblGenero: UILabel!
    
    @IBOutlet weak var lblTelefono: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
