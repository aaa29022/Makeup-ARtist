//
//  EyeshadowCell.swift
//  MPFinal
//
//  Created by 陳映紅 on 2018/6/7.
//  Copyright © 2018年 陳映紅. All rights reserved.
//

import UIKit

class EyeshadowCell: UITableViewCell {
    @IBOutlet weak var eyeshadowImage: UIImageView!
    @IBOutlet weak var eyeshadowTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
