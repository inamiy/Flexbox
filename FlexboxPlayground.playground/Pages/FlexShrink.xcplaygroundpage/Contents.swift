import UIKit
import PlaygroundSupport
import Flexbox

let config = Config()

typealias FlexValues = (CGFloat, CGFloat)

// flexShrink (requires negative free space)

for flexShrinks: FlexValues in [(1, 1) /* default */, (1, 0), (4, 1)] {
    example(
        "flexShrinks = \(flexShrinks)",
        Node(
            size: config.flexContainerSize,
            children: [
                Node(
                    size: CGSize(width: 120, height: 20),
                    flexShrink: 1   // default
                ),
                Node(
                    size: CGSize(width: 140, height: 80),
                    flexShrink: flexShrinks.0
                ),
                Node(
                    size: CGSize(width: 160, height: 40),
                    flexShrink: flexShrinks.1
                ),
            ],
            flexDirection: .row,
            alignItems: .center
        )
    )
}

// NOTE: `node.flex` with negative values work as same as `node.flexShrink` in facebook/yoga.
for flexes: FlexValues in [(-1, -1), (-1, 0), (-4, -1)] {
    example(
        "flexes (negative) = \(flexes)",
        Node(
            size: config.flexContainerSize,
            children: [
                Node(
                    size: CGSize(width: 120, height: 20),
                    flex: -1
                ),
                Node(
                    size: CGSize(width: 140, height: 80),
                    flex: flexes.0
                ),
                Node(
                    size: CGSize(width: 160, height: 40),
                    flex: flexes.1
                )
            ],
            flexDirection: .row,
            alignItems: .center
        )
    )
}

let (rootView, contentView) = setup(config: config)
PlaygroundPage.current.liveView = rootView

Screenshot.save(contentView, "FlexShrink.png")
