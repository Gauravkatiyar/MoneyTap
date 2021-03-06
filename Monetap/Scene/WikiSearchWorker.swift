//
//  WikiSearchWorker.swift
//  Monetap
//
//  Created by Garry Patel on 06/09/18.
//  Copyright (c) 2018 com.ways. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class WikiSearchWorker {
    
    
    func getSearchFromServer(_ request: WikiSearch.SearchWiki.Request,_ completion: @escaping ( _ query: Query? , _ batchcomplete : Bool?, _ continues: Continue? , _ isError: Bool , _ message : String? ) -> Void)  {
     
        print("\(#function)")
        
        let url = "&gpssearch=\(request.searchStr?.replacingOccurrences(of:" ", with: "-") ?? "")&gpslimit=\(request.limit ?? 0)"
        
        APIManager.shared.request(url, .get, nil, nil) { (response, error) in
            if error == nil {
                
                var queryPass : Query?
                var continuesPass : Continue?
                var batchcompletePass : Bool?
                
                if let query = response?["query"] as? [String: Any] {
                    let parseQuery = Query.init(object: query)
                    queryPass = parseQuery
                }
                if let continues = response?["continue"] as? [String: Any] {
                    let parsecontinues = Continue.init(object: continues)
                    continuesPass = parsecontinues
                }
                
                if let batchcomplete = response?["batchcomplete"] as? Bool {
                    print(batchcomplete)
                    batchcompletePass = batchcomplete
                } else {
                    batchcompletePass = false
                }
                completion(queryPass, batchcompletePass, continuesPass, false, nil)
                
            } else {
                completion(nil, nil, nil, true,(error?.localizedDescription))
            }
        }
    }
}
