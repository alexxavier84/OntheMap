//
//  StudentTableViewController.swift
//  OntheMap
//
//  Created by Apple on 17/12/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class StudentTableViewController: UIViewController {
    
    var students : [Student] = [Student]()

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
        
        ParseClient.sharedInstance().getStudentsLocationList { (students, error) in
            
            if let students = students {
                self.students = students
                performUIUpdateOnMain {
                    self.studentTableView.delegate = self
                    self.studentTableView.dataSource = self
                    self.studentTableView.reloadData()
                }
            }else{
                print(String(describing: error) ?? "Empty error")
            }
            
        }
    }


    
 

}

extension StudentTableViewController : UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.students.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        let cellReuseIdentifier = "StudentTableViewCell"
        let student = self.students[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        cell?.textLabel?.text = "\(student.firstName ?? "None") \(student.lastName ?? "")"
        cell?.detailTextLabel?.text = "\(student.mediaURL ?? "")"
        cell?.imageView?.image = UIImage(named: "icon_pin")
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = self.students[(indexPath as NSIndexPath).row]
        var options = [String: Any]()
        UIApplication.shared.open(URL(string: student.mediaURL!)!, options: options) { (status) in
            
        }
    }
}

