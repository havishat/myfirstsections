//
//  ViewController.swift
//  myfirstsections
//
//  Created by havisha tiruvuri on 9/25/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit

class additemViewController: UIViewController {
    
    weak var delegate: additemDelegate?
    var item: String?
    var itemDate = Date()
    var indexPath: NSIndexPath?
    
    @IBOutlet weak var quotes: UITextField!
    
    @IBOutlet weak var author: UITextField!
    
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        let myDate = dateDatePicker.date
        //  print(myDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: myDate)
    
        delegate?.itemSaved(by: self, quote: quotes.text!,author: author.text!, date: dateString, indexPath: indexPath)
        dismiss(animated: true, completion: nil )
    }
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

