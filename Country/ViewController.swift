//
//  ViewController.swift
//  Country
//
//  Created by Евгений Григоренко on 28.12.21.
//

import UIKit

class ViewController: UIViewController {
    
    var JSON = ReadJSON()
    
    var tableVW: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableVW)
        constraintTable()
        JSON.readJSON { self.tableVW.reloadData()} 
    }
    

    func constraintTable(){
        NSLayoutConstraint.activate([
            tableVW.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableVW.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableVW.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableVW.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        tableVW.register(UINib(nibName: "CastomViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableVW.estimatedRowHeight = 44
        tableVW.dataSource = self
        tableVW.delegate = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let webVC = WikiVC()
        let nameCountry = JSON.countryArray[indexPath.row].name.common
            webVC.title = nameCountry
        let encodedCountry = nameCountry.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            webVC.search = "https://en.wikipedia.org/wiki/\(encodedCountry!)"
        let navigation = UINavigationController(rootViewController: webVC)
        present(navigation, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JSON.countryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CastomViewCell
        cell.tag = indexPath.row
        let nameCountry = JSON.countryArray[indexPath.row].name.common.capitalized
        let flagImage = JSON.countryArray[indexPath.row].flags.png
        let url = URL(string: flagImage)
        if let url = url {
            if(cell.tag == indexPath.row) {
                cell.imageCountryView.loadImage(fromURL: url)
            }
        }
        cell.countryLabel.text = nameCountry
        return cell
    }

}

