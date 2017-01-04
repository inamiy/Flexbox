import UIKit
import PlaygroundSupport
import Flexbox

let config = Config()

for direction: Style.Direction in [.inherit, .ltr, .rtl] {
    example(
        "direction = \(direction)",
        Node(
            size: config.flexContainerSize,
            children: [
                Node(size: CGSize(width: 20, height: 20)),
                Node(size: CGSize(width: 40, height: 40)),
                Node(size: CGSize(width: 60, height: 30)),
            ],
            flexDirection: .row,
            alignItems: .center,
            direction: direction
        )
    )
}

let (rootView, contentView) = setup(config: config)
PlaygroundPage.current.liveView = rootView

Screenshot.save(contentView, "Direction.png")
