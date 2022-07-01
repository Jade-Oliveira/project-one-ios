//
//  ViewController.swift
//  Project1
//
//  Created by Jade Gabriele de Oliveira on 21/06/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        // Do any additional setup after loading the view.
        //aqui o desafio era colocar as imagens em ordem conforme número delas, coloco em ordem depois de acrescentar todos os itens ao array pictures
        pictures.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            vc.selectedPictureNumber = indexPath.row
            vc.totalPictures = pictures.count
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[vc.selectedPictureNumber]

            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

