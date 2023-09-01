//
//  NoteDetailsViewController.swift
//  TodaysNotes
//
//  Created by Vanessa Hurla on 11/05/2022.
//

import UIKit

class NoteDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var noteTextView: UITextView!
    
    let noteManager = NoteManager()
    var selectedNote: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        evaluateNote()
        
    }
    
    @IBAction func didTapSaveNote(_ sender: Any) {
        evaluateSave()
        navigationController?.popViewController(animated: true)
    }
    
    func evaluateNote() {
        if let selectedNote = selectedNote {
            titleTextView.text = selectedNote.title
            noteTextView.text = selectedNote.note
        } else {
            titleTextView.text = ""
            noteTextView.text = ""
        }
    }
    
    func evaluateSave() {
        guard let newNote = generateNote() else {
            return
        }
        if let selectedNote = selectedNote {
            replaceNote(oldNote: selectedNote, newNote: newNote)
        } else {
            saveNote(note: newNote)
        }
    }
    
    func saveNote(note: Note) {
        noteManager.saveNote(note: note)
    }
    
    func replaceNote(oldNote: Note, newNote: Note) {
        noteManager.replaceNote(oldNote: oldNote, newNote: newNote)
    }
    
    func generateNote() -> Note? {
        if let title = titleTextView.text, let note = noteTextView.text {
            return Note(title: title, note: note)
        }
        return nil
    }
}
