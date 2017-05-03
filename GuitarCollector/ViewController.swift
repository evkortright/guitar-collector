//
//  ViewController.swift
//  GuitarCollector
//
//  Created by Enrique V. Kortright on 5/2/17.
//  Copyright © 2017 Enrique V. Kortright. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var guitars : [Guitar] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        do {
            guitars = try context.fetch(Guitar.fetchRequest()) as! [Guitar]
            tableView.reloadData()
            print(guitars)
        } catch {
            print("Error loading guitar CoreData")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guitars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let guitar = guitars[indexPath.row]
        cell.textLabel?.text = guitar.name
        cell.imageView?.image = UIImage(data: guitar.image! as Data)
        return cell
    }
}

