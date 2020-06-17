//
//  ViewController.swift
//  MyNotebook
//
//  Created by Mathias Møller Feldt on 14/02/2020.
//  Copyright © 2020 Mathias Møller. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var theText = "";
    var textArray = [String]() //Empty string array
    var currentRowToEdit = -1
    let fileName = "theString.txt"
    
    
    //References to the elements in the storyboard
    @IBOutlet weak var notebookTable: UITableView!
    @IBOutlet weak var textLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textArray.append(readStringFromFile(fileName: fileName))
        
        textArray.append("Hello World!")
        notebookTable.dataSource = self
        notebookTable.delegate = self
        
        notebookTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textLabel.text = "Start writing some notes ;)"
    }
    
    @IBAction func saveText(_ sender: UIButton) {
        theText = textLabel.text
        if currentRowToEdit > -1 {
            textArray[currentRowToEdit] = theText
            currentRowToEdit = -1
        } else {
            textArray.append(theText)
        }
        notebookTable.reloadData()
        textLabel.text = ""
        saveStringToFile(str: theText, fileName: fileName)
        print(readStringFromFile(fileName: fileName))
    
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1"){
        cell.textLabel?.text = textArray[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        currentRowToEdit = indexPath.row
        print(textArray[currentRowToEdit])
        textLabel.text = textArray[currentRowToEdit]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            textArray.remove(at: indexPath.row)
            notebookTable.deleteRows(at: [indexPath], with: .automatic)
            notebookTable.reloadData()
       
        }

    }
    
    func saveStringToFile(str:String, fileName:String){
        let filePath = getDocumentDir().appendingPathComponent(fileName)
        do {
            try str.write(to: filePath, atomically: false, encoding: .utf8)
            print("Succes! file is stored in the file: \(fileName). Filepath: \(filePath)")
        } catch {
            print("Error writing the string to file")
        }
        
    }
    
    func readStringFromFile(fileName:String) -> String{
        let filePath = getDocumentDir().appendingPathComponent(fileName)
        do {
            let stringFromFile = try String(contentsOf: filePath, encoding: .utf8)
            print("String from file: \(stringFromFile)" )
            return stringFromFile
        } catch {
             print("Error reading the string to file")
        }
        return "empty"
    }
    
    func getDocumentDir() -> URL {
        let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return documentDir[0]
    }
}

