//
//  Instruction.swift
//  MPFinal
//
//  Created by 陳映紅 on 2018/6/8.
//  Copyright © 2018年 陳映紅. All rights reserved.
//

import UIKit

class Instruction: UIViewController {
    @IBOutlet var stepView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
