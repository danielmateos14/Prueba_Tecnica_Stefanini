//
//  EliminadosTableViewCell.swift
//  PruebaTecnicaEstefanini
//
//  Created by danielmateos14 on 26/07/23.
//

import UIKit

class EliminadosTableViewCell: UITableViewCell {
    @IBOutlet weak var labelEmisor: UILabel!
    
    @IBOutlet weak var labelAsunto: UILabel!
    
    @IBOutlet weak var labelMensaje: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
