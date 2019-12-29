//
//  ExploreTableViewCell.swift
//  Rumble
//
//  Created by Pavan Powani on 27/12/19.
//  Copyright © 2019 PavanPowani. All rights reserved.
//

import UIKit

protocol ExploreTableViewCellDelegate: class {
    func showPlayer(with url: String, in section: String)
}

class ExploreTableViewCell: UITableViewCell {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var exploreCollectionView: ExploreCollectionView!
    var delegate: ExploreTableViewCellDelegate?
    var category: Category?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        exploreCollectionView.collectionView.reloadData()
    }

    func setup(with category: Category, and delegate: ExploreTableViewCellDelegate) {
        self.delegate = delegate
        self.category = category
        self.headingLabel.text = self.category?.title
        exploreCollectionView.setup(with: self.category?.nodes ?? [], and: self)
    }
}
extension ExploreTableViewCell: ExploreCollectionViewDelegate {
    func showPlayer(with url: String) {
        self.delegate?.showPlayer(with: url, in: self.category?.title ?? "")
    }
}
