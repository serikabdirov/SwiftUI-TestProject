//
//  NavigationManager.swift
//  Platform
//
//  Created by Давид Тоноян  on 03.11.2023.
//  Copyright © 2023 Spider Group. All rights reserved.
//

import UIKit
import R

public final class NavigationManager {

    weak var viewController: UIViewController!

    public init(viewController: UIViewController) {
        self.viewController = viewController
    }

    /// Navigation directions
    public func createMapRouteToAddr(_ addr: MapPoint) {
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )

        let cancelButton = UIAlertAction(title: RStrings.Ls.Common.cancel, style: .cancel, handler: nil)

        let appleMapButton = UIAlertAction(title: RStrings.Ls.Events.Maps.apple, style: .default) { [weak self] _ in
            self?.openAppleMapsToAddr(addr)
        }

        alert.addAction(cancelButton)
        alert.addAction(appleMapButton)

        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
            let googleMapButton = UIAlertAction(title: RStrings.Ls.Events.Maps.google, style: .default) { [weak self] _ in
                self?.openGoogleMapToAddr(addr)
            }

            alert.addAction(googleMapButton)
        }

        viewController.present(alert, animated: true)
    }

    private func openAppleMapsToAddr(_ addr: MapPoint) {
        let urlString = String(format: "http://maps.apple.com/?daddr=%f,%f&dirflg=d", addr.latitude, addr.longitude)
        UIApplication.shared.open(URL(string: urlString)!)
    }

    private func openGoogleMapToAddr(_ addr: MapPoint) {
        let urlString = String(format: "comgooglemaps://?daddr=%f,%f&directionsmode=driving", addr.latitude, addr.longitude)
        UIApplication.shared.open(URL(string: urlString)!)
    }

    /// Shows on map
    public func createMapAddr(_ addr: MapPoint) {
        let alert = UIAlertController(
            title: RStrings.Ls.Events.Map.title,
            message: nil,
            preferredStyle: .actionSheet
        )

        let cancelButton = UIAlertAction(title: RStrings.Ls.Common.cancel, style: .cancel, handler: nil)

        let appleMapButton = UIAlertAction(title: RStrings.Ls.Events.Maps.apple, style: .default) { [weak self] _ in
            self?.openAppleMaps(addr)
        }

        alert.addAction(cancelButton)
        alert.addAction(appleMapButton)

        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
            let googleMapButton = UIAlertAction(title: RStrings.Ls.Events.Maps.google, style: .default) { [weak self] _ in
                self?.openGoogleMaps(addr)
            }

            alert.addAction(googleMapButton)
        }

        viewController.present(alert, animated: true)
        
    }
    
    private func openAppleMaps(_ addr: MapPoint) {
        let urlString = "http://maps.apple.com/?q=\(addr.latitude),\(addr.longitude)"
        UIApplication.shared.open(URL(string: urlString)!)
    }

    private func openGoogleMaps(_ addr: MapPoint) {
        let urlString = "comgooglemaps://?q=\(addr.latitude),\(addr.longitude)"
        UIApplication.shared.open(URL(string: urlString)!)
    }
}

public struct MapPoint {
    public var latitude: Double
    public var longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
