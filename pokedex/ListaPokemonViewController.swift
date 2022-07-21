//
//  ViewController.swift
//  pokedex
//
//  Created by Valeria Muñoz toro on 21-07-22.
//

import UIKit

class ListaPokemonViewController: UIViewController {

        //iBoutlets
    @IBOutlet weak var tablaPokemon: UITableView!
    
    
    @IBOutlet weak var searchBarPokemon: UISearchBar!

    //variables
    var pokemonManager = PokemonManager()
    
    var pokemons: [Pokemon] = []
    
    var pokemonSeleccionado: Pokemon?
    
    var pokemonFiltrados: [Pokemon] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //registrar nueva celda
        
        tablaPokemon.register(UINib(nibName:"CeldaPokemonTableViewCell",bundle: nil),
                                    forCellReuseIdentifier: "celda")
        
        pokemonManager.delegado = self
        
        searchBarPokemon.delegate = self
        tablaPokemon.delegate = self
        tablaPokemon.dataSource = self
        
        //ejecutar busqueda
        pokemonManager.verPokemon()
        pokemonFiltrados = pokemons
        
    }


}

//SEARCH BAR

extension ListaPokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pokemonFiltrados = []
        if searchText == "" {
            pokemonFiltrados = pokemons}
        else {
            for poke in pokemons {
                if poke.name.lowercased().contains(searchText.lowercased()){
                    pokemonFiltrados.append(poke)
                }
            }
        }
        self.tablaPokemon.reloadData()
    }
}
//delegado
extension ListaPokemonViewController: pokemonManagerDelegado{
    
    func mostrarListaPokemon(lista: [Pokemon]) {
        pokemons = lista
        
        DispatchQueue.main.async {
            self.pokemonFiltrados = self.pokemons
            self.tablaPokemon.reloadData()
        }
        
    }
}
//table
extension ListaPokemonViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonFiltrados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaPokemon.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as!
        CeldaPokemonTableViewCell
        
        celda.nombrePokemon.text = pokemonFiltrados[indexPath.row].name
        celda.ataquePokemon.text = "Ataque: \(pokemonFiltrados[indexPath.row].attack)"
        celda.defensaPokemon.text = "Defensa: \(pokemonFiltrados[indexPath.row].defense)"
        
      
        //celda imagen desde url
        if let urlString = pokemonFiltrados[indexPath.row].imageUrl as? String{
            if let imagenURL = URL(string: urlString) {
                DispatchQueue.global().async{
                    guard let imagenData = try? Data(contentsOf: imagenURL) else {
                        return
                    }
                    let image = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        celda.imagenPokemon.image = image
                    }
                }
            }
        }
        
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemonSeleccionado = pokemonFiltrados[indexPath.row]
        
        performSegue(withIdentifier: "verPokemon", sender: self)
        
        tablaPokemon.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verPokemon" {
            let verPokemon = segue.destination as! DetallePokemonViewController
            verPokemon.pokemonMostrar = pokemonSeleccionado
        }
    }
}
