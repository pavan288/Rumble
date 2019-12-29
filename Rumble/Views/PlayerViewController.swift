//
//  PlayerViewController.swift
//  Rumble
//
//  Created by Pavan Powani on 28/12/19.
//  Copyright © 2019 PavanPowani. All rights reserved.
//

import AVFoundation
import UIKit

class PlayerViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var urlString: String?
    var category: Category?

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        setupVideoPlayer(with: self.urlString)
        setupSwipeGesture()
    }

    class func controller(with urlString: String? = nil, dataSource: Category?) -> PlayerViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: PlayerViewController = storyBoard.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        controller.urlString = urlString
        controller.category = dataSource
        return controller
    }

    func setupVideoPlayer(with urlString: String?) {
        guard let videoUrl = urlString,
            let videoURL = URL(string: videoUrl) else { return }
        let player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }

    func setupSwipeGesture() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }

    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                case .down:
                    print("Swiped down")
                case .up:
                    print("Swiped up")
                default:
                    break
            }
        }
    }
}
