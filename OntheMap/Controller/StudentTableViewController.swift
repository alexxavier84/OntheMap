//
//  StudentTableViewController.swift
//  OntheMap
//
//  Created by Apple on 17/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class StudentTableViewController: UIViewController {

    @IBOutlet weak var studentTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        ParseClient.sharedInstance().getStudentsLocationList { (error) in
            UIViewController.removeSpinner(spinner: sv)
            if SharedData.shared.students.count > 0 {
                performUIUpdateOnMain {
                    self.studentTableView.delegate = self
                    self.studentTableView.dataSource = self
                    self.studentTableView.reloadData()
                }
            }else{
                print(String(describing: error) ?? "No student data")
            }
            
        }
    }


    
 

}

extension StudentTableViewController : UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SharedData.shared.students.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        let cellReuseIdentifier = "StudentTableViewCell"
        let student = SharedData.shared.students[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        cell?.textLabel?.text = "\(student.studentInformation.firstName ?? "None") \(student.studentInformation.lastName ?? "")"
        cell?.detailTextLabel?.text = "\(student.studentInformation.mediaURL ?? "")"
        cell?.imageView?.image = UIImage(named: "icon_pin")
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = SharedData.shared.students[(indexPath as NSIndexPath).row]
        var options = [String: Any]()
        if let mediaUrl = student.studentInformation.mediaURL, mediaUrl != "" {
            UIApplication.shared.open(URL(string: mediaUrl)!, options: options) { (status) in
                
            }
        }
        
    }
}

