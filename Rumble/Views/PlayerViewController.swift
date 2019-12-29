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
    var currentVideoUrl: String?
    var category: Category?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Player"
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        setupVideoPlayer(with: self.currentVideoUrl)
        setupSwipeGesture()
    }

    class func controller(with urlString: String? = nil, dataSource: Category?) -> PlayerViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: PlayerViewController = storyBoard.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        controller.currentVideoUrl = urlString
        controller.category = dataSource
        return controller
    }

    func setupVideoPlayer(with urlString: String?) {
        if let subLayerCount = self.view.layer.sublayers?.count, subLayerCount > 1 {
            self.view.layer.sublayers?.last?.removeFromSuperlayer()
        }
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
        guard var currentVideoIndex = self.category?.nodes.firstIndex(where: { $0.video.encodeUrl == self.currentVideoUrl }) else { return }
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                case .down:
                    currentVideoIndex = currentVideoIndex - 1
                    moveToVideoAt(index: currentVideoIndex)
                case .up:
                    currentVideoIndex = currentVideoIndex + 1
                    moveToVideoAt(index: currentVideoIndex)
                default:
                    break
            }
        }
    }

    func moveToVideoAt(index currentVideoIndex: Int) {
        if let numberOfNodes = self.category?.nodes.count,
            currentVideoIndex < numberOfNodes, currentVideoIndex >= 0 {
            let nextVideoNode = self.category?.nodes[currentVideoIndex]
            self.currentVideoUrl = nextVideoNode?.video.encodeUrl
            self.setupVideoPlayer(with: self.currentVideoUrl)
        }
    }
}
