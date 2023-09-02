//
//  NoteCell.swift
//  TodaysNotes
//
//  Created by Vanessa Hurla on 09/05/2022.
//

import Foundation
import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    func setup(note: Note) {
        titleLabel.text = note.title
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        noteLabel.text = note.note
    }
}

