//
//  RadioButton.swift
//  DesignSystem
//
//  Created by Vladislav on 16.12.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

import R

public class RadioButton: ConfigurableControl {
    
    public override var isSelected: Bool {
        didSet {
            imageView.image = isSelected ?
            RAsset.Radio.active.image
            : RAsset.Radio.default.image
        }
    }
    
    public var imageView: UIImageView!
    
    public override func configureViews() {
        
        imageView = {
            let i = UIImageView()
            i.contentMode = .scaleAspectFit
            i.image = RAsset.Radio.default.image
            return i
        }()
        
        addSubview(imageView)
    }
    
    public override func configureConstraints() {
        
        imageView.snp.makeConstraints {
            $0.edges.equalTo(0)
            $0.width.height.equalTo(24)
        }
    }
}
