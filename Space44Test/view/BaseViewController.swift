//
//  BaseViewController.swift
//  Space44Test
//
//  Created by Chukwuebuka Nwudo on 13/12/2021.
//

import UIKit

class BaseViewController: UIViewController {
    var spinner:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView(){
        
    }
    func showAlertMsg(_ title:String,_ msg:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func showLoading() {
        if(spinner != nil){
            hideLoading();
        }
        spinner = displaySpinner(onView: self.view)
    }
    
    func hideLoading() {
        removeSpinner(spinner: spinner ?? UIView())
    }

    func removeSpinner(spinner: UIView) {
        DispatchQueue.main.async {
            
            spinner.removeFromSuperview()
        }
    }
    func displaySpinner(onView: UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        
        spinnerView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
        
        let ai = UIActivityIndicatorView.init(style: .gray)
        ai.style = .large
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            ai.startAnimating()
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    func generateStackView(axis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.axis = axis
        return stackView
    }
    func labelMedium(text: String, textSize : CGFloat = 22,textColor:UIColor = .black,textNumberLine:Int = 0) -> UILabel{
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.textAlignment = .center
        label.numberOfLines = textNumberLine
        label.font = UIFont.init(name:"Poppins-Medium",size: textSize)
        return label
    }
    func labelBold(text: String, textSize : CGFloat = 12,textColor:UIColor = .black) -> UILabel{
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.init(name:"Poppins-Bold",size: textSize)
        return label
    }
    
    func labelRegular(text: String, textSize : CGFloat = 16,
                         textColor : UIColor = .black) -> UILabel{
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "Poppins-Regular", size: textSize)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = textColor
        return label
    }
    func rotLeft(arr: [AlbumDetailItem], index: Int) -> [AlbumDetailItem] {
        let slice1 = arr[..<index]
        let slice2 = arr[index...]
        return Array(slice2) + Array(slice1)
    }

}
