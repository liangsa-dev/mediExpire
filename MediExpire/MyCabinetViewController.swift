//
//  ViewController.swift
//  Medexpire
//
//  Created by Sabrina Liang on 25/12/20.
//

import UIKit

class MyCabinetViewController: UITableViewController {
    
    var medicineCollection = [Medicine]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        print(medicineCollection.count)
    }
    
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
    
    func formatToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
    
    func loadData() {
        let vc = AddMedicineViewController()
        if let data = try? Data(contentsOf: vc.dataFilePath!) {
            let decoder = PropertyListDecoder()
//            print(vc.dataFilePath)
            do {
                self.medicineCollection = try decoder.decode([Medicine].self, from: data)
            } catch {
                print("Error decoding")
        
            }
        }
    }
    
}
