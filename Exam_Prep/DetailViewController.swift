//
//  DetailViewController.swift
//  Exam_Prep
//
//  Created by Veniamin Shandrovskiy on 09.06.2021.
//

import UIKit


class DetailViewController: UIViewController {
    
    var currentIndex = 0
    var parent_view_controller: ViewController? = nil
    
    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextView.text = FS.notes[currentIndex].text

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("leaving detailView")
        //parent_view_controller?.items[currentIndex] = noteTextView.text
        //parent_view_controller?.tableView.reloadData()
    }

}
