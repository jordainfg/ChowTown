//
//  DataPickerTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 05/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class DataPickerTableViewCell: UITableViewCell {

    @IBOutlet weak var picker: UIPickerView!
    
     var pickerData: [String] = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        
        pickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10+"]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Reuser identifier
           class func reuseIdentifier() -> String {
               return "DataPickerTableViewCellID"
           }
           
           // Nib name
           class func nibName() -> String {
               return "DataPickerTableViewCell"
           }
    
}

extension DataPickerTableViewCell :UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return pickerData[row]
   }
}
