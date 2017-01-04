import UIKit
import PlaygroundSupport
import Flexbox

let config = Config()

typealias FlexValues = (CGFloat, CGFloat, CGFloat)

// flexBasis:
// Specifies the flex basis which is the initial main size of a flex item.

for flexBases: FlexValues in [(20, 40, 60), (20, 100, 60), (20, 100, 300)] {
    example(
        "flexBases = \(flexBases)",
        Node(
            size: config.flexContainerSize,
            children: [
                Node(
                    size: CGSize(width: 20, height: 20),
                    flexBasis: flexBases.0
                ),
                Node(
                    size: CGSize(width: 40, height: 80),
                    flexBasis: flexBases.1
                ),
                Node(
                    size: CGSize(width: 60, height: 40),
                    flexBasis: flexBases.2
                ),
            ],
            flexDirection: .row,
            alignItems: .center
        )
    )
}

let (rootView, contentView) = setup(config: config)
PlaygroundPage.current.liveView = rootView

Screenshot.save(contentView, "FlexBasis.png")
