import UIKit
import PlaygroundSupport
import Flexbox

let config = Config()

typealias FlexValues = (CGFloat, CGFloat)

// flexGrow (requires positive free space)

for flexGrows: FlexValues in [(0, 0) /* default */, (1, 0), (1, 1)] {
    example(
        "flexGrows = \(flexGrows)",
        Node(
            size: config.flexContainerSize,
            children: [
                Node(
                    size: CGSize(width: 20, height: 20),
                    flexGrow: 0 // default
                ),
                Node(
                    size: CGSize(width: 40, height: 80),
                    flexGrow: flexGrows.0
                ),
                Node(
                    size: CGSize(width: 60, height: 40),
                    flexGrow: flexGrows.1
                ),
            ],
            flexDirection: .row,
            alignItems: .center
        )
    )
}

// NOTE: `node.flex` with positive values work as same as `node.flexGrow` in facebook/yoga.
for flexes: FlexValues in [(0, 0) /* default */, (1, 0), (1, 1)] {
    example(
        "flexes (positive) = \(flexes)",
        Node(
            size: config.flexContainerSize,
            children: [
                Node(
                    size: CGSize(width: 20, height: 20),
                    flex: 0 // default
                ),
                Node(
                    size: CGSize(width: 40, height: 80),
                    flex: flexes.0
                ),
                Node(
                    size: CGSize(width: 60, height: 40),
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

Screenshot.save(contentView, "FlexGrow.png")

