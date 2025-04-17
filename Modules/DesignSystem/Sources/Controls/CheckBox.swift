//
//  CheckBox.swift
//  DesignSystem
//
//  Created by Vladislav on 11.12.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

import UIKit

public final class CheckBox: UIControl {
    // MARK: - Public properties
    
    public var value: Bool {
        isSelected
    }
    
    /// Increase tappable area on this value in all directions
    public var additionalTapAreaSize: CGFloat = 0
    
    public var images: [UIControl.State: UIImage] = [:] {
        didSet { updateImage() }
    }
    
    override public var isEnabled: Bool {
        didSet { updateImage() }
    }
    
    override public var isSelected: Bool {
        didSet { updateImage() }
    }
    
    override public var isHighlighted: Bool {
        didSet { updateImage() }
    }
    
    // MARK: - Private properties
    
    private var imageView: UIImageView!
    
    // MARK: - Init
    
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
    
    // MARK: - Override methods
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        bounds.insetBy(dx: -additionalTapAreaSize, dy: -additionalTapAreaSize).contains(point)
    }
    
    // MARK: - Public methods
    
    public func setSelected(_ isSelected: Bool, emittingEvent needSendAction: Bool = false) {
        self.isSelected = isSelected
        updateImage()
        if needSendAction {
            sendActions(for: .valueChanged)
        }
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        imageView = {
            let i = UIImageView()
            i.contentMode = .center
            return i
        }()
        
        addSubview(imageView)
        
        addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        snp.makeConstraints {
            $0.size.equalTo(24)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func updateImage() {
        imageView.image = images.value(for: state)
    }
    
    @objc
    private func tapped() {
        isSelected = !isSelected
        UIView.transition(
            with: imageView,
            duration: 0.15,
            options: [.transitionCrossDissolve, .beginFromCurrentState],
            animations: {
                self.updateImage()
            }
        )
        sendActions(for: .valueChanged)
    }
}
