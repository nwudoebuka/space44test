//
//  SplashScreenViewController.swift
//  Space44Test
//
//  Created by Chukwuebuka Nwudo on 13/12/2021.
//

import UIKit

class SplashScreenViewController: BaseViewController {
    lazy var logoImg:UIImageView = {
        let logoImg = UIImageView()
        logoImg.heightAnchor.constraint(equalToConstant: 100).isActive = true
        logoImg.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logoImg.image = UIImage(named: "logo")
        return logoImg
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func initView() {
        view.backgroundColor = .white
        view.addSubview(logoImg)
        logoImg.centerInSuperview()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            let vc = AllImagesScreenViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        })
        
    }

}
