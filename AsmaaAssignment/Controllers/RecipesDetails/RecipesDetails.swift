//
//  RecipesDetails.swift
//  AsmaaAssignment
//
//  Created by Asmaa on 24/11/2021.
//

import UIKit
import SDWebImage
import SafariServices

class RecipesDetails: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipesTitle: UILabel!
    
    @IBOutlet weak var recipeDetails: UITextView!
    
    @IBOutlet weak var recipeWebsite: UIButton!
    
    var recipePic: String?
    var recipeTitle: String?
    var ingredientLines : [String]?
    var recipeURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recipe Details"
        navigationItems()
        setDataOnView()
        EditLabelLayout.editLabelLayout(labelName: recipesTitle)
    }
    
    func setDataOnView(){
        recipeImage.sd_setImage(with: URL(string: recipePic ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        recipesTitle.text = recipeTitle
        recipeDetails.text = ingredientLines?.compactMap{ $0 }.joined(separator: "\r")
        recipeWebsite.layer.cornerRadius = 15
    }
    
    // share URL of recipe details via share button in navigation
    @objc func shareToAnotherApps(){
        let shareData = UIActivityViewController(activityItems: [recipeURL!], applicationActivities: nil)
        present(shareData, animated: true, completion: nil)
    }
    
    private func navigationItems(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareToAnotherApps) )
    }


    @IBAction func recipeWebsiteAction(_ sender: Any) {
        let webView = SFSafariViewController(url: URL(string: recipeURL ?? "")!, entersReaderIfAvailable: true)
        webView.delegate = self
        present(webView, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}

