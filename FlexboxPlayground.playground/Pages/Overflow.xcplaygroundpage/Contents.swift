import UIKit
import PlaygroundSupport
import Flexbox

let config = Config()

// FIXME: How does `overflow` work?
for overflow: Style.Overflow in [.visible, .hidden, .scroll] {
    example(
        "overflow = \(overflow)",
        Node(
            size: config.flexContainerSize,
            children: [
                Node(size: CGSize(width: 20, height: 10)),
                Node(size: CGSize(width: 40, height: 40)),
                Node(size: CGSize(width: 60, height: 20)),
                Node(size: CGSize(width: 150, height: 10)),
                Node(size: CGSize(width: 100, height: 30)),
                Node(size: CGSize(width: 20, height: 10))
            ],
            flexDirection: .column,
            overflow: overflow
        )
    )
}

let (rootView, contentView) = setup(config: config)
PlaygroundPage.current.liveView = rootView

Screenshot.save(contentView, "Overflow.png")
