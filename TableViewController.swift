import UIKit

class TableViewController: UITableViewController {
    
    var misAutos = [
        ("Honda Civic", "Anio 2014 Motor 2.5L", "Img1"),
        ("Toyota Corolla", "Anio 2016 Motor 1.8L", "Img2"),
        ("Mazda 3", "Anio 2015 Motor 2.0L", "Img3"),
        ("Nissan Sentra", "Anio 2017 Motor 1.6L", "Img4"),
        ("Ford Focus", "Anio 2013 Motor 2.0L", "Img5"),
        ("Chevrolet Cruze", "Anio 2018 Motor 1.4L", "Img6"),
        ("Hyundai Elantra", "Anio 2019 Motor 2.0L", "Img7"),
        ("Volkswagen Jetta", "Anio 2014 Motor 1.8L", "Img8"),
        ("Kia Forte", "Anio 2020 Motor 2.0L", "Img9"),
        ("Subaru Impreza", "Anio 2015 Motor 2.0L", "Img10")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isEditing = true
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        setEditing(true, animated: true)
    }

    // Número de filas
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return misAutos.count
    }

    // Configurar celda
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = misAutos[indexPath.row].0
        cell.detailTextLabel?.text = misAutos[indexPath.row].1
        cell.imageView?.image = UIImage(named: misAutos[indexPath.row].2)
        
        // Establecer el tamaño fijo de la imagen
        let imageSize = CGSize(width: 95, height: 95)
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        cell.imageView?.image?.draw(in: CGRect(origin: CGPoint.zero, size: imageSize))
        cell.imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return cell
    }

    // Permitir edición de filas
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Eliminar e insertar filas
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            misAutos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            let nuevoAuto = ("Nuevo Auto", "Descripción", "Imagen")
            misAutos.insert(nuevoAuto, at: indexPath.row)
            tableView.insertRows(at: [indexPath], with: .fade)
        }
    }

    // Mover filas
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedAuto = misAutos.remove(at: fromIndexPath.row)
        misAutos.insert(movedAuto, at: to.row)
    }

    // Permitir mover filas
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Configuración del botón de editar
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if self.isEditing {
            self.editButtonItem.title = "Hecho"
        } else {
            self.editButtonItem.title = "Editar"
        }
    }

    // Acciones personalizadas al deslizar
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let eliminar = UITableViewRowAction(style: .destructive, title: "Eliminar") { (action, indexPath) in
            self.misAutos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        eliminar.backgroundColor = UIColor.red

        let insertar = UITableViewRowAction(style: .normal, title: "Insertar") { (action, indexPath) in
            let nuevoAuto = ("Nuevo Auto", "Descripción", "Default")
            self.misAutos.append(nuevoAuto)
            tableView.reloadData()
        }
        insertar.backgroundColor = UIColor.green

        let verMas = UITableViewRowAction(style: .normal, title: "Ver Más") { (action, indexPath) in
            self.performSegue(withIdentifier: "showDetail", sender: indexPath)
        }
        verMas.backgroundColor = UIColor.blue

        return [eliminar, insertar, verMas]
    }

    // Preparar datos para el viewController de detalle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detalleVC = segue.destination as! DetalleAutoViewController
            if let indexPath = sender as? IndexPath {
                let auto = misAutos[indexPath.row]
                detalleVC.nombreAuto = auto.0
                detalleVC.descripcionAuto = auto.1
                detalleVC.imagenAuto = auto.2
            }
        }
    }
}
