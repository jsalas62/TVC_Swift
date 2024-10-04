import UIKit

class DetalleAutoViewController: UIViewController {
    
    
    
    @IBOutlet weak var autoImageView: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    
    var nombreAuto: String?
    var descripcionAuto: String?
    var imagenAuto: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        tituloLabel.text = nombreAuto
        descripcionLabel.text = descripcionAuto
        if let imagen = imagenAuto {
            autoImageView.image = UIImage(named: imagen)
        }
    }
}
