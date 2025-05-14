import SwiftUI

protocol NavigationRouter: Hashable, Identifiable {
    associatedtype V: View
    
    var title: String? { get }
    var style: TransitionStyle? { get }
    
    @ViewBuilder
    func view() -> V
}