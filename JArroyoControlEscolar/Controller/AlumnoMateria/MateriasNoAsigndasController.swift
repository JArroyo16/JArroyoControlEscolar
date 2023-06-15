//
//  MateriasNoAsigndasController.swift
//  JArroyoControlEscolar
//
//  Created by MacBookMBP1 on 12/06/23.
//

import UIKit

class MateriasNoAsigndasController: UIViewController {
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var materias : [AlumnoMateria] = []
    var IdAlumnoMateria = 0
    var IdMateria = 0
    var nombre : String = ""
    var appellidoP : String = ""
    var apellidoM : String = ""
    var materiasSelect : [AlumnoMateria] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblNombre.text = "Nombre: \(nombre) \(appellidoP) \(apellidoM)"
        tableView.register(UINib(nibName: "MateriasNoAsignadasCell", bundle: .main), forCellReuseIdentifier: "MateriasNoAsignadasCell")
        tableView.delegate = self
        tableView.dataSource = self
        materiasSelect = materias
        updateUI()
    }
    
    func updateUI(){
        var resultados = AlumnoMateriaViewModel.GetMateriaNoAsignada(IdAlumnoMateria: IdAlumnoMateria, reponse: { result, error in
            if let resultSourece = result{
                for objmateria in resultSourece.Objects!{
                    let materia = objmateria
                    self.materias.append(materia)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    @IBAction func btnEnviar(_ sender: Any) {
        var alumnomateria = AlumnoMateria()
        
        
        materiasSelect = []
        
        for mate in materias{
            alumnomateria.Alumno?.IdAlumno = IdAlumnoMateria
            alumnomateria.Materia?.IdMateria = IdMateria
            AlumnoMateriaViewModel.AddMateria(IdAlumno: IdAlumnoMateria, IdMateria: IdMateria, reponse: {result, error in
                self.materiasSelect.append(mate)
                if let resultSource = result{
                    print("se add materias")
//                    for addmateria in resultSource.Objects!{
//                        var materia = addmateria
//
//                    }
                    self.updateUI()
                }
                
            })
        }
    }
    
    
    
}

extension MateriasNoAsigndasController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materias.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MateriasNoAsignadasCell", for: indexPath) as! MateriasNoAsignadasCell
        cell.lblMateria.text = materias[indexPath.row].Materia?.Nombre
        cell.lblCosto.text = "$ \(materias[indexPath.row].Materia!.Costo.description)"
        cell.btnCheck.tag = indexPath.row
        cell.btnCheck.setImage(UIImage.init(named: "uncheck"), for: .normal)
        cell.btnCheck.setImage(UIImage.init(named: "check"), for: .selected)
        cell.btnCheck.addTarget(self, action: #selector(chec(sender: )), for: .touchUpInside)
        
        let selectMateria = materiasSelect.first{
            $0.Materia!.IdMateria == materias[indexPath.row].Materia!.IdMateria
        }
        if selectMateria != nil{
            cell.btnCheck.isSelected = true
        }else{
            cell.btnCheck.isSelected = false
        }
        
        return cell
    }
    
    @objc func chec(sender: UIButton){
        sender.isSelected = !sender.isSelected
        
        print((materias[sender.tag].Materia?.Nombre)!)
        print((materias[sender.tag].Materia?.IdMateria)!)

        let selecmateria = materias[sender.tag]
        var isExist = false
        for i in 0..<materiasSelect.count{
            let materi = materiasSelect[i]
            if materi.Materia!.IdMateria == selecmateria.Materia!.IdMateria{
                isExist = true
                materiasSelect.remove(at: i)
            }
        }
        if !isExist{
            materiasSelect.append(selecmateria)
        }
        tableView.reloadData()
    }

}
