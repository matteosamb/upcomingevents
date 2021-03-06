//
//  TableViewController.swift
//  CitySounds
//
//  Created by Scott on 2/8/20.
//  Copyright © 2020 RiptidaL. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var eventList: UITableView!
    
    //Placeholder for an Array of "Event" objects
    var eventArray = [Event]()
    var ref = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventList.delegate = self
        eventList.dataSource = self
        
        retrieveDatafromFirebase()
        
        
        
       
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        eventList.rowHeight = 100
        let cell = eventList.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.eventNameCellLabel.text = eventArray[indexPath.row].name
        cell.eventLocationCellLabel.text = eventArray[indexPath.row].location
        return cell
    }
    
    
    func retrieveDatafromFirebase() {
        
        //Function from the Firebase Docs - "snapshot" is a variable that contains the returned value of what is in the database under the "upcoming" node
        ref.child("upcoming").observe(.childAdded) { (snapshot) in
            
            //Converting the returned value to a dictionary so that we can access specific values
            let data = snapshot.value as? NSDictionary
            
            //Creating an object of the "Event" class
            let reference = Event()
            
            //Access Name and Location of the returned dictionary value 
            reference.name = data!["Name"] as! String
            reference.location = data!["Location"] as! String
            self.eventArray.append(reference)
            self.eventList.reloadData()
            
        }
    }
    
    



}

