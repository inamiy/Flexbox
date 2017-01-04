import UIKit
import PlaygroundSupport
import Flexbox

let config = Config()

// NOTE: `AlignContent` works only when `flexWrap = .wrap`.

for alignContent: Style.AlignContent in [.flexStart, .center, .flexEnd] {
    example(
        "alignContent = \(alignContent)",
        Node(
            size: config.flexContainerSize,
            children: [
                Node(size: CGSize(width: 20, height: 10)),
                Node(size: CGSize(width: 40, height: 40)),
                Node(size: CGSize(width: 60, height: 20)),
                Node(size: CGSize(width: 150, height: 10)),
                Node(size: CGSize(width: 100, height: 30)),
                Node(size: CGSize(width: 20, height: 20))
            ],
            flexDirection: .row,
            flexWrap: .wrap,
            alignContent: alignContent
        )
    )
}

// Warning: facebook/yoga (v2017.01.02.00) `alignContent = .stretch` seems not working correctly.
for alignContent: Style.AlignContent in [.stretch] {
    example(
        "alignContent = \(alignContent)",
        Node(
            size: config.flexContainerSize,
            children: [
                Node(size: CGSize(width: 20, height: 10)),
                Node(size: CGSize(width: 40, height: 40)),
                Node(size: CGSize(width: 60, height: 20)),
                Node(size: CGSize(width: 150, height: -1)),
                Node(size: CGSize(width: 100, height: CGFloat.nan)),
                Node(size: CGSize(width: 20, height: 20))
            ],
            flexDirection: .row,
            flexWrap: .wrap,
            alignContent: alignContent
        )
    )
}

let (rootView, contentView) = setup(config: config)
PlaygroundPage.current.liveView = rootView

Screenshot.save(contentView, "AlignContent.png")

