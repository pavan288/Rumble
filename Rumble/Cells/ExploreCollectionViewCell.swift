//
//  ExploreCollectionViewCell.swift
//  Rumble
//
//  Created by Pavan Powani on 27/12/19.
//  Copyright © 2019 PavanPowani. All rights reserved.
//

import AVFoundation
import UIKit

class ExploreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var thumbnailImage: UIImage?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 4
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImage = nil
        self.thumbnailView.image = nil
        self.activityIndicator.startAnimating()
    }

    func setup(with url: String) {
        self.thumbnailView.image = nil
        activityIndicator.isHidden = false
        self.isUserInteractionEnabled = false
        DispatchQueue.global().async {
            self.getImageFrom(urlString: url)
            DispatchQueue.main.async {
                self.thumbnailView.image = self.thumbnailImage
                self.activityIndicator.isHidden = true
                self.isUserInteractionEnabled = true
            }
        }
    }

    func getImageFrom(urlString: String) {
        let sourceURL = URL(string: urlString)
        let asset = AVAsset(url: sourceURL!)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        let time = CMTimeMake(value: 1, timescale: 1)
        do {
            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage:imageRef)
            self.thumbnailImage = thumbnail
            return
        } catch {
            return
        }
    }

}
