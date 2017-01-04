import UIKit
import PlaygroundSupport
import Flexbox

let config = Config()

for flexWrap: Style.FlexWrap in [.nowrap, .wrap] {
    example(
        "flexWrap = \(flexWrap)",
        Node(
            size: config.flexContainerSize,
            children: [
                Node(size: CGSize(width: 20, height: 10)),
                Node(size: CGSize(width: 40, height: 40)),
                Node(size: CGSize(width: 60, height: 20)),
                Node(size: CGSize(width: 150, height: 10)),
                Node(size: CGSize(width: 100, height: 30)),
            ],
            flexWrap: flexWrap
        )
    )
}

let (rootView, contentView) = setup(config: config)
PlaygroundPage.current.liveView = rootView

Screenshot.save(contentView, "FlexWrap.png")
