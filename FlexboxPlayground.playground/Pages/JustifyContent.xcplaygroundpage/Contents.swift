import UIKit
import PlaygroundSupport
import Flexbox

let config = Config()

for justifyContent: Style.JustifyContent in [.flexStart, .center, .flexEnd, .spaceBetween, .spaceAround] {
    example(
        "justifyContent = \(justifyContent)",
        Node(
            size: config.flexContainerSize,
            children: [
                Node(size: CGSize(width: 20, height: 20)),
                Node(size: CGSize(width: 40, height: 80)),
                Node(size: CGSize(width: 60, height: 40)),
            ],
            flexDirection: .row,
            justifyContent: justifyContent
        )
    )
}

let (rootView, contentView) = setup(config: config)
PlaygroundPage.current.liveView = rootView

Screenshot.save(contentView, "JustifyContent.png")
