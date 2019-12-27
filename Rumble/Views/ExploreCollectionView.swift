//
//  ExploreCollectionView.swift
//  Rumble
//
//  Created by Pavan Powani on 27/12/19.
//  Copyright © 2019 PavanPowani. All rights reserved.
//

import UIKit

class ExploreCollectionView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: [Node]?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(with node: [Node]) {
        self.dataSource = node
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ExploreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ExploreCollectionViewCell")
    }
}


extension ExploreCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectionViewCell", for: indexPath) as! ExploreCollectionViewCell
        if let url = dataSource?[indexPath.row].video.encodeUrl {
            cell.setup(with: url)
        }
        return cell
    }
}
