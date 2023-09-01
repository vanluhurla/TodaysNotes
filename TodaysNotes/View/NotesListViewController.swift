//
//  NotesListViewController.swift
//  TodaysNotes
//
//  Created by Vanessa Hurla on 09/05/2022.
//

import UIKit

class NotesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let noteManager = NoteManager()
    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        evaluateNotes()
    }
    
    @IBAction func didTapCreateButton(_ sender: Any) {
        presentNoteDetails(note: nil)
    }

    func presentNoteDetails(note: Note?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "NoteDetailsViewController") as? NoteDetailsViewController else {
            return
        }
        viewController.selectedNote = note
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setupTableView() {
        let noteCellNib = UINib(nibName: "NoteCell", bundle: nil)
        tableView.register(noteCellNib, forCellReuseIdentifier: "ReusableNoteCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func evaluateNotes() {
        notes = noteManager.retrieveNote()
        tableView.reloadData()
    }
    
    func deleteNote(note: Note) {
        noteManager.deleteNote(note: note)
        evaluateNotes()
    }
}

extension NotesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableNoteCell", for: indexPath) as? NoteCell else {
            return UITableViewCell()
        }
        cell.setup(note: notes[indexPath.row])
        return cell
    }
}

extension NotesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        presentNoteDetails(note: note)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let note = notes[indexPath.row]
            deleteNote(note: note)
        }
    }
}
