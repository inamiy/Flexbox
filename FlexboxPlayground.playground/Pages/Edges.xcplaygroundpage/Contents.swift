import UIKit
import PlaygroundSupport
import Flexbox

let config = Config()

example(
    "Edge (margin, padding, border)",
    Node(
        size: config.flexContainerSize,
        children: [
            Node(
                size: CGSize(width: 20, height: 20),
                margin: Edges(uniform: 10)
            ),
            Node(
                size: CGSize(width: 40, height: 80),
                margin: Edges(top: -20)
            ),
            Node(
                size: CGSize(width: 60, height: 40),
                margin: Edges(bottom: 999),     // no effect
                padding: Edges(uniform: 10),    // small padding, no effect
                border: Edges(uniform: 10)      // small border, no effect
            ),
            Node(
                size: CGSize(width: 50, height: 10),
                margin: Edges(uniform: 10)
            ),
            Node(
                size: CGSize(width: 10, height: 10),
                padding: Edges(uniform: 20)     // big padding
            ),
            Node(
                size: CGSize(width: 10, height: 10),
                border: Edges(uniform: 20)      // big border
            )
        ],
        flexDirection: .row,
        margin: Edges(uniform: 999), // `margin` interacts with sibling views (but no effect since its superview is not managed by flexbox)
        padding: Edges(top: 5), // `padding` works to subviews
        border: Edges(top: 5)   // `border` works just like `padding`
    )
)

let (rootView, contentView) = setup(config: config)
PlaygroundPage.current.liveView = rootView

Screenshot.save(contentView, "Edges.png")
