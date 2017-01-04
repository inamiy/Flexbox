import Foundation

/// Flexbox node.
/// - https://www.w3.org/TR/css-flexbox/
/// - https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout
public struct Node
{
    public let size: CGSize
    public let minSize: CGSize
    public let maxSize: CGSize

    public let children: [Node]

    /// Specifies how flex-items are placed in the flex-container (defining the main-axis).
    /// - Note: Applies to flex-container.
    public let flexDirection: Style.FlexDirection

    /// Specifies whether flex items are forced into a single line 
    /// or can be wrapped onto multiple lines.
    /// - Note: Applies to flex-container.
    public let flexWrap: Style.FlexWrap

    /// Distributes space between and around flex-items along the main-axis.
    /// - Note: Applies to flex-container.
    public let justifyContent: Style.JustifyContent

    /// Distributes space between and around flex-items along the cross-axis. 
    /// This works like `justifyContent` but in the perpendicular direction.
    /// - Note: Applies to flex-container.
    public let alignItems: Style.AlignItems

    /// Aligns self (flex-item) by overriding it's parent's (flex-container) `alignItems`.
    /// - Note: Applies to flex-item.
    public let alignSelf: Style.AlignSelf

    /// Aligns a flex-container's lines when there is extra space on the cross-axis.
    /// - Warning: This property has no effect on single line.
    /// - Note: Applies to multi-line flex-container (no `FlexWrap.nowrap`).
    public let alignContent: Style.AlignContent

    /// Shorthand property specifying the ability of a flex-item 
    /// to alter its dimensions to fill available space.
    /// - Note: Applies to flex-item.
    public let flex: CGFloat

    /// Grow factor of a flex-item.
    /// - Note: Applies to flex-item.
    public let flexGrow: CGFloat

    /// Shrink factor of a flex-item.
    /// - Note: Applies to flex-item.
    public let flexShrink: CGFloat

    /// Initial main size of a flex item.
    /// - Note: Applies to flex-item.
    public let flexBasis: CGFloat

    public let direction: Style.Direction
    public let overflow: Style.Overflow
    public let positionType: Style.PositionType

    /// CSS's (top, right, bottom, left) that works with `positionType = .absolute`.
    public let position: Edges

    public let margin: Edges
    public let padding: Edges

    /// facebook/yoga implementation that mostly works as same as `padding`.
    public let border: Edges

    public let measure: ((CGSize) -> CGSize)?

    /// - Note: See `gYGNodeDefaults.style`.
    public init(
        size: CGSize = CGSize(width: CGFloat.nan, height: .nan),
        minSize: CGSize = CGSize(width: CGFloat.nan, height: .nan),
        maxSize: CGSize = CGSize(width: CGFloat.nan, height: .nan),

        children: [Node] = [],

        flexDirection: Style.FlexDirection = .row,
        flexWrap: Style.FlexWrap = .nowrap,
        justifyContent: Style.JustifyContent = .flexStart,
        alignContent: Style.AlignContent = .stretch,
        alignItems: Style.AlignItems = .stretch,
        alignSelf: Style.AlignSelf = .auto,

        flex: CGFloat = .nan,       // CSS default = 0
        flexGrow: CGFloat = .nan,   // CSS default = 0
        flexShrink: CGFloat = .nan, // CSS default = 1
        flexBasis: CGFloat = .nan,  // CSS default = .auto

        direction: Style.Direction = .inherit,
        overflow: Style.Overflow = .visible,
        positionType: Style.PositionType = .relative,

        position: Edges = .undefined,
        margin: Edges = .undefined,
        padding: Edges = .undefined,
        border: Edges = .undefined,

        measure: ((CGSize) -> CGSize)? = nil
        )
    {
        self.size = size
        self.minSize = minSize
        self.maxSize = maxSize

        self.children = children

        self.flexDirection = flexDirection
        self.flexWrap = flexWrap
        self.justifyContent = justifyContent
        self.alignContent = alignContent
        self.alignItems = alignItems
        self.alignSelf = alignSelf

        self.flex = flex
        self.flexGrow = flexGrow
        self.flexShrink = flexShrink
        self.flexBasis = flexBasis

        self.direction = direction
        self.overflow = overflow
        self.positionType = positionType

        self.position = position
        self.margin = margin
        self.padding = padding
        self.border = border

        self.measure = measure
    }

    /// Lay out the receiver and all its children with an optional `maxSize`.
    public func layout(maxSize: CGSize? = nil) -> Layout
    {
        let node = _createUnderlyingNode()
        if let maxSize = maxSize {
            node.layout(withMaxSize: maxSize)
        } else {
            node.layout()
        }

        func createLayoutsFromChildren(_ node: NodeImpl) -> [Layout]
        {
            return node.children.map {
                let child = $0 as! NodeImpl
                let frame = child.frame
                return Layout(frame: frame, children: createLayoutsFromChildren(child))
            }
        }

        let children = createLayoutsFromChildren(node)
        return Layout(frame: node.frame, children: children)
    }

    // MARK: Private

    private func _createUnderlyingNode() -> NodeImpl
    {
        let node = NodeImpl()

        YGNodeStyleSetWidth(node.node, Float(size.width))
        YGNodeStyleSetHeight(node.node, Float(size.height))
        YGNodeStyleSetMinWidth(node.node, Float(minSize.width))
        YGNodeStyleSetMinHeight(node.node, Float(minSize.height))
        YGNodeStyleSetMaxWidth(node.node, Float(maxSize.width))
        YGNodeStyleSetMaxHeight(node.node, Float(maxSize.height))

        YGNodeStyleSetFlexDirection(node.node, YGFlexDirection(flexDirection.rawValue))
        YGNodeStyleSetFlexWrap(node.node, YGWrap(flexWrap.rawValue))
        YGNodeStyleSetJustifyContent(node.node, YGJustify(justifyContent.rawValue))
        YGNodeStyleSetAlignContent(node.node, YGAlign(alignContent.rawValue))
        YGNodeStyleSetAlignItems(node.node, YGAlign(alignItems.rawValue))
        YGNodeStyleSetAlignSelf(node.node, YGAlign(alignSelf.rawValue))

        YGNodeStyleSetFlex(node.node, Float(flex))
        YGNodeStyleSetFlexGrow(node.node, Float(flexGrow))
        YGNodeStyleSetFlexShrink(node.node, Float(flexShrink))
        YGNodeStyleSetFlexBasis(node.node, Float(flexBasis))

        YGNodeStyleSetDirection(node.node, YGDirection(direction.rawValue))
        YGNodeStyleSetOverflow(node.node, YGOverflow(overflow.rawValue))
        YGNodeStyleSetPositionType(node.node, YGPositionType(positionType.rawValue))

        YGNodeStyleSetPosition(node.node, YGEdgeTop, Float(position.top))
        YGNodeStyleSetPosition(node.node, YGEdgeBottom, Float(position.bottom))
        YGNodeStyleSetPosition(node.node, YGEdgeLeft, Float(position.left))
        YGNodeStyleSetPosition(node.node, YGEdgeRight, Float(position.right))

        YGNodeStyleSetMargin(node.node, YGEdgeTop, Float(margin.top))
        YGNodeStyleSetMargin(node.node, YGEdgeBottom, Float(margin.bottom))
        YGNodeStyleSetMargin(node.node, YGEdgeLeft, Float(margin.left))
        YGNodeStyleSetMargin(node.node, YGEdgeRight, Float(margin.right))

        YGNodeStyleSetPadding(node.node, YGEdgeTop, Float(padding.top))
        YGNodeStyleSetPadding(node.node, YGEdgeBottom, Float(padding.bottom))
        YGNodeStyleSetPadding(node.node, YGEdgeLeft, Float(padding.left))
        YGNodeStyleSetPadding(node.node, YGEdgeRight, Float(padding.right))

        YGNodeStyleSetBorder(node.node, YGEdgeTop, Float(border.top))
        YGNodeStyleSetBorder(node.node, YGEdgeBottom, Float(border.bottom))
        YGNodeStyleSetBorder(node.node, YGEdgeLeft, Float(border.left))
        YGNodeStyleSetBorder(node.node, YGEdgeRight, Float(border.right))

        if let measure = self.measure {
            node.measure = measure
        }

        node.children = children.map { $0._createUnderlyingNode() }

        return node
    }
}

extension Node: Equatable
{
    public static func == (lhs: Node, rhs: Node) -> Bool
    {
        if lhs.size != rhs.size { return false }
        if lhs.minSize != rhs.minSize { return false }
        if lhs.maxSize != rhs.maxSize { return false }
        if lhs.children != rhs.children { return false }
        if lhs.flexDirection != rhs.flexDirection { return false }
        if lhs.flexWrap != rhs.flexWrap { return false }
        if lhs.justifyContent != rhs.justifyContent { return false }
        if lhs.alignContent != rhs.alignContent { return false }
        if lhs.alignItems != rhs.alignItems { return false }
        if lhs.alignSelf != rhs.alignSelf { return false }
        if lhs.flex != rhs.flex { return false }
        if lhs.flexGrow != rhs.flexGrow { return false }
        if lhs.flexShrink != rhs.flexShrink { return false }
        if lhs.flexBasis != rhs.flexBasis { return false }
        if lhs.direction != rhs.direction { return false }
        if lhs.overflow != rhs.overflow { return false }
        if lhs.positionType != rhs.positionType { return false }
        if lhs.position != rhs.position { return false }
        if lhs.margin != rhs.margin { return false }
        if lhs.padding != rhs.padding { return false }
        if lhs.border != rhs.border { return false }

        return true
    }
}
