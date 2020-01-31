//
//  Extension.swift
//  ContactsPro
//
//  Created by Giorgi Shamugia on 1/23/20.
//  Copyright © 2020 Chhaileng Peng. All rights reserved.
//

import UIKit

extension UIImageView {

    func makeRounded() {

        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
