//
//  UILabel.swift
//  AsmaaAssignment
//
//  Created by Asmaa on 29/11/2021.
//

import Foundation
import UIKit

//extension to make edition in Label to be responsive with text

extension UILabel {
    var labelHeightModify : CGFloat {
        get
        {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            return label.frame.height
        }
        
    }
}

