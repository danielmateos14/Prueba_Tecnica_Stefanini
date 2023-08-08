//
//  DummyCellTableViewCell.swift
//  PruebaTecnicaEstefanini
//
//  Created by danielmateos14 on 25/07/23.
//

import UIKit

protocol DummyCellTableViewCellDelegate: AnyObject {
    func botonTrashPresionado(cell: DummyCellTableViewCell)
}

class DummyCellTableViewCell: UITableViewCell {

    @IBOutlet weak var ivFavorites: UIImageView!
    @IBOutlet weak var ivSpam: UIImageView!
    @IBOutlet weak var labelEmisor: UILabel!
    
    @IBOutlet weak var labelAsunto: UILabel!
    
    @IBOutlet weak var labelMensaje: UILabel!
    
    @IBOutlet weak var ivTrash: UIImageView!
    
    let usersDefault = UserDefaults.standard
    weak var delegate: DummyCellTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconoFavorito()
        iconoSpam()
        iconoTrash()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func iconoFavorito(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presionasteFavoritos))
        ivFavorites.isUserInteractionEnabled = true
        ivFavorites.addGestureRecognizer(tapGesture)
    }
    @objc func presionasteFavoritos() {
        
        if ivFavorites.image == UIImage(systemName: "star.fill") {
            ivFavorites.image = UIImage(systemName: "star")
        } else if ivFavorites.image == UIImage(systemName: "star"){
            ivFavorites.image = UIImage(systemName: "star.fill")
        }
    }
    func iconoSpam(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presionasteSpam))
        ivSpam.isUserInteractionEnabled = true
        ivSpam.addGestureRecognizer(tapGesture)
    }
    @objc func presionasteSpam() {
        
        if ivSpam.image == UIImage(systemName: "exclamationmark.triangle.fill"){
            ivSpam.image = UIImage(systemName: "exclamationmark.triangle")
        } else if ivSpam.image == UIImage(systemName: "exclamationmark.triangle"){
            ivSpam.image = UIImage(systemName: "exclamationmark.triangle.fill")
        }
       }
    func iconoTrash(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presionasteTrash))
        ivTrash.isUserInteractionEnabled = true
        ivTrash.addGestureRecognizer(tapGesture)
    }
    @objc func presionasteTrash() {
           print("Basura")
        delegate?.botonTrashPresionado(cell: self)
       }
    
}

