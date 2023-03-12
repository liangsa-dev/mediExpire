//
//  ViewController.swift
//  Medexpire
//
//  Created by Sabrina Liang on 25/12/20.
//

import UIKit

class MyCabinetViewController: UITableViewController, AddMedicineViewControllerDelegate {
    
    var medicineCollection = [Medicine]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("medicineCollection.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicineCollection.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineCell") as! MedicineCell
        
        let medicineItem = medicineCollection[indexPath.row]
        cell.medicineNameLabel?.text = medicineItem.name
        
        let myDateString = formatToString(date: medicineItem.expiryDate)
        cell.expiryDateLabel?.text = myDateString

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            medicineCollection.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    // MARK: Helpers
    
    func formatToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
    
    // MARK: Data Persistance
    
    func loadData() {
        let vc = AddMedicineViewController()
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                self.medicineCollection = try decoder.decode([Medicine].self, from: data)
            } catch {
                print("Error decoding")
            }
        }
    }
    
    func saveData() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(medicineCollection.self)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding")
        }
        self.tableView.reloadData()
    }
    
    // MARK: AddViewControllerDelegate
    
    func saveNewMedicine(medicine: Medicine) {
        self.medicineCollection.append(medicine)
        saveData()
    }
    
    // MARK: Storyboard Logic
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc2 = segue.destination as? AddMedicineViewController else { return }
        vc2.delegate = self
    }
}
