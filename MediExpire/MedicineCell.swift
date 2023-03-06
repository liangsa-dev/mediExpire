//
//  MedicineCell.swift
//  Medexpire
//
//  Created by Sabrina Liang on 11/7/21.
//

import UIKit

class MedicineCell: UITableViewCell {

    @IBOutlet weak var medicineNameLabel: UILabel!
    @IBOutlet weak var expiryDateLabel: UILabel!
    
    func setMedicineCell(medicineCollection: Medicine) {
        medicineNameLabel.text = medicineCollection.name
        expiryDateLabel.text = DateFormatter().string(from: medicineCollection.expiryDate)
    }
}
