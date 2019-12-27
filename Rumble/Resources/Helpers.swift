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
    func loadViewFromNib() -> UIView {
        return self.loadViewFromBundleNib(resourceBundle: Bundle.main)
    }

    @discardableResult
    func loadViewFromBundleNib(resourceBundle bundle: Bundle? = nil, withNibName name: String? = nil) -> UIView {

        let swiftClass = Swift.type(of: self)

        let classNameString = NSStringFromClass(swiftClass).components(separatedBy: ".").last!
        let nibName = name ?? classNameString

        let resourceBundle: Bundle = bundle ?? Bundle(for: swiftClass)
        let view = resourceBundle.loadNibNamed(nibName, owner: self, options: nil)?.first as! UIView

        self.addConstrainedSubView(view)

        return view
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
