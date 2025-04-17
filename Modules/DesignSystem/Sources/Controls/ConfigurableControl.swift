//
//  ConfigurableControl.swift
//  DesignSystem
//
//  Created by Vladislav on 16.12.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

public class ConfigurableControl: UIControl {
    public typealias tapBlock = () -> Void
    
    public var tap: tapBlock?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
        configureConstraints()
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    public func configureViews() {}
    public func configureConstraints() {}
    
    @objc
    func buttonTapped() {
        tap?()
    }
}
