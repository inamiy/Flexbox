import UIKit
import PlaygroundSupport
import Flexbox

let config = Config()

example(
    "measure",
    Node(
        size: config.flexContainerSize,
        children: [
            Node(size: CGSize(width: 20, height: 10)),
            Node(size: CGSize(width: 40, height: 40)),
            Node(
                measure: { size in
                    print("measure size = \(size)")
                    var size = size
                    size.height -= 20
                    return size
                }
            )
        ],
        alignItems: .center
    )
)

let (rootView, contentView) = setup(config: config)
PlaygroundPage.current.liveView = rootView

Screenshot.save(contentView, "Measure.png")
