//
//  categoriesFilterCell.swift
//  AsmaaAssignment
//
//  Created by Asmaa on 24/11/2021.
//

import UIKit

class RecipesListCell: UITableViewCell {
    
    @IBOutlet weak var imageOfRecipe: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeSource: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        EditLabelLayout.editLabelLayout(labelName: recipeTitle)
        EditLabelLayout.editLabelLayout(labelName: healthLabel)
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
