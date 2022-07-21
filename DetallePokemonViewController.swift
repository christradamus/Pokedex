//
//  DetallePokemonViewController.swift
//  pokedex
//
//  Created by Valeria Muñoz toro on 21-07-22.
//

import UIKit

class DetallePokemonViewController: UIViewController {
    
    //variables
    var pokemonMostrar : Pokemon?
    //outlets
    
    
    @IBOutlet weak var imagenPokemon: UIImageView!
    
    @IBOutlet weak var descripcionPokemon: UITextView!
    
    
    @IBOutlet weak var tipoPokemon: UILabel!
    
    @IBOutlet weak var ataquePokemon: UILabel!
    
    @IBOutlet weak var defensaPokemon: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //imagen a mostrar
        imagenPokemon.loadFrom(URLAddres: pokemonMostrar?.imageUrl ?? "")
  
        tipoPokemon.text = "Tipo: \(pokemonMostrar?.type ?? "")"
        ataquePokemon.text = "Ataque: \(pokemonMostrar!.attack)"
        defensaPokemon.text = "Defensa: \(pokemonMostrar!.defense)"
        descripcionPokemon.text =  pokemonMostrar?.description ?? ""
        
    }

}
extension UIImageView {
    func loadFrom(URLAddres: String){
        guard let url = URL(string: URLAddres) else { return }
        
        DispatchQueue.main.async { [weak self] in
            if let imagenData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imagenData) {
                    self?.image = loadedImage
                }
            }
        }
    }
}
