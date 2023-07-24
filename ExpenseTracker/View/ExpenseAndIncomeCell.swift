//
//  ExpenseAndIncomeCell.swift
//  ExpenseTracker
//
//  Created by Ebuzer Şimşek on 20.07.2023.
//

import UIKit

class ExpenseAndIncomeCell: UITableViewCell {

    @IBOutlet weak var ExpenseTypeImage: UIImageView!
    @IBOutlet weak var ExpenseType: UILabel!
    @IBOutlet weak var ExpenseDetail: UILabel!
    @IBOutlet weak var ExpenseAmount: UILabel!
    @IBOutlet weak var ExpenseTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
