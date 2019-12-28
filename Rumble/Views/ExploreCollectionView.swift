//
//  ExploreCollectionView.swift
//  Rumble
//
//  Created by Pavan Powani on 27/12/19.
//  Copyright © 2019 PavanPowani. All rights reserved.
//

import AVFoundation
import UIKit

protocol ExploreCollectionViewDelegate: class {
    func showPlayer(with url: String)
}

class ExploreCollectionView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: [Node]?
    var delegate: ExploreCollectionViewDelegate?
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

    func setup(with node: [Node], and delegate: ExploreCollectionViewDelegate) {
        self.dataSource = node
        self.delegate = delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
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
            DispatchQueue.main.async {
                cell.activityIndicator.startAnimating()
                cell.setup(with: url)
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 160)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //go to detail screen
        if let url = dataSource?[indexPath.row].video.encodeUrl {
            self.delegate?.showPlayer(with: url)
        }
    }
}
