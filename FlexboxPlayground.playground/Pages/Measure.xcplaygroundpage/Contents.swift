import UIKit
import PlaygroundSupport
import Flexbox

let config = Config()

//----------------------------------------
// Example 1
//----------------------------------------

example(
    "measure (fixed size)",
    Node(
        size: config.flexContainerSize,
        children: [
            Node(minSize: CGSize(width: 20, height: 10)),
            Node(minSize: CGSize(width: 40, height: 40)),
            Node(
                measure: { size in
                    print("measure size = \(size)")
                    return CGSize(width: 200, height: 80)
                }
            )
        ],
        alignItems: .center
    )
)

//----------------------------------------
// Example 2
//----------------------------------------

let attrText = NSAttributedString(string: "Hello World! Hello World! Hello World!")
let font = UIFont.systemFont(ofSize: 24)

extension NSAttributedString
{
    func fitSize(font: UIFont, maxSize: CGSize) -> CGSize
    {
        let fontAttribute = [NSFontAttributeName: font]
        let attributedTextWithFont = NSMutableAttributedString(string: self.string, attributes: fontAttribute)
        let fullRange = NSMakeRange(0, (self.string as NSString).length)
        attributedTextWithFont.beginEditing()
        self.enumerateAttributes(in: fullRange, options: .longestEffectiveRangeNotRequired, using: { (attributes, range, _) in
            attributedTextWithFont.addAttributes(attributes, range: range)
        })
        attributedTextWithFont.endEditing()

        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin]
        let size = attributedTextWithFont.boundingRect(with: maxSize, options: options, context: nil).size
        return size
    }
}

let maxLabelWidth = config.flexContainerSize.width - 20 - 40

example(
    "measure (NSAttributedString)",
    Node(
        size: config.flexContainerSize,
        children: [
            Node(size: CGSize(width: 20, height: 10)),
            Node(size: CGSize(width: 40, height: 40)),
            Node(
                maxSize: CGSize(width: maxLabelWidth, height: CGFloat.greatestFiniteMagnitude), // required
                measure: { size in
                    print("measure size = \(size)")

                    let fitSize = attrText.fitSize(font: font, maxSize: size)
                    print("attrText.fitSize = \(fitSize)")
                    return fitSize
                }
            )
        ],
        alignItems: .center
    )
)

//----------------------------------------

let (rootView, contentView) = setup(config: config)
PlaygroundPage.current.liveView = rootView

Screenshot.save(contentView, "Measure.png")

// Tweak UI after `setup`.
if true {
    let label = UILabel()
    label.layer.borderColor = UIColor.red.cgColor
    label.layer.borderWidth = 2
    label.attributedText = attrText
    label.font = font
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    label.frame.size.width = maxLabelWidth  // set frame before `sizeToFit`
    label.sizeToFit()
    let targetView = contentView.subviews[2].subviews[2]
    targetView.addSubview(label)

    print("targetView.frame = \(targetView.frame)")
    print("label.frame = \(label.frame)")
}
