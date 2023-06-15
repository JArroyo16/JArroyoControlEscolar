//
//  MateriasAsignadasCell.swift
//  JArroyoControlEscolar
//
//  Created by MacBookMBP1 on 09/06/23.
//
import SwipeCellKit
import UIKit

class MateriasAsignadasCell: SwipeTableViewCell {
    
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblCosto: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
