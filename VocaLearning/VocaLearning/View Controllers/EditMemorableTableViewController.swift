//
//  EditMemorableTableViewController.swift
//  VocaLearning
//
//  Created by Paige 🇰🇷 on 20/5/2023.
//

import Foundation

import UIKit

class EditMemorableTableViewController: UITableViewController {
    
    var memorables: [Memorable] = []
    var memorable = Memorable(id: -1, head: "", body: "", category: "")
    
    func alert(title: String, message: String, dismissButtonText: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let dismissAction = UIAlertAction(title: dismissButtonText,style: UIAlertAction.Style.default) {
            (action) -> Void in
            self.performSegue(withIdentifier: "unwindFromEditMemorable", sender: self)
        }
        alertController.addAction(dismissAction)
        // alertController.addAction(UIAlertAction(title: dismissButtonText, style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == "unwindFromEditMemorable" {
            let memorableTableViewController = segue.destination as! MemorableTableViewController
            // memorableTableViewController.memorables.insert(self.memorable, at: 0)
            memorableTableViewController.editingMemorable = self.memorable
        }
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        if let head = self.titleTextField.text {
            self.memorable.head = head
        }
        if let body = self.descriptionTextField.text {
            self.memorable.body = body
        }
        self.alert(title: "Editing Memorable", message: "Success!", dismissButtonText: "Dismiss")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleTextField.text = self.memorable.head
        self.descriptionTextField.text = self.memorable.body
    }

}
