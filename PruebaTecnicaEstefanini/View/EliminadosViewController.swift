//
//  EliminadosViewController.swift
//  PruebaTecnicaEstefanini
//
//  Created by danielmateos14 on 26/07/23.
//

import UIKit

class EliminadosViewController: UIViewController {
    
    var arrayEliminados: [DeleteModel]? = []

    @IBOutlet weak var tableViewEliminados: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableViewEliminados.delegate = self
        tableViewEliminados.dataSource = self
        tableViewEliminados.register(UINib(nibName: "EliminadosTableViewCell", bundle: nil), forCellReuseIdentifier: "cellEliminados")
        crearEliminados()
    }
    
    func crearEliminados() {
        if let jsonDataArray = UserDefaults.standard.data(forKey: "jsonEliminados") {
            let jsonDecoder = JSONDecoder()
            if let eliminatedDataArray = try? jsonDecoder.decode([DeleteModel].self, from: jsonDataArray) {
                arrayEliminados = eliminatedDataArray
                tableViewEliminados.reloadData()
            }
        }
    }
    

}

extension EliminadosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayEliminados?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewEliminados.dequeueReusableCell(withIdentifier: "cellEliminados", for: indexPath) as? EliminadosTableViewCell
        cell?.labelEmisor.text = arrayEliminados?[indexPath.row].emisor
        cell?.labelAsunto.text = arrayEliminados?[indexPath.row].asunto
        cell?.labelMensaje.text = arrayEliminados?[indexPath.row].mensaje
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
