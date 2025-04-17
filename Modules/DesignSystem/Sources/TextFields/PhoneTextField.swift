import UIKit
import PhoneNumberKit
import R
import SnapKit

public class PhoneTextField: ConfigurationPhoneTF {
    public var maxDigits: Int
    public var onCountryButtonTapped: (() -> Void)? = nil
    let phoneNumberUtility = PhoneNumberUtility()
    let partialFormatter: PartialFormatter
    private var isArrowDown: Bool = false
    
    public var flag: UIImage? {
        didSet {
            countryControl.flagImage.image = flag
            setNeedsLayout()
        }
    }
    
    public var code: String? {
        didSet {
            countryControl.code.text = code
        }
    }
    
    var showSelector: Bool = true {
        didSet {
            countryControl.selectorImage.isHidden = !showSelector
        }
    }
    
    public var currentRegion: String {
        partialFormatter.currentRegion
    }
    
    public var countryCode: String {
        didSet {
            updateMaxDigits(forCountry: countryCode)
        }
    }
    
    public var isValidNumber: Bool {
        let rawNumber = partialFormatter.formatPartial(text ?? String())
        do {
            _ = try phoneNumberUtility.parse(rawNumber, withRegion: countryCode)
            return true
        } catch {
            return false
        }
    }
    
    override init() {
        let defaultRegion = PhoneNumberUtility.defaultRegionCode()
        
        var digitsCount = 15
        if let exampleNumber = phoneNumberUtility.getExampleNumber(forCountry: defaultRegion) {
            let examplePlaceholder = phoneNumberUtility.format(exampleNumber, toType: .e164, withPrefix: false)
            digitsCount = examplePlaceholder.count
        }
        
        self.countryCode = defaultRegion
        self.maxDigits = digitsCount
        self.partialFormatter = PartialFormatter(utility: phoneNumberUtility,
                                                 defaultRegion: defaultRegion,
                                                 withPrefix: false,
                                                 maxDigits: maxDigits)
        
        super.init()
        
        self.countryControl = CountryControl(frame: .init(x: 0, y: 0, width: 36, height: 32))
        self.countryControl.addTarget(self, action: #selector(countryButtonTapped), for: .touchUpInside)
        self.countryControl.selectorImage.isHidden = !showSelector
        
        getExampleNumber(forCountry: defaultRegion)
        
        keyboardType = .phonePad
        leftView = countryControl
        leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var countryControl: CountryControl!
    
    @objc private func countryButtonTapped() {
        self.onCountryButtonTapped?()
    }
    
    public func getExampleNumber(forCountry countryCode: String) {
        guard let exampleNumber = phoneNumberUtility.getExampleNumber(forCountry: countryCode) else { return }
        let examplePlaceholder = phoneNumberUtility.format(exampleNumber, toType: .international, withPrefix: false)
        let placeHolderWithZero = replaceOnZero(in: examplePlaceholder)
        placeholder = placeHolderWithZero
    }
    
    private func updateMaxDigits(forCountry countryCode: String) {
        guard let exampleNumber = phoneNumberUtility.getExampleNumber(forCountry: countryCode) else { return }
        let examplePlaceholder = phoneNumberUtility.format(exampleNumber, toType: .e164, withPrefix: false)
        self.maxDigits = examplePlaceholder.count
        self.partialFormatter.maxDigits = maxDigits
        print(maxDigits)
    }
    
    private func replaceOnZero(in text: String) -> String {
        return text.replacingOccurrences(of: "\\d", with: "0", options: .regularExpression)
    }
}

fileprivate class CountryControl: UIControl {
    
    var flagImage: UIImageView!
    var selectorImage: UIImageView!
    var code: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var stackView: UIStackView!
    
    private func configureViews() {
        
        stackView = { let i = UIStackView()
            i.axis = .horizontal
            i.backgroundColor = .Background.grey
            i.spacing = 8
            i.layer.cornerRadius = 6
            i.isUserInteractionEnabled = false
            i.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 4)
            i.isLayoutMarginsRelativeArrangement = true
            return i
        }()
        
        code = { let i = UILabel()
            i.textColor = .black
            i.font = .btn2SemiBold
            i.textAlignment = .center
            return i
        }()
        
        flagImage = { let i = UIImageView()
            i.contentMode = .scaleAspectFit
            i.layer.cornerRadius = 2
            i.clipsToBounds = true
            return i
        }()
        
        selectorImage = { let i = UIImageView()
            i.contentMode = .center
            i.image = RAsset.Icons24.chevronDown.image
            return i
        }()
        
        addSubview(stackView)
        stackView.addArrangedSubview(flagImage)
        stackView.addArrangedSubview(code)
        stackView.addArrangedSubview(selectorImage)
    }
    
    private func configureConstraints() {
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(32)
            make.trailing.greaterThanOrEqualToSuperview()
        }
        
        flagImage.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
    }
}
