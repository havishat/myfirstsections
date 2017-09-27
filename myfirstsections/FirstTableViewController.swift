//
//  FirstTableViewController.swift
//  myfirstsections
//
//  Created by havisha tiruvuri on 9/25/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit
import CoreData

class FirstTableViewController: UITableViewController, additemDelegate{
    
    var list = [Mysections] ()
    
    var list2 = [Mysections] ()
    
    //MOC
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
// adding to database
    func fetchFalse() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Mysections")
        request.predicate = NSPredicate(format: "fav == %@", false as CVarArg)
        do {
            let result = try managedObjectContext.fetch(request)
            list = result as! [Mysections]
        } catch {
            print("\(error)")
        }
        
    }
    
    func fetchTrue() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Mysections")
        request.predicate = NSPredicate(format: "fav == %@", true as CVarArg)
        do {
            let result = try managedObjectContext.fetch(request)
            list2 = result as! [Mysections]
        } catch {
            print("\(error)")
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
          return  list.count
        } else{
            return list2.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "section 1"
        } else {
            return "section 2"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! FirstTableViewCell
            cell.textLabel?.text = list[indexPath.row].quotes
            cell.detailTextLabel?.text = list[indexPath.row].author
            cell.DateLabel.text = list[indexPath.row].date
            
      //  cell.DateLabel?.text = list[indexPath.row].date
//        if list[indexPath.row].checklist == false {
//            cell.accessoryType = UITableViewCellAccessoryType.none
//        } else {
//            cell.accessoryType = UITableViewCellAccessoryType.checkmark
//        }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! FirstTableViewCell
            cell.textLabel?.text = list2[indexPath.row].quotes
            cell.detailTextLabel?.text = list2[indexPath.row].author
            cell.DateLabel.text = list2[indexPath.row].date
            return cell
        }
    
    }
    
    // tableview add
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "additem", sender: sender)
    }
    
    //    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath:IndexPath) {
    //
    //        performSegue(withIdentifier: "additem", sender: indexPath)
    //
    //    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let y = list[indexPath.row]
            y.fav = true
            do {
                try managedObjectContext.save()
            } catch {
                print("\(error)")
            }
            list.remove(at: indexPath.row)
            
        } else {
            let y = list2[indexPath.row]
            y.fav = false
            do {
                try managedObjectContext.save()
            } catch {
                print("\(error)")
            }
            list2.remove(at: indexPath.row)
            
        }
        fetchTrue()
        fetchFalse()
         tableView.reloadData()
    }
    
    func itemSaved(by: additemViewController, quote: String, author: String, date: String, indexPath: NSIndexPath?) {

        let item = NSEntityDescription.insertNewObject(forEntityName: "Mysections", into: managedObjectContext) as! Mysections
        item.author = author
        item.date = date
        item.quotes = quote
        print(item)
        item.fav = false
        list.append(item)
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        fetchFalse()
        fetchTrue()
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonPressed(by: additemViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "additem" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! additemViewController
            controller.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFalse()
        fetchTrue()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
