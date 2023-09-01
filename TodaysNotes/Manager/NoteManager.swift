//
//  NoteManager.swift
//  TodaysNotes
//
//  Created by Vanessa Hurla on 12/05/2022.
//

import Foundation

class NoteManager {
    private let userDefaults = UserDefaults.standard
    private let noteKey = "NoteList"
    
    func saveNote(note: Note) {
        var retrievedNotes = retrieveNote()
        retrievedNotes.append(note)
        encondeAndStore(notes: retrievedNotes)
    }

    func retrieveNote() -> [Note] {
        guard let retrievedData = userDefaults.object(forKey: noteKey) as? Data,
              let decodedNotes = try? JSONDecoder().decode([Note].self, from: retrievedData) else {
            return []
        }
        return decodedNotes
    }

    func deleteNote(note: Note) {
        var retrievedNotes = retrieveNote()
        if let index = retrievedNotes.firstIndex(of: note) {
            retrievedNotes.remove(at: index)
            encondeAndStore(notes: retrievedNotes)
        }
    }

    func replaceNote(oldNote: Note, newNote: Note) {
        var retrievedNotes = retrieveNote()
        if let index = retrievedNotes.firstIndex(of: oldNote) {
            retrievedNotes[index] = newNote
            encondeAndStore(notes: retrievedNotes)
        }
    }
}

private extension NoteManager {
    func encondeAndStore(notes: [Note]) {
        guard let encodedNotes = try? JSONEncoder().encode(notes) else {
            return
        }
        userDefaults.set(encodedNotes, forKey: noteKey)
    }
}
