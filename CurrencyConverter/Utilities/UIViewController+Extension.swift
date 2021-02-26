//
//  UIViewController+Extension.swift
//  CurrencyConverter
//
//  Created by David U. Okonkwo on 2/26/21.
//

import UIKit
import SnapKit

extension UIViewController {
    //Add Placeholder to textfield
    func addPlaceholderToTextField(title: String) -> UIView {
        let firstView = UIView(frame: CGRect(x: 8.0, y: 8.0, width: 48.0, height: 48.0))
        let text = UILabel()
        firstView.addSubview(text)
        firstView.backgroundColor = .red
        text.textColor = .systemGray
        text.text = title
        text.font = UIFont(name: "AvenirNext-Regular", size: 20)
        text.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(firstView)
        }
        firstView.contentMode = .scaleAspectFit
//        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        myView.addSubview(firstView)
//        myView.backgroundColor = .blue
//        myView.contentMode = .center
        return firstView
    }
}
