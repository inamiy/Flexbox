import UIKit
import PlaygroundSupport
import Flexbox

let config = Config()

for alignItems: Style.AlignItems in [.flexStart, .center, .flexEnd] {
    example(
        "alignItems = \(alignItems)",
        Node(
            size: config.flexContainerSize,
            children: [
                Node(size: CGSize(width: 20, height: 20)),
                Node(size: CGSize(width: 40, height: 80)),
                Node(size: CGSize(width: 60, height: 40)),
            ],
            flexDirection: .row,
            alignItems: alignItems
        )
    )
}

for alignItems: Style.AlignItems in [.stretch] {
    example(
        "alignItems = \(alignItems)",
        Node(
            size: config.flexContainerSize,
            children: [
                Node(size: CGSize(width: 20, height: 20)),
                Node(size: CGSize(width: 40, height: 80)),
                Node(size: CGSize(width: 60, height: 40)),
                Node(size: CGSize(width: 40, height: -1)),  // works
                Node(size: CGSize(width: 40, height: 0)),   // zero-height
                Node(size: CGSize(width: 40, height: CGFloat.nan))  // works
            ],
            flexDirection: .row,
            alignItems: alignItems
        )
    )
}

let (rootView, contentView) = setup(config: config)
PlaygroundPage.current.liveView = rootView

Screenshot.save(contentView, "AlignItems.png")

