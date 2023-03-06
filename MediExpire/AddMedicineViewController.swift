//
//  ViewController.swift
//  Medexpire
//
//  Created by Sabrina Liang on 25/12/20.
//

import UIKit

class AddMedicineViewController: UIViewController {
     
    @IBOutlet weak var medicineNameTextField: UITextField!
    
    @IBOutlet weak var expiryDateTextField: UITextField!
    
    let datePicker = UIDatePicker()
    
    let medicineCollection = MyCabinetViewController().medicineCollection
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("medicineCollection.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        dismiss(animated: true)
    }
    
    
    func createDatePicker() {
        
        expiryDateTextField.textAlignment = .center
        
        // create a toolbar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        // create a done buttom
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([doneButton], animated: true)
        
        // assign to the toolbar
        expiryDateTextField.inputAccessoryView = toolBar
        
        // assign the datepicker to textfiled
        expiryDateTextField.inputView = datePicker
        
        // date pciket mode
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.sizeToFit()
    }
    
    @objc func donePressed() {
        // formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        expiryDateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    @IBAction func addToMyCabinetButtonPressed(sender: UIButton) {
        if let nameText = medicineNameTextField.text {
            // create instance here so you can store the data
            let newMedicine = Medicine(name: nameText, expiryDate: datePicker.date)
            // add it to array
            let navController = presentingViewController as! UINavigationController
            let myCabinetVC = navController.topViewController as! MyCabinetViewController
            myCabinetVC.medicineCollection.append(newMedicine)
            myCabinetVC.tableView.reloadData()
            saveData()
            print(medicineCollection.count)
        }
        print(medicineCollection.count)
       
        dismiss(animated: true, completion: nil)
    }

    @IBAction func Dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveData() {
        print(medicineCollection)
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(medicineCollection)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding")
        }
        print(medicineCollection)
    }
    
}
    

