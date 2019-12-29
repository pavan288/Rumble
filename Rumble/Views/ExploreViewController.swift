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
        self.navigationItem.title = "Explore"
        setupTableView()
    }

    func setupViewModel() {
        viewModel = ExploreViewModel()
        viewModel?.delegate = self
    }

    func setupTableView() {
        tableView.register(UINib(nibName: "ExploreTableViewCell", bundle: nil), forCellReuseIdentifier: "ExploreTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 128
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
}

extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.categories?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreTableViewCell", for: indexPath) as! ExploreTableViewCell
        if let category = viewModel?.categories?[indexPath.row] {
            cell.setup(with: category, and: self)
        }
        return cell
    }
}

extension ExploreViewController: ExploreViewControllerDelegate, ExploreTableViewCellDelegate {
    func showPlayer(with url: String, in section: String) {
        if let category = getCategoryFor(section: section) {
            let playerVC = PlayerViewController.controller(with: url, dataSource: category)
            self.navigationController?.pushViewController(playerVC, animated: true)
        }
    }

    func showCategories() {
        self.tableView.reloadData()
    }

    func getCategoryFor(section: String) -> Category? {
        return viewModel?.categories?.first(where: { $0.title == section })
    }
}
