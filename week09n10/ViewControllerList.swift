//
//  ViewControllerList.swift
//  FirebaseHelloWorld
//
//  Created by Mathias Møller Feldt on 06/03/2020.
//  Copyright © 2020 Mathias Møller. All rights reserved.
//

import UIKit

class ViewControllerList: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
           super.viewDidLoad()
        
        tableView.delegate = self //handle events for the tableview
        tableView.dataSource = self //handles data for the tableview
        CloudStorage.listener(tableview: tableView)
           // Do any additional setup after loading the view.
       }
    
    @IBAction func btnpressed(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CloudStorage.getSize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        cell?.textLabel?.text = CloudStorage.getNoteAt(index: indexPath.row).head
        return cell!
    }
    
    
    //Prepare data for the next view (viewControllerImage)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ViewControllerImage {
            destination.rowNumber = tableView.indexPathForSelectedRow!.row
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(CloudStorage.getNoteAt(index: indexPath.row).head)
        performSegue(withIdentifier: "segue1", sender: self)
    }
    
    //Delete row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let id = CloudStorage.list[indexPath.row].id
            CloudStorage.deleteNote(index: indexPath.row , id: id)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            tableView.reloadData()
        }
    }
    

   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
