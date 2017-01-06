import UIKit
import PlaygroundSupport
import Flexbox

let config = Config()

/// Fixed-size children.
func children(_ hasOne: Bool) -> [Node]
{
    guard hasOne else { return [] }
    return [
        Node(
            minSize: CGSize(width: 40, height: 40),
            margin: Edges(uniform: 10)
        )
    ]
}

for children: [Node] in [children(false), children(true)] {
    example(
        "minSize + fixedSizeChildren=\(children.count)",
        Node(
            size: config.flexContainerSize,
            children: [
                Node(
                    minSize: CGSize(width: 20, height: 20),
                    children: children
                )
            ],
            flexDirection: .row,
            justifyContent: .center,
            alignItems: .center
        )
    )
}

let (rootView, contentView) = setup(config: config)
PlaygroundPage.current.liveView = rootView

Screenshot.save(contentView, "MinSize.png")
