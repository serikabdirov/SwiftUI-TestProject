import Foundation

public enum SubscribeStatus: String, Decodable {
    case pending
    case active
    case expired
    case cancelled
    case paused
}

public enum PaymentType: String, Decodable {
    case card
    case appleStore
    case googlePlay
}

public struct SubscribeModel: Decodable {
    public let status: SubscribeStatus?
    public let paymentType: PaymentType
    @OptionalDateValue<PreciseDateStrategy>
    public var expirationDate: Date?
    public let autoRenew: Bool
    
}

public struct SubscribeTariff: Decodable {
    public let price: Int
}
