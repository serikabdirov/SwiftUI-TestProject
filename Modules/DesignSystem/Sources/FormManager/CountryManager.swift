
//
//  Created by deniskozhukhar on 27.10.2020.
//  Copyright © 2020 spider. All rights reserved.
//

import UIKit
import RxSwift
import R

public struct MCountry {
    public let countryName: String
    public let countryCode: String
    public let phoneCode: String
    public let flag: UIImage
}

struct MCountryCodes: Codable {
    
    let countryCode: String
    let countryEn: String
    let countryRu: String
    let phoneCode: Int
    
    enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case countryEn = "country_en"
        case countryRu = "country_ru"
        case phoneCode = "phone_code"
    }
}

public class CountryManager {
    
    public var countries = [MCountry]()
    
    public var currentCountry: MCountry? {
        guard let countryCode = Locale.current.region?.identifier else {
            return nil
        }
        return countries.first(where: { $0.countryCode == countryCode })
    }
    
    public static var shared: CountryManager = {
        let countryManager = CountryManager()
        countryManager.loadCountries()
        return countryManager
    }()
    
    private var flagsImage: CGImage?

    private var resourceBundle: Bundle? {
        return Bundle.init(path: RResources.bundle.path(forResource: "Phone-Country-Code-and-Flags", ofType: "bundle")!)
    }
    
    private init() { }
    
    public func country(withCode code: String) -> MCountry? {
        return countries.first(where: { $0.countryCode == code })
    }
    
    private func loadCountries() {
        var countries = [MCountry]()
        do {
            var codes = try getCountryCodes()
            let indices = try getFlagIndices()
            flagsImage = getFlagsImage()
            codes = codes.sorted { $0.countryRu < $1.countryRu }
            countries = codes.map { code in
                let offset = indices[code.countryCode] ?? -1
                let flag = getFlag(for: offset)
                return MCountry(countryName: code.countryRu, countryCode: code.countryCode, phoneCode: "+\(code.phoneCode)", flag: flag)
            }
            self.countries = countries
        } catch {
            self.countries = countries
        }
    }

    private func getFlagIndices() throws -> [String : Int] {
        guard let bundle = self.resourceBundle,
              let path = bundle.path(forResource: "flag_indices", ofType: "json") else {
            return [:]
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let indices = try JSONDecoder().decode([String : Int].self, from: data)
        return indices
    }
    
    private func getCountryCodes() throws -> [MCountryCodes] {
        guard let bundle = self.resourceBundle,
              let path = bundle.path(forResource: "phone_country_code", ofType: "json") else {
            return []
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let codes = try JSONDecoder().decode([MCountryCodes].self, from: data)
        return codes
    }
    
    private func getFlagsImage() -> CGImage? {
        guard
            let bundle = self.resourceBundle,
            let path = bundle.path(forResource: "flags@2x", ofType: "png"),
            let image = UIImage(contentsOfFile: path) else {
                return nil
        }
        return image.cgImage
    }
    
    private func getFlag(for offset: Int) -> UIImage {
        guard  let image = flagsImage, offset >= 0 else { return UIImage() }
        let rect = CGRect(x: 0, y: offset * 2 + 5, width: 32, height: 22)
        guard let tempImage = image.cropping(to: rect) else { return UIImage() }
        return UIImage(cgImage: tempImage)
    }
}
