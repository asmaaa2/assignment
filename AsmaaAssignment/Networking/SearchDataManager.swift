//
//  SearchDataManager.swift
//  AsmaaAssignment
//
//  Created by Asmaa on 27/11/2021.
//

import Foundation
import Alamofire

class SearchDataManager{
    static func getSearchData(completion: @escaping ((_ data: Base)->Void)){
        let url = ConstantUrl.searchData
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(_):
                guard let data = response.data else{ return }
                do{
                    let sData =  try JSONDecoder().decode(Base.self, from: data)
                    completion(sData)
                } catch{
                    print("Unexpected error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
