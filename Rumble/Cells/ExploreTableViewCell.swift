//
//  ExploreTableViewCell.swift
//  Rumble
//
//  Created by Pavan Powani on 27/12/19.
//  Copyright © 2019 PavanPowani. All rights reserved.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var exploreCollectionView: ExploreCollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(with category: Category) {
        self.headingLabel.text = category.title
        exploreCollectionView.setup(with: category.nodes)
    }
}
