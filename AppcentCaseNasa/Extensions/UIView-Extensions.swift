//
//  UIView-Extensions.swift
//  AppcentCaseNasa
//
//  Created by Oğuz Karatoruk on 19.11.2020.
//

import UIKit

extension UIView {
    
    func loadNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    func ownFirstNib() {
        guard let view = loadNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
    }
}
