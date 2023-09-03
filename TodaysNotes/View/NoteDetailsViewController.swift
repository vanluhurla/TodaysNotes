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
    
    var placeholderTitleLabel: UILabel!
    var placeholderNoteLabel: UILabel!
    
    let noteManager = NoteManager()
    var selectedNote: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeholderTitleLabel = UILabel()
        placeholderTitleLabel.text = "Title"
        placeholderTitleLabel.font = .boldSystemFont(ofSize: (titleTextView.font?.pointSize)!)
        placeholderTitleLabel.sizeToFit()
        placeholderTitleLabel.frame.origin = CGPoint(x: 5, y: (titleTextView.font?.pointSize)! / 2)
        placeholderTitleLabel.textColor = .tertiaryLabel
        placeholderTitleLabel.isHidden = !titleTextView.text.isEmpty
        
        placeholderNoteLabel = UILabel()
        placeholderNoteLabel.text = "Note"
        placeholderNoteLabel.font = .systemFont(ofSize: (noteTextView.font?.pointSize)!)
        placeholderNoteLabel.sizeToFit()
        placeholderNoteLabel.frame.origin = CGPoint(x: 5, y: (noteTextView.font?.pointSize)! / 2)
        placeholderNoteLabel.textColor = .tertiaryLabel
        placeholderNoteLabel.isHidden = !noteTextView.text.isEmpty
        
        titleTextView.addSubview(placeholderTitleLabel)
        titleTextView.delegate = self
        titleTextView.layer.borderWidth = 0.2
        titleTextView.layer.cornerRadius = 3.0
        
        noteTextView.addSubview(placeholderNoteLabel)
        noteTextView.delegate = self
        noteTextView.layer.borderWidth = 0.2
        noteTextView.layer.cornerRadius = 3.0
        
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
            placeholderTitleLabel.isHidden = true
            placeholderNoteLabel.isHidden = true
        } else {
            titleTextView.text = ""
            noteTextView.text = ""
            placeholderTitleLabel.isHidden = false
            placeholderNoteLabel.isHidden = false
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

extension NoteDetailsViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderTitleLabel?.isHidden = !titleTextView.text.isEmpty
        placeholderNoteLabel?.isHidden = !noteTextView.text.isEmpty
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderTitleLabel?.isHidden = !titleTextView.text.isEmpty
        placeholderNoteLabel?.isHidden = !noteTextView.text.isEmpty
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderTitleLabel?.isHidden = true
        placeholderNoteLabel?.isHidden = true
    }
}
