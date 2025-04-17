
//
//  Created by Alexandr Byzov on 19.10.2020.
//  Copyright © 2020 spider. All rights reserved.
//

import UIKit

public class PhoneTextFieldCell: Cell {

    public var textField: PhoneTextField!
    
    //MARK: - init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupConstraints()
    }
    
    //MARK: - setup
    private func setupViews() {
        textField = { let i = PhoneTextField()
            
            return i
        }()
        
        contentView.addSubview(textField)
    }
    
    private func setupConstraints() {
        
        textField.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
    }
}
