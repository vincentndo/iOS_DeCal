//
//  CategoryViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var pokemonName: UILabel!
    
    @IBOutlet weak var pokemonStats: UILabel!
    
    @IBOutlet weak var pokemonNumber: UILabel!
    
}

class CategoryViewController: UIViewController {
    
    var pokemonArray: [Pokemon]?
    var cachedImages: [Int:UIImage] = [:]
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func selectPokemon(_ indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        performSegue(withIdentifier: "categoryToPokemonInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "categoryToPokemonInfo", let dest = segue.destination as? PokemonInfoViewController {
            let pokemon = self.pokemonArray![self.selectedIndexPath!.row]
            dest.pokemon = pokemon
        }
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonCell {
            
            let pokemon = pokemonArray![indexPath.row]
            
            cell.pokemonName.text = pokemon.name
            cell.pokemonStats.text = String(pokemon.defense) + "/" + String(pokemon.attack) + "/" + String(pokemon.health)
            cell.pokemonNumber.text = "#" + String(pokemon.number)
            
            if let image = cachedImages[indexPath.row] {
                cell.pokemonImage.image = image
            } else {
                cell.pokemonImage.image = nil
                let url = URL(string: pokemon.imageUrl)!
                let session = URLSession(configuration: .default)
                let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                    if let e = error {
                        print("Error downloading picture: \(e)")
                    } else {
                        if let _ = response as? HTTPURLResponse {
                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                DispatchQueue.main.async {
                                    self.cachedImages[indexPath.row] = image
                                    cell.pokemonImage.image = image // UIImage(data: imageData)
                                }
                            } else {
                                print("Couldn't get image: Image is nil")
                            }
                        } else {
                            print("Couldn't get response code")
                        }
                    }
                }
                downloadPicTask.resume()
            }
            return cell
            
        } else {
            return PokemonCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectPokemon(indexPath)
    }
}
