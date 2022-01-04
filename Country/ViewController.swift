//
//  ViewController.swift
//  Country
//
//  Created by Евгений Григоренко on 28.12.21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var myTable: UITableView!
    var countryArray = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        table()
        self.view.addSubview(myTable)
        
        readJSON {
            self.myTable.reloadData()
        }
    }
    
    func table(){
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let height = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        myTable = UITableView(frame: CGRect(x: 0, y: height, width: displayWidth, height: displayHeight - height))
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTable.rowHeight = 50
        myTable.dataSource = self
        myTable.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTable.deselectRow(at: indexPath, animated: true)
        let webVC = WikiVC()
        webVC.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit", style: .done, target: self, action: #selector(dismis))
        let nameCountry = countryArray[indexPath.row].name.common
        webVC.title = nameCountry
        let encodedCountry = nameCountry.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        webVC.search = "https://en.wikipedia.org/wiki/\(encodedCountry!)"
        let navigation = UINavigationController(rootViewController: webVC)
        present(navigation, animated: true)
    }
    
    @objc func dismis() {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        let flagCountry = countryArray[indexPath.row].flag?.capitalized
        let nameCountry = countryArray[indexPath.row].name.common.capitalized
        cell.textLabel?.text = "\(flagCountry ?? "🇧🇶")  \(nameCountry)"
        return cell
    }
    
    func readJSON(completed: @escaping () -> ()){
        let urlString = "https://restcountries.com/v3.1/all"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do{
                self.countryArray = try JSONDecoder().decode([Country].self, from: data)
                self.countryArray.sort(by: { $0.name.common < $1.name.common})
                DispatchQueue.main.async {
                    completed()
                }
            } catch let error {
                print(error)
            }
        }).resume()
    }
}
