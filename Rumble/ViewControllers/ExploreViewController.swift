//
//  ExploreViewController.swift
//  Rumble
//
//  Created by Pavan Powani on 27/12/19.
//  Copyright © 2019 PavanPowani. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {

    var viewModel: ExploreViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = ExploreViewModel()
        viewModel?.delegate = self
        viewModel?.getCategories()
    }
}

extension ExploreViewController: ExploreViewControllerDelegate {
    func showCategories() {
        print(viewModel?.categories as Any)
    }
}
