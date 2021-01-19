//
//  RoundedCornerButton.swift
//  DemoSkillsApp
//
//  Created by Stephen O'Connor on 19.01.21.
//

import UIKit

class RoundedCornerButton: UIButton {
    
    @IBInspectable
    var cornerRadius: CGFloat = 4 {
        didSet {
            updateAppearance()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateAppearance()
    }
    
    private func updateAppearance() {
        self.layer.cornerRadius = self.cornerRadius
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateAppearance()
    }
}
