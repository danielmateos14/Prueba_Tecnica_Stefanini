//
//  MenuHamburguesaViewController.swift
//  PruebaTecnicaEstefanini
//
//  Created by danielmateos14 on 26/07/23.
//

import Foundation
import UIKit

class MenuHamburguesaViewController: UIViewController {
    @IBOutlet weak var viewMenu: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewMenu.layer.cornerRadius = 10
        viewMenu.layer.shadowColor = UIColor.black.cgColor
        viewMenu.layer.shadowOpacity = 0.5
        viewMenu.layer.shadowOffset = CGSize(width: 4, height: 2)
        viewMenu.layer.shadowRadius = 4
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        self.view.backgroundColor = .black.withAlphaComponent(0)
    }
    
    @IBAction func botonCerrar(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func favoritos(_ sender: Any) {
        
    }
    
    @IBAction func Spam(_ sender: Any) {
        
    }
    
    @IBAction func eliminado(_ sender: Any) {
        
        performSegue(withIdentifier: "segueElminados", sender: nil)
        
    }
}

