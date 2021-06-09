//
//  FirebaseService.swift
//  Exam_Prep
//
//  Created by Veniamin Shandrovskiy on 09.06.2021.
//

import Foundation
import Firebase

class FirebaseService {
    private var db = Firestore.firestore()
    var notes = [Note]()
    var parent:Updatable?
    
    func addNote(text:String){
        print("add note with text \(text)")
            if text.count > 0 {
                let doc = db.collection("notes").document()
                var data = [String:String]()
                data["text"] = text
                doc.setData(data)
            }

    }
    
    func startListener() {
        db.collection("notes").addSnapshotListener { (snap, error) in
            if let e = error {
                print("error fetching data \(e)")
            }else {
                if let s = snap {
                    self.notes.removeAll()
                    for doc in s.documents {
                        if let text = doc.data()["text"] as? String{
                            print(doc.data()["text"] as! String)
                            print(doc.documentID)
                            let note = Note(id: doc.documentID, text: text)
                            self.notes.append(note )
                        }
                        
                    }
                    self.parent?.update()
                }
            }
        }
    }
    
    

    func deleteNote(index:Int){
        if index < notes.count {
            let docID = notes[index].id
            db.collection("notes").document(docID).delete() { err in
                if let e = err {
                    print("Error deleting \(e)")
                }else {
                    print("ok deleting \(docID)")
                }
            }
            notes.remove(at: index)
        }
    }
}
