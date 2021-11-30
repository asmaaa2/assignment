//
//  EditLabelLayout.swift
//  AsmaaAssignment
//
//  Created by Asmaa on 29/11/2021.
//

import Foundation
import UIKit

// edit Label Constraints

class EditLabelLayout {
    static func editLabelLayout(labelName: UILabel){
        labelName.frame = CGRect(x: labelName.frame.origin.x, y: labelName.frame.origin.y, width: labelName.frame.width, height: labelName.labelHeightModify)
        labelName.adjustsFontSizeToFitWidth = true
    }
}
