//
//  ViewController.swift
//  PruebaTecnicaEstefanini
//
//  Created by danielmateos14 on 25/07/23.
//

import UIKit

class ViewController: UIViewController {

    var dummyModelArray: [DummyModel] = []
    var spam: Bool?
    var destacado: Bool?
    var leido: Bool?
    let usersDefault = UserDefaults.standard
    var celdasEliminadas: [DeleteModel] = []
    //    Array para la barra de busqueda
    var arrayParaBusqueda: [DummyModel]!
    
    
    @IBOutlet weak var tableViewDummy: UITableView!
    
    @IBOutlet weak var searchBarDummy: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayParaBusqueda = dummyModelArray
        DummyController.shared.delegate = self
        DummyController.shared.requestDummy()
        tableViewDummy.delegate = self
        tableViewDummy.dataSource = self
        searchBarDummy.delegate = self
        tableViewDummy.register(UINib(nibName: "DummyCellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }

    @IBAction func hamburguerM(_ sender: Any ) {
        performSegue(withIdentifier: "segueHamburguesa", sender: nil)
    }
    
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayParaBusqueda?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewDummy.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DummyCellTableViewCell
        
        destacado = arrayParaBusqueda?[indexPath.row].destacado
        spam = arrayParaBusqueda?[indexPath.row].spam
        leido = arrayParaBusqueda?[indexPath.row].leido
        if leido == true {
            cell.labelEmisor.text = arrayParaBusqueda?[indexPath.row].emisor
            cell.labelEmisor.textColor = .gray
            cell.labelAsunto.text = arrayParaBusqueda?[indexPath.row].asunto
            cell.labelAsunto.textColor = .gray
            cell.labelMensaje.text = arrayParaBusqueda?[indexPath.row].mensaje
            cell.labelMensaje.textColor = .gray
        } else {
            cell.labelEmisor.text = arrayParaBusqueda?[indexPath.row].emisor
            cell.labelEmisor.textColor = .black
            cell.labelAsunto.text = arrayParaBusqueda?[indexPath.row].asunto
            cell.labelAsunto.textColor = .black
            cell.labelMensaje.text = arrayParaBusqueda?[indexPath.row].mensaje
            cell.labelMensaje.textColor = .black
        }
        if destacado == true { //Si esta lleno pones este icono
            cell.ivFavorites.image = UIImage(systemName: "star.fill")
            usersDefault.set(true, forKey: "favorito")
        }else {
            cell.ivFavorites.image = UIImage(systemName: "star")
            usersDefault.set(false, forKey: "favorito")
        }
        if spam == true {
            cell.ivSpam.image = UIImage(systemName: "exclamationmark.triangle.fill")
        }else {
            cell.ivSpam.image = UIImage(systemName: "exclamationmark.triangle")
        }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}

extension ViewController: DummyProtocol {
    func actualizarUI(recibeObjetoCorreos: [DummyModel]) {
        dummyModelArray = recibeObjetoCorreos
        arrayParaBusqueda = dummyModelArray
        DispatchQueue.main.async {
            self.tableViewDummy.reloadData()
        }
    }
    
    
}

extension ViewController: DummyCellTableViewCellDelegate {
    func botonTrashPresionado(cell: DummyCellTableViewCell) {
        if let indexPath = tableViewDummy.indexPath(for: cell) {
            
            if let datosEliminados = arrayParaBusqueda?[indexPath.row] {
                let deletedCellData = DeleteModel(emisor: datosEliminados.emisor,
                                                      asunto: datosEliminados.asunto,
                                                      mensaje: datosEliminados.mensaje)
                celdasEliminadas.append(deletedCellData)
//                print(celdasEliminadas)
                guardarCeldasEliminadas()
                dummyModelArray = arrayParaBusqueda
            }

            
            arrayParaBusqueda?.remove(at: indexPath.row)

            
            tableViewDummy.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func guardarCeldasEliminadas() {
        
        do {
            let jsonData = try JSONEncoder().encode(celdasEliminadas)
            UserDefaults.standard.set(jsonData, forKey: "jsonEliminados")
        } catch {
            print("Error al codificar el arreglo celdasEliminadas: \(error)")
        }
    }
}


extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        arrayParaBusqueda = []
        
        if searchText == "" || searchText.isEmpty{
            arrayParaBusqueda = dummyModelArray
            
        }else{
            for correo in dummyModelArray{
                if correo.emisor.lowercased().contains(searchText.lowercased()){
                    arrayParaBusqueda.append(correo)
                }
            }
            
        }
        
        self.tableViewDummy.reloadData()
    }
    
//    Al presionar el boton busqueda
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        Cerramos el teclado
        searchBarDummy.resignFirstResponder()
    }
}

