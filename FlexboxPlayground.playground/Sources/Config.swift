import Foundation
import CoreGraphics

/// Setup configuration.
public struct Config
{
    public let rootSize: CGSize
    public let flexContainerHeight: CGFloat

    public init(
        rootSize: CGSize = Config.defaultRootSize,
        flexContainerHeight: CGFloat = Config.defaultFlexContainerHeight
        )
    {
        self.rootSize = rootSize
        self.flexContainerHeight = flexContainerHeight
    }

    public var flexContainerSize: CGSize
    {
        return CGSize(width: self.rootSize.width, height: self.flexContainerHeight)
    }

    public static let defaultRootSize = CGSize(width: 300, height: 500)
    public static let defaultFlexContainerHeight: CGFloat = 100
}
