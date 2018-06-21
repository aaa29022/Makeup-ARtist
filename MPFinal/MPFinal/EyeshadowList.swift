//
//  EyeshadowList.swift
//  MPFinal
//
//  Created by 陳映紅 on 2018/6/7.
//  Copyright © 2018年 陳映紅. All rights reserved.
//

import UIKit

class EyeshadowCell: UITableViewCell {
    @IBOutlet weak var eyeshadowImage: UIImageView!
    @IBOutlet weak var eyeshadowTitle: UILabel!
}

class EyeshadowList: UITableViewController {
    
    let eyeshadowTitle: [String] = ["乾燥玫瑰", "櫻花", "草莓牛奶"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 200
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eyeshadowCell", for: indexPath) as! EyeshadowCell
        let index = indexPath.row
        cell.eyeshadowImage.image = UIImage(named: "eyeshadow" + String(index + 1))
        cell.eyeshadowTitle.text = eyeshadowTitle[index]
        cell.eyeshadowTitle.textAlignment = .center

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEyeshadow" {
            guard let cell = sender as? EyeshadowCell else { fatalError("Must be cell") }
            let indexPath = self.tableView.indexPath(for: cell)!
            
            let viewController = segue.destination as! ViewController
            viewController.id = indexPath.row + 1
        }
    }
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10.0
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
