//
//  Helpers.swift
//  Rumble
//
//  Created by Pavan Powani on 27/12/19.
//  Copyright © 2019 PavanPowani. All rights reserved.
//

import UIKit

extension UIView {

    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            // xib not loaded, or its top view is of the wrong type
            return nil
        }
        self.addConstrainedSubView(contentView)
        return contentView
    }

    func addConstrainedSubView(_ view: UIView) {

        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        let horizontalConstraints = view.horizontalConstraintsToSuperview()
        let verticalConstraints = view.verticalConstraintsToSuperview()

        let constraints = horizontalConstraints + verticalConstraints

        addConstraints(constraints)
        setNeedsUpdateConstraints()
    }

    func horizontalConstraintsToSuperview() -> [NSLayoutConstraint] {
        let views = ["view": self]
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views)
        return horizontalConstraints
    }

    func verticalConstraintsToSuperview() -> [NSLayoutConstraint] {
        let views = ["view": self]
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views)
        return verticalConstraints
    }
}
