//
//  FormularioMateriaController.swift
//  JArroyoControlEscolar
//
//  Created by MacBookMBP1 on 06/06/23.
//

import UIKit

class FormularioMateriaController: UIViewController {

    var IdMateria = 0
    
    @IBOutlet weak var txtIdMateria: UITextField!
    
    @IBOutlet weak var txtCosto: UITextField!
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var btnAction: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtIdMateria.isEnabled = false
        
        if IdMateria == 0{
            var materia = Materia()
            self.txtIdMateria.text = ""
            self.txtNombre.text = ""
            self.txtCosto.text = ""
            btnAction.backgroundColor = .green
            btnAction.setTitle("Agregar", for: .normal)
        }else{
            MateriaViewModel.GetById(IdMateria: self.IdMateria, reponse: {result, error in
                if ((result?.Correct) != nil){
                    let materia = result?.Object as! Materia
                    DispatchQueue.main.async {
                        self.txtIdMateria.text = "\(materia.IdMateria)"
                        self.txtNombre.text = "\(materia.Nombre)"
                        self.txtCosto.text = "\(materia.Costo)"
                    }
                }
            })
        btnAction.backgroundColor = .orange
        btnAction.setTitle("Actualizar", for: .normal)
        }
        
    }
    
    
    @IBAction func btnEnviar(_ sender: Any) {
        let opcion = btnAction.titleLabel?.text
        switch opcion{
        case "Agregar":
            var materia = Materia()
            
            materia.Nombre = txtNombre.text!
            materia.Costo = Double(txtCosto.text!)!
            
            let result = MateriaViewModel.Add(materia, reponse: {result, error in
                if ((result?.Correct) != nil){
                    let alert = UIAlertController(title: "Mensaje", message: "Materia agregada correctamente correctamente", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Aceptar", style: .default)
                    alert.addAction(action)
                    //limpiar campos
                    self.txtIdMateria.text = ""
                    self.txtNombre.text = ""
                    self.txtCosto.text = ""
                    
                    self.present(alert, animated: true)
                }
                else{
                    let alert = UIAlertController(title: "Mensaje", message: "Por favor llena todos los campos solicitados", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Aceptar", style: .default)
                    alert.addAction(action)
                    
                    self.present(alert, animated: true)
                }
            })
            
            break
        case "Actualizar":
            var materia = Materia()
            
            materia.IdMateria = Int(txtIdMateria.text!) ?? 0
            materia.Nombre = txtNombre.text!
            materia.Costo = Double(txtCosto.text!)!
            
            MateriaViewModel.Update(materia, reponse: {result, error in
                if ((result?.Correct) != nil){
                    let alert = UIAlertController(title: "Mensaje", message: "Materia actualizada correctamente", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Aceptar", style: .default)
                    alert.addAction(action)
                    
                    //limpiar campos
                    self.txtIdMateria.text = ""
                    self.txtNombre.text = ""
                    self.txtCosto.text = ""
                    self.present(alert, animated: true)
                }
                else{
                    let alert = UIAlertController(title: "Mensaje", message: "Por favor llena todos los campos solicitados", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Aceptar", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
            })
            break
        default:
            print("No se realizo nada")
            
        }

        
    }
}
