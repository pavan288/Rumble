//
//  ExploreViewController.swift
//  Rumble
//
//  Created by Pavan Powani on 27/12/19.
//  Copyright © 2019 PavanPowani. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: ExploreViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewModel()
        viewModel?.getCategories()
    }

    func setupViewModel() {
        viewModel = ExploreViewModel()
        viewModel?.delegate = self
    }

    func setupTableView() {

    }
}

extension ExploreViewController: ExploreViewControllerDelegate {
    func showCategories() {
        print(viewModel?.categories as Any)
    }
}
