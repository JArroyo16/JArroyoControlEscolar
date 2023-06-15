//
//  MateriaController.swift
//  JArroyoControlEscolar
//
//  Created by MacBookMBP1 on 06/06/23.
//

import UIKit
import SwipeCellKit

class MateriaController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var materias : [Materia] = []
    var IdMateria : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MateriaCell", bundle: .main), forCellReuseIdentifier: "MateriaCell")
        tableView.delegate = self
        tableView.dataSource = self
        updateUI()
    }
    
    func updateUI(){
        var resultados = MateriaViewModel.GetAll { result, error in
        if let resultSource = result{
            for objmateria in resultSource.Objects!{
                let materia = objmateria
                self.materias.append(materia)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        }
    }
    
}

extension MateriaController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materias.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MateriaCell", for: indexPath) as! MateriaCell
        cell.delegate = self
        cell.lblNombre.text = materias[indexPath.row].Nombre
        cell.lblCosto.text = "$ \(materias[indexPath.row].Costo.description)"
        return cell
    }
}

extension MateriaController : SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                MateriaViewModel.Delete(IdMateria: self.materias[indexPath.row].IdMateria, reponse: {result, error in
                    if ((result?.Correct) != nil){
                        let alert = UIAlertController(title: "Mensaje", message: "Materia eliminada correctamente", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Aceptar", style: .default)
                        alert.addAction(action)
                        self.present(alert,animated: true)
                    } else{
                        let alert = UIAlertController(title: "Mensaje", message: "Ocurrio un error a eliminar la materia", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Aceptar", style: .default)
                        alert.addAction(action)
                        self.present(alert,animated: true)
                    }
                })
            }
            return [deleteAction]
        }
        
        if orientation == .left {
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                self.IdMateria = self.materias[indexPath.row].IdMateria
                self.performSegue(withIdentifier: "FormularioMateriaController", sender: self)
            }
            return [updateAction]
        }
        return nil
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "FormularioMateriaController"{
            var formControl = segue.destination as! FormularioMateriaController
            formControl.IdMateria = self.IdMateria
            print(IdMateria)
        }

    }
}
