//
//  Font.swift
//  Core
//
//  Created by Tanakorn Phoochaliaw on 14/3/2566 BE.
//

import UIKit

public extension UIFont {

    // load framework font in application
    static let loadAllFonts: () = {
        registerFont(withFilenameString: "SF-Pro-Display-Bold.otf", bundle: ConfigBundle.core)
        registerFont(withFilenameString: "SF-Pro-Display-Regular.otf", bundle: ConfigBundle.core)
        registerFont(withFilenameString: "Font Awesome 6 Brands-Regular-400.otf", bundle: ConfigBundle.core)
        registerFont(withFilenameString: "Font Awesome 6 Pro-Light-300.otf", bundle: ConfigBundle.core)
        registerFont(withFilenameString: "Font Awesome 6 Pro-Regular-400.otf", bundle: ConfigBundle.core)
        registerFont(withFilenameString: "Font Awesome 6 Pro-Solid-900.otf", bundle: ConfigBundle.core)
        registerFont(withFilenameString: "Font Awesome 6 Pro-Thin-100.otf", bundle: ConfigBundle.core)
        registerFont(withFilenameString: "Font Awesome 6 Sharp-Solid-900.otf", bundle: ConfigBundle.core)
    }()

    static let checkFont: () = {
        for family: String in UIFont.familyNames {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
        }
    }()

    // MARK: - Make custom font bundle register to framework
    static func registerFont(withFilenameString filenameString: String, bundle: Bundle) {

        guard let pathForResourceString = bundle.path(forResource: filenameString, ofType: nil) else {
            print("UIFont+: Failed to register font - path for resource not found.")
            return
        }

        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            print("UIFont+: Failed to register font - font data could not be loaded.")
            return
        }

        guard let dataProvider = CGDataProvider(data: fontData) else {
            print("UIFont+: Failed to register font - data provider could not be loaded.")
            return
        }

        guard let font = CGFont(dataProvider) else {
            print("UIFont+: Failed to register font - font could not be loaded.")
            return
        }

        var errorRef: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &errorRef) {
            print("UIFont+: Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }

    enum Fonts: String, CaseIterable {
        case bold = "SFProDisplay-Bold"
        case regular = "SFProDisplay-Regular"
    }

    enum FontSize {
        case title
        case head1
        case head2
        case head3
        case head4
        case head5
        case body
        case overline
        case small
        case custom(size: CGFloat)

        var value: CGFloat {
            switch self {
            case .title:
                return 30
            case .head1:
                return 30
            case .head2:
                return 24
            case .head3:
                return 20
            case .head4:
                return 18
            case .head5:
                return 16
            case .body:
                return 16
            case .overline:
                return 14
            case .small:
                return 12
            case .custom(let size):
                return size
            }
        }
    }

    static func asset(_ font: Fonts, fontSize: FontSize) -> UIFont {
        return UIFont(name: font.rawValue, size: fontSize.value)!
    }
}
