//
//  FormularioAlumnoController.swift
//  JArroyoControlEscolar
//
//  Created by MacBookMBP1 on 06/06/23.
//

import UIKit

class FormularioAlumnoController: UIViewController {

    var IdAlumno = 0
    
    @IBOutlet weak var txtIdAlumno: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellidoPaterno: UITextField!
    @IBOutlet weak var txtApellidoMaterno: UITextField!
    @IBOutlet weak var FechaNacimiento: UITextField!
    @IBOutlet weak var txtGenero: UITextField!
    @IBOutlet weak var txtTelefono: UITextField!
    @IBOutlet weak var btnAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtIdAlumno.isEnabled = false
        
        
        if IdAlumno == 0{
            var alumno = Alumno()
            
            self.txtIdAlumno.text = ""
            self.txtNombre.text = ""
            self.txtApellidoPaterno.text = ""
            self.txtApellidoMaterno.text = ""
            self.FechaNacimiento.text = ""
            self.txtGenero.text = ""
            self.txtTelefono.text = ""
            
            btnAction.backgroundColor = .green
            btnAction.setTitle("Agregar", for: .normal)

        }else {
            
                AlumnoViewModel.GetById(IdAlumno: self.IdAlumno, reponse: {result, error in
                    if ((result?.Correct) != nil){
                        let alumno = result?.Object as! Alumno
                        DispatchQueue.main.async {
                            self.txtIdAlumno.text = "\(alumno.IdAlumno)"
                            self.txtNombre.text = "\(alumno.Nombre)"
                            self.txtApellidoPaterno.text = "\(alumno.ApellidoPaterno)"
                            self.txtApellidoMaterno.text = "\(alumno.ApellidoMaterno)"
                            self.FechaNacimiento.text = "\(alumno.FechaNacimiento)"
                            self.txtGenero.text = "\(alumno.Genero)"
                            self.txtTelefono.text = "\(alumno.Telefono)"
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
            var alumno = Alumno()
            
            alumno.Nombre = txtNombre.text!
            alumno.ApellidoPaterno = txtApellidoPaterno.text!
            alumno.ApellidoMaterno = txtApellidoMaterno.text!
            alumno.FechaNacimiento = FechaNacimiento.text!
            alumno.Genero = txtGenero.text!
            alumno.Telefono = txtTelefono.text!
            
            let result = AlumnoViewModel.Add(alumno, reponse: {result, error in
                if result!.Correct{
                    let alert = UIAlertController(title: "Mensaje", message: "Alumno Agregado correctamente", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Aceptar", style: .default)
                    alert.addAction(action)
                    //limpiar campos
                    self.txtIdAlumno.text = ""
                    self.txtNombre.text = ""
                    self.txtApellidoPaterno.text = ""
                    self.txtApellidoMaterno.text = ""
                    self.FechaNacimiento.text = ""
                    self.txtGenero.text = ""
                    self.txtTelefono.text = ""
                    
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
            var alumno = Alumno()
            
            alumno.IdAlumno = Int(txtIdAlumno.text!) ?? 0
            alumno.Nombre = txtNombre.text!
            alumno.ApellidoPaterno = txtApellidoPaterno.text!
            alumno.ApellidoMaterno = txtApellidoMaterno.text!
            alumno.FechaNacimiento = FechaNacimiento.text!
            alumno.Genero = txtGenero.text!
            alumno.Telefono = txtTelefono.text!
            
            AlumnoViewModel.Update(alumno, reponse: {result, error in
                if result!.Correct{
                    let alert = UIAlertController(title: "Mensaje", message: "Alumno actualizado correctamente", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Aceptar", style: .default)
                    alert.addAction(action)
                    
                    //limpiar campos
                    self.txtIdAlumno.text = ""
                    self.txtNombre.text = ""
                    self.txtApellidoPaterno.text = ""
                    self.txtApellidoMaterno.text = ""
                    self.FechaNacimiento.text = ""
                    self.txtGenero.text = ""
                    self.txtTelefono.text = ""
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
