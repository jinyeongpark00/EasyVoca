//
//  NewMemorableTableViewController.swift
//  VocaLearning
//
//  Created by Paige 🇰🇷 on 20/5/2023.
//

import Foundation
import UIKit
import os.log

class NewMemorableTableViewController: UITableViewController {
    
    var memorables:[Memorable] = []
    var memorable: Memorable = Memorable(id: -1, head: "", body: "", category: "")

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == "MemorableUnwind" {
            let memorableTableViewController = segue.destination as! MemorableTableViewController
            memorableTableViewController.memorables.insert(self.memorable, at: 0)
        }
    }
    
    func alert(title: String, message: String, dismissButtonText: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let dismissAction = UIAlertAction(title: dismissButtonText,style: UIAlertAction.Style.default) {
            (action) -> Void in
            self.performSegue(withIdentifier: "MemorableUnwind", sender: self)
        }
        alertController.addAction(dismissAction)
        // alertController.addAction(UIAlertAction(title: dismissButtonText, style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        guard let head = self.titleTextField.text else { return }
        guard let body = self.descriptionTextField.text else { return }
        
        wrapper: while true {
            var found = false
            let newId = Int(drand48() * 1000000)
            inner: for singleMemorable in self.memorables {
                if singleMemorable.id == newId {
                    found = true
                    break inner
                }
            }
            if !found {
                self.memorable.id = newId
                break wrapper
            }
        }
    
        self.memorable.head = head
        self.memorable.body = body
        self.alert(title: "Saving New Memorable", message: "Success!", dismissButtonText: "Confirm")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("New Momorable for '\(self.memorable.category)'")
    }

}
