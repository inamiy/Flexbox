import UIKit
import PlaygroundSupport
import Flexbox

//let config = Config(flexContainerHeight: Config.defaultRootSize.height)
let config = Config(flexContainerHeight: 700)

let headerNode = Node(
    children: [
        Node(
            size: CGSize(width: 30, height: 30),
            margin: Edges(right: 10)
        ),
        Node(
            children: [
                Node(
                    size: CGSize(width: 100, height: 10),
                    flexGrow: 1
                ),
                Node(
                    size: CGSize(width: -1, height: 10),
                    flexGrow: 1
                ),
            ],
            flexDirection: .column,
            justifyContent: .flexStart,
            alignItems: .stretch,
            flexGrow: 1
        ),
        Node(
            size: CGSize(width: 30, height: 30),
            margin: Edges(left: 10)
        )
    ],
    flexDirection: .row,
    justifyContent: .flexStart,
    alignItems: .flexStart,
    padding: Edges(uniform: 10)
)

let bodyNode = Node(minSize: CGSize(width: -1, height: 150))

let buttonsNode = Node(
    size: CGSize(width: -1, height: 40),
    children: [
        Node(flexGrow: 1
        ),
        Node(flexGrow: 1),
        Node(flexGrow: 1)
    ],
    flexDirection: .row,
    justifyContent: .center,
    alignItems: .stretch,
    padding: Edges(left: 10, right: 10, top: 5, bottom: 5)
)

func commentNode(indent: Int) -> Node
{
    return Node(
        children: [
            Node(
                size: CGSize(width: 30, height: 30),
                margin: Edges(right: 10)
            ),
            Node(
                children: [
                    Node(
                        size: CGSize(width: 100, height: 15),
                        flexGrow: 1
                    ),
                    Node(
                        size: CGSize(width: -1, height: 60),
                        flexGrow: 1
                    ),
                ],
                flexDirection: .column,
                justifyContent: .flexStart,
                alignItems: .stretch,
                flexGrow: 1
            )
        ],
        flexDirection: .row,
        justifyContent: .flexStart,
        alignItems: .flexStart,
        padding: Edges(left: 10 + 40 * CGFloat(indent), right: 10, top: 10, bottom: 10)
    )
}

example(
    "Facebook post item example",
    Node(
        size: config.flexContainerSize,
        children: [
            headerNode,
            bodyNode,
            buttonsNode,
            commentNode(indent: 0),
            commentNode(indent: 1),
            commentNode(indent: 1),
            commentNode(indent: 2),
        ],
        flexDirection: .column,
        padding: Edges(uniform: 10)
    )
)

let (rootView, contentView) = setup(config: config)
PlaygroundPage.current.liveView = rootView

Screenshot.save(contentView, "Example.png")
