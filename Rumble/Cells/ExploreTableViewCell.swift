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

    override func prepareForReuse() {
        super.prepareForReuse()
        exploreCollectionView.collectionView.reloadData()
    }

    func setup(with category: Category, and delegate: ExploreCollectionViewDelegate) {
        self.headingLabel.text = category.title
        exploreCollectionView.setup(with: category.nodes, and: delegate)
    }
}
