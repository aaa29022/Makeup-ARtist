//
//  HomePage.swift
//  MPFinal
//
//  Created by 陳映紅 on 2018/6/7.
//  Copyright © 2018年 陳映紅. All rights reserved.
//

import UIKit

class HomePage: UIViewController {

    @IBOutlet weak var eyebrowButton: UIButton!
    @IBOutlet weak var eyeshadowButton: UIButton!
    
    let screenSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eyebrowButton.setImage(UIImage(named: "eyebrow"), for: UIControlState.normal)
        eyebrowButton.imageView?.contentMode = .scaleAspectFit
        
        eyeshadowButton.setImage(UIImage(named: "eyeshadow"), for: UIControlState.normal)
        eyeshadowButton.imageView?.contentMode = .scaleAspectFit

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEyebrow" {
            let viewController = segue.destination as! ViewController
            viewController.id = 0
        }
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
