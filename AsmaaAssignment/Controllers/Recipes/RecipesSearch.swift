//
//  ViewController.swift
//  AsmaaAssignment
//
//  Created by Asmaa on 23/11/2021.
//

import UIKit
import SVProgressHUD
import SDWebImage


class RecipesSearch: UIViewController{
    
    @IBOutlet weak var categoriesFilter: UICollectionView!
    
    @IBOutlet weak var recipesList: UITableView!
    
    var categoriesNames: [String] = []
    var searchData : [Hits]?
    let searchController = UISearchController(searchResultsController: nil)
    var searchText: [String] = []
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTableView()
        fetchCategory()
        fetchSearchData()
        searchBarConfig()
        reloadInputViews()
        
    }

    private func setupCollectionView(){
        categoriesFilter.delegate = self
        categoriesFilter.dataSource = self
       
    }

    private func setupTableView(){
        recipesList.delegate = self
        recipesList.dataSource = self
    }
    
    // fetch all ingredients filter on collectionView
    private func fetchCategory(){
        SVProgressHUD.show()
        CatagoryManager.getCategory { category in
            SVProgressHUD.dismiss()
            self.categoriesNames = category.healthLabels ?? []
            self.categoriesFilter.reloadData()
        }
    }
    
    // fetch all data of tableView
    private func fetchSearchData(){
        SearchDataManager.getSearchData { data in
            self.searchData = data.hits
            self.recipesList.reloadData()
        }
    }
    
    // searchBar configration on view
    func searchBarConfig(){
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search your Recipe"
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.titleView = self.searchController.searchBar;
        self.definesPresentationContext = true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        searchData = searchData?.filter({ Recipe in
            return (Recipe.recipe?.label?.lowercased().contains(searchText.lowercased()))!
        })
      
        recipesList.reloadData()
    }


}

//MARK:- UIcollectionView configuration

extension RecipesSearch: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = categoriesFilter.dequeueReusableCell(withReuseIdentifier: "categoriesFilterCell", for: indexPath) as! CategoriesFilterCell
        if indexPath.row == 0{
            cell.filterName.text = "ALL"
        } else {
            cell.filterName.text = categoriesNames[indexPath.row - 1]
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 3, height: self.view.frame.height )
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = categoriesFilter.cellForItem(at: indexPath) as! CategoriesFilterCell
        let cellLblText = cell.filterName.text?.lowercased()
        if indexPath.row == 0{
            fetchSearchData()
        }else {
            if let caregoryFilter = searchData?.filter({ Categories in
                (Categories.recipe?.healthLabels?.contains(cellLblText!))!
            }){
                searchData = caregoryFilter
                self.recipesList.reloadData()
            }
            
            
//            searchData = searchData?.compactMap{($0.recipe?.healthLabels?) == cellLblText{
//                self.recipesList.reloadData()
//            }}
            
            
//            self.recipesList.reloadData()
        }
     
    }

    
}



//MARK:- UITableView configuration
extension RecipesSearch: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchData?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipesList.dequeueReusableCell(withIdentifier: "recipesListCell", for: indexPath) as! RecipesListCell
        cell.recipeTitle.text = searchData?[indexPath.row].recipe?.label
        cell.recipeSource.text = searchData?[indexPath.row].recipe?.source
        cell.healthLabel.text = searchData?[indexPath.row].recipe?.healthLabels?.compactMap{ $0 }.joined(separator: ", ")
        let image = searchData?[indexPath.row].recipe?.image
        cell.imageOfRecipe.sd_setImage(with: URL(string: image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecipesDetails") as! RecipesDetails
        detailsScreen.recipePic = searchData?[indexPath.row].recipe?.image
        detailsScreen.recipeTitle = searchData?[indexPath.row].recipe?.label
        detailsScreen.ingredientLines = searchData?[indexPath.row].recipe?.ingredientLines
        detailsScreen.recipeURL = searchData?[indexPath.row].recipe?.url
        navigationController?.pushViewController(detailsScreen, animated: true)
       
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.25
    }
    

}



//MARK:- UISearchController configuration
extension RecipesSearch: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }

        if isFiltering{
            filterContentForSearchText(searchText)
        }else{
            fetchSearchData()
        }
        self.searchText.append(searchText)
    }
    
//    // filter table view by data which user write it at searchBar
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//
//
//    }

    
    // cancel search button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetchSearchData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if let _ = searchController.searchBar.text?.rangeOfCharacter(from: CharacterSet.whitespaces){
            return false
        }
        return true
    }
    
    


}
