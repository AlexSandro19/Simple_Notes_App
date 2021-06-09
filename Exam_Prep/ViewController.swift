//
//  ViewController.swift
//  Exam_Prep
//
//  Created by Veniamin Shandrovskiy on 09.06.2021.
//

import UIKit
import Firebase

let FS = FirebaseService()

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, Updatable {

    private var db = Firestore.firestore()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var notes = [String]() // create new string array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FS.parent = self
        FS.startListener()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FS.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create content for one row at a time
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        cell.textLabel?.text = FS.notes[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you clicked \(indexPath.row)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DetailViewController {
            dest.currentIndex = tableView.indexPathForSelectedRow?.row ?? -1
            dest.parent_view_controller = self
        }
        print("prepare is called \(segue.destination.description)")
    }

    
    @IBAction func savePressed(_ sender: UIButton) {
        if let text = textField.text {
            FS.addNote(text: text)
        }
        textField.text = ""
            
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("edit called \(indexPath.row)")
        FS.deleteNote(index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    
    func update() {
        tableView.reloadData()
    }
    
}

