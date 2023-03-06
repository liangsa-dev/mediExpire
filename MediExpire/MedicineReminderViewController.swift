//
//  MyMedicineViewController.swift
//  Medexpire
//
//  Created by Sabrina Liang on 7/4/21.
//

import UIKit

class MedicineReminderViewController: UIViewController {
    var testView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        testView.backgroundColor = .blue
        view.addSubview(testView)
    }
    
    let label = UILabel()
    let html = """
    <html>
    <body>
    <h1>Hello, world!</h1>
    </body>
    </html>
    """
    
//    let data = Data(html.utf8)
//
//    if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
//        label.attributedText = attributedString
//    }
}
