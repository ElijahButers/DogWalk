//
//  ViewController.swift
//  DogWalk
//
//  Created by User on 9/12/16.
//  Copyright © 2016 Elijah Buters. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentDog: Dog!
    var managedContext: NSManagedObjectContext!
    
    lazy var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let dogEntity = NSEntityDescription.entity(forEntityName: "Dog", in: managedContext)
        
        let dogName = "Fido"
        let dogFetch: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dog")
        dogFetch.predicate = NSPredicate(format: "name == %@", dogName)
        
        do {
            let results = try managedContext.fetch(dogFetch) as! [Dog]
            
            if results.сount > 0 {
                currentDog = results.first
            } else {
                currentDog = Dog(entity: dogEntity!, insertInto: managedContext)
                currentDog.name = dogName
                try managedContext.save()
            }
        } catch let error as NSError {
            print("Error: \(error)" + "description \(error.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return walks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        let date = walks[indexPath.row]
        cell.textLabel?.text = dateFormatter.string(from: date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "List of walks"
    }

    // MARK: - Actions
    
    @IBAction func add(_ sender: AnyObject) {
        
        walks.append(Date())
        tableView.reloadData()
    }
}

