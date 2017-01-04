import UIKit
import Flexbox

public func setup(config: Config) -> (scrollView: UIScrollView, contentView: UIView)
{
    let flexContainerSize = CGSize(width: config.rootSize.width, height: config.flexContainerHeight)
    let labelSize = CGSize(width: config.rootSize.width, height: 20)

    let rootView = UIScrollView(frame: CGRect(origin: .zero, size: config.rootSize))
    rootView.backgroundColor = .white
    rootView.contentSize = CGSize(
        width: config.rootSize.width,
        height: (flexContainerSize.height + labelSize.height) * CGFloat(_examples.count)
    )

    let contentView = UIView(frame: CGRect(origin: .zero, size: rootView.contentSize))
    contentView.backgroundColor = .white
    rootView.addSubview(contentView)

    for (i, example) in _examples.enumerated() {
        let desc = example.description
        let node = example.node

        func createView(_ node: Node, _ parentView: UIView, _ index: Int) -> (UIView, Int)
        {
            let view = UIView()
            view.backgroundColor = _color(at: index, isVivid: node.children.isEmpty)
//            view.layer.borderWidth = 1
//            view.layer.borderColor = _color(at: index, isVivid: true).cgColor
            parentView.addSubview(view)

            var index = index

            for childNode in node.children {
                index += 1
                let (_, lastIndex) = createView(childNode, view, index)
                index = lastIndex
            }

            return (view, index)
        }
        
        let (flexContainerView, _) = createView(node, contentView, -1)
        flexContainerView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)

        let layout = node.layout()
        print(layout)

        layout.apply(flexContainerView)

        // Update container's origin manually.
        var frame = contentView.bounds
        frame.origin.y = (flexContainerSize.height + labelSize.height) * CGFloat(i) + labelSize.height
        frame.size.height = flexContainerSize.height
        flexContainerView.frame = frame

        // Show label.
        do {
            frame.size.height = labelSize.height
            frame.origin.y -= labelSize.height
            let label = UILabel(frame: frame)
            label.text = "\(i + 1). \(desc)"
            contentView.addSubview(label)
        }
    }

    return (rootView, contentView)
}

private func _color(at index: Int, isVivid: Bool) -> UIColor
{
    let hue = (CGFloat(index) * 0.618033988749895).truncatingRemainder(dividingBy: 1)
    let saturation: CGFloat = isVivid ? 0.9 : 0.1
    return UIColor(hue: hue, saturation: saturation, brightness: 1, alpha: 0.8)
}
