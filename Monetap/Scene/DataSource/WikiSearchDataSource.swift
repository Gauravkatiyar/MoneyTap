//
//  WikiSearchDataSource.swift
//  MoneyTap
//
//  Created by Garry Patel on 06/09/18.
//  Copyright © 2018 com.ways. All rights reserved.
//

import Foundation
import UIKit

protocol SearchSelected {
    func selectedRow(_ title : String?)
    func nextPaginationCall(_ counter: Int)
}

class WikiSearchDataSource: NSObject {
        var pagesData = [Pages]()
        var selectDelegate: SearchSelected?
}

extension WikiSearchDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Move to next page...
        selectDelegate?.selectedRow(pagesData[indexPath.row].title ?? "")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
        if indexPath.row == pagesData.count-1 {
            // Call for next pagination...
            selectDelegate?.nextPaginationCall(pagesData.count)
        }
    }
}

extension WikiSearchDataSource : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pagesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: "WikiSearchResultTableViewCell_id", for: indexPath) as! WikiSearchResultTableViewCell
        cell.drawCell(pagesData[indexPath.row])
        return cell
        
    }
}
