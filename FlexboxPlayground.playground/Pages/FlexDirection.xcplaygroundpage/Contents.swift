import UIKit
import PlaygroundSupport
import Flexbox

let config = Config()

for flexDirection: Style.FlexDirection in [.row, .column] {
    example(
        "flexDirection = \(flexDirection)",
        Node(
            size: config.flexContainerSize,
            children: [
                Node(size: CGSize(width: 20, height: 20)),
                Node(size: CGSize(width: 40, height: 40)),
                Node(size: CGSize(width: 60, height: 30)),
            ],
            flexDirection: flexDirection
        )
    )
}

let (rootView, contentView) = setup(config: config)
PlaygroundPage.current.liveView = rootView

Screenshot.save(contentView, "FlexDirection.png")
