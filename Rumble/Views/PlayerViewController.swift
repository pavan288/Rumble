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
    var urlString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoPlayer()
    }

    class func controller(with urlString: String? = nil) -> PlayerViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: PlayerViewController = storyBoard.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        controller.urlString = urlString
        return controller
    }

    func setupVideoPlayer() {
        guard let videoUrl = urlString else { return }
        let videoURL = URL(string: videoUrl)
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
}
