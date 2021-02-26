//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by David U. Okonkwo on 2/26/21.
//

import UIKit
import SnapKit
import SwiftUI

class CurrencyConverterViewController: UIViewController {
    //MARK:- Properties
    var myCurrency: [String] = []
    var myValues: [Double] = []
    @State var inputCurrencyPlaceholder = "EUR"
    @State var convertedCurrencyPlaceholder = "PLN"
    
    //MARK: Views
    var titleLabel = UILabel()
    var inputTextField = UITextField()
    var outputTextField = UITextField()
    var inputPickerTextField = UITextField()
    var outputPickerTextField = UITextField()
    var convertButton = UIButton()

    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        NetworkClass.shared.getData { (feedback) in
            for (key, value) in feedback.rates {
                self.myCurrency.append(key)
                self.myValues.append(value)
//                print(self.myValues, self.myCurrency)
            }
        } failure: { (error) in
            print("Error\(error)")
        }
        navigationBar()
        setupTitle()
        setupTextFields()
        setupPickerTextFields()
    }
    
    //MARK:- Setup Views
    func setupTitle() {
        view.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        let fullString: NSString = "Currency \nCalculator." as NSString
        let firstRange = (fullString).range(of: "Currency \nCalculator")
        let secondRange = (fullString).range(of: ".")
        let attribute = NSMutableAttributedString.init(string: fullString as String)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "blue") ?? UIColor(), range: firstRange)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "green") ?? UIColor() , range: secondRange)
        titleLabel.attributedText = attribute
        titleLabel.font = UIFont(name: "AvenirNext-Bold", size: 40)
        titleLabel.snp.makeConstraints { (make) in
            make.topMargin.equalTo(view).offset(40)
            make.left.equalTo(view).offset(20)
        }
    }
    
    func setupTextFields() {
        view.addSubview(inputTextField)
        inputTextField.backgroundColor = .systemGray6
        inputTextField.borderStyle = .roundedRect
        inputTextField.rightViewMode = .always
        inputTextField.rightView = addPlaceHolder(inputTextField, title: inputCurrencyPlaceholder)
        inputTextField.textColor = .black
        inputTextField.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.height.equalTo(view).multipliedBy(0.06)
        }
        
        view.addSubview(outputTextField)
        outputTextField.backgroundColor = .systemGray6
        outputTextField.borderStyle = .roundedRect
        outputTextField.rightViewMode = .always
        outputTextField.rightView = addPlaceHolder(outputTextField, title: convertedCurrencyPlaceholder)
        outputTextField.textColor = .black
        outputTextField.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(inputTextField.snp.bottom).offset(20)
            make.height.equalTo(view).multipliedBy(0.06)
        }
    }
    
    func setupPickerTextFields() {
        view.addSubview(inputPickerTextField)
//        inputPickerTextField.backgroundColor = .systemGray6
        inputPickerTextField.borderStyle = .roundedRect
//        outputTextField.rightViewMode = .always
//        outputTextField.rightView = addPlaceHolder(outputTextField, title: convertedCurrencyPlaceholder)
        inputPickerTextField.textColor = .black
        inputPickerTextField.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view.snp.centerX).offset(-40)
            make.top.equalTo(outputTextField.snp.bottom).offset(30)
            make.height.equalTo(view).multipliedBy(0.06)
        }
        
        view.addSubview(outputPickerTextField)
//        inputPickerTextField.backgroundColor = .systemGray6
        outputPickerTextField.borderStyle = .roundedRect
//        outputTextField.rightViewMode = .always
//        outputTextField.rightView = addPlaceHolder(outputTextField, title: convertedCurrencyPlaceholder)
        outputPickerTextField.textColor = .black
        outputPickerTextField.snp.makeConstraints { (make) in
            make.right.equalTo(view).offset(-20)
            make.left.equalTo(view.snp.centerX).offset(40)
            make.top.equalTo(outputTextField.snp.bottom).offset(30)
            make.height.equalTo(view).multipliedBy(0.06)
        }
        let converterImageView = UIImageView()
        view.addSubview(converterImageView)
        let image = UIImage(systemName: "arrow.left.arrow.right", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor( .systemGray, renderingMode: .alwaysOriginal)
        converterImageView.image = image
        converterImageView.contentMode = .center
        converterImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.06)
            make.width.equalTo(converterImageView.snp.height)
            make.top.equalTo(outputTextField.snp.bottom).offset(30)
        }
    }
    
    func setupConvertButton() {
        view.addSubview(convertButton)
    }
    
    //MARK:- HELPERS
    func navigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let signUpButton = UIBarButtonItem(title: "Sign up", style: .plain, target: self, action: #selector(handleSignupButton))
        signUpButton.tintColor = UIColor(named: "green")
        signUpButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 18)!], for: UIControl.State.normal)
        let leftIcon = UIBarButtonItem(image: UIImage(systemName: "sidebar.left", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor( UIColor(named: "green")!, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(handleSignupButton))
        navigationItem.rightBarButtonItem = signUpButton
        navigationItem.leftBarButtonItem = leftIcon
    }
    
    @objc func handleSignupButton() {
        
    }

}

extension CurrencyConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    func addPlaceHolder(_ view: UITextField, title: String) -> UIView{
        let inputPlaceHolderView = UIView()
        view.addSubview(inputPlaceHolderView)
        inputPlaceHolderView.snp.makeConstraints { (make) in
            make.right.equalTo(view)
            make.height.equalTo(view)
            make.width.equalTo(inputPlaceHolderView.snp.height)
        }
        let inputLabel = UILabel()
        inputPlaceHolderView.addSubview(inputLabel)
        inputLabel.text = title
        inputLabel.textColor = .systemGray
        inputLabel.font = UIFont(name: "AvenirNext-Regular", size: 20)
        inputLabel.snp.makeConstraints { (make) in
            make.centerY.centerX.equalTo(inputPlaceHolderView)
        }
        return inputPlaceHolderView
    }
}


