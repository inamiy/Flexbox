import UIKit
import PlaygroundSupport
import Flexbox

let config = Config()

for alignSelf: Style.AlignSelf in [.flexStart, .center, .flexEnd] {
    example(
        "alignSelf = \(alignSelf)",
        Node(
            size: config.flexContainerSize,
            children: [
                Node(size: CGSize(width: 20, height: 20)),
                Node(
                    size: CGSize(width: 40, height: 80),
                    alignSelf: alignSelf
                ),
                Node(size: CGSize(width: 60, height: 40)),
            ],
            flexDirection: .row,
            alignItems: .center
        )
    )
}

for alignSelf: Style.AlignSelf in [.stretch] {
    example(
        "alignSelf = \(alignSelf)",
        Node(
            size: config.flexContainerSize,
            children: [
                Node(size: CGSize(width: 20, height: 20)),
                Node(
                    size: CGSize(width: 40, height: 80),    // doesn't work
                    alignSelf: alignSelf
                ),
                Node(
                    size: CGSize(width: 40, height: -1),    // works
                    alignSelf: alignSelf
                ),
                Node(
                    size: CGSize(width: 40, height: 0),     // doesn't work
                    alignSelf: alignSelf
                ),
                Node(
                    size: CGSize(width: 40, height: CGFloat.nan),   // works
                    alignSelf: alignSelf
                ),
            ],
            flexDirection: .row,
            alignItems: .center
        )
    )
}

example(
    "Many `alignSelf`s",
    Node(
        size: config.flexContainerSize,
        children: [
            Node(size: CGSize(width: 20, height: 20)),
            Node(
                size: CGSize(width: 40, height: 80),
                alignSelf: .flexStart
            ),
            Node(
                size: CGSize(width: 60, height: 40),
                alignSelf: .center
            ),
            Node(
                size: CGSize(width: 40, height: 20),
                alignSelf: .flexEnd
            ),
            Node(
                size: CGSize(width: 40, height: CGFloat.nan),
                alignSelf: .stretch
            ),
            Node(
                size: CGSize(width: 40, height: 60),
                alignSelf: .auto
            ),
        ],
        flexDirection: .row,
        alignItems: .center
    )
)

let (rootView, contentView) = setup(config: config)
PlaygroundPage.current.liveView = rootView

Screenshot.save(contentView, "AlignSelf.png")
