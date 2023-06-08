//
//  MateriaController.swift
//  JArroyoControlEscolar
//
//  Created by MacBookMBP1 on 06/06/23.
//

import UIKit

class MateriaController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var materias : [Materia] = []
    var IdMateria = 0
    
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
            for objmateria in resultSource.Objects{
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
        //cell.delegate = self
        cell.lblNombre.text = materias[indexPath.row].Nombre
        cell.lblCosto.text = "$ \(materias[indexPath.row].Costo.description)"
        return cell
    }
}
