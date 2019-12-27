//
//  ExploreViewModel.swift
//  Rumble
//
//  Created by Pavan Powani on 27/12/19.
//  Copyright © 2019 PavanPowani. All rights reserved.
//

import Foundation

protocol ExploreViewControllerDelegate {
    func showCategories()
}

class ExploreViewModel {

    var categories: [Category]?
    var delegate: ExploreViewControllerDelegate?

    func getCategories() {
        guard let url = Bundle.main.url(forResource: "assignment", withExtension: "json"),
                let data = try? Data(contentsOf: url) else { return }
        do {
            let parsedJson = try JSONDecoder().decode([Category].self, from: data)
            self.categories = parsedJson
            self.delegate?.showCategories()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
