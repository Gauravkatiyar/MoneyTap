//
//  WikiSearchResultTableViewCell.swift
//  MoneyTap
//
//  Created by Garry Patel on 06/09/18.
//  Copyright © 2018 com.ways. All rights reserved.
//

import UIKit
import SDWebImage

class WikiSearchResultTableViewCell: UITableViewCell {
    
    
    // MARK: ~~~~~~~~~~~~~~~~~~~~~~~~~~ IBOUTLETS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    @IBOutlet weak var labelHeading : UILabel!
    @IBOutlet weak var labelSubHeading : UILabel!
    
    @IBOutlet weak var imgView : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: ~~~~~~~~~~~~~~~~~~~~~~~~~~ Function's ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    func drawCell(_ page : Pages) {
        print("\(#function)")
        
        self.labelHeading.text = page.title ?? ""
        self.labelSubHeading.text = page.terms?.descriptionValue?.first ?? ""
        self.imgView.sd_setImage(with: URL(string: page.thumbnail?.source ?? ""), placeholderImage: UIImage(named: "Default"))
    }

}
