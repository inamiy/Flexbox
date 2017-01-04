import UIKit
import PlaygroundSupport
import Flexbox

let config = Config()

example(
    "position = .absolute",
    Node(
        size: config.flexContainerSize,
        children: [
            Node(size: CGSize(width: 200, height: 30)),
            Node(
                size: CGSize(width: 50, height: 50),
                positionType: .absolute,
                position: Edges(left: 10, right: 20, top: 10, bottom: 0)
            ),
            Node(size: CGSize(width: 60, height: 60)),
        ],
        flexDirection: .row,
        justifyContent: .center,
        alignItems: .center
    )
)

let (rootView, contentView) = setup(config: config)
PlaygroundPage.current.liveView = rootView

Screenshot.save(contentView, "PositionType")
