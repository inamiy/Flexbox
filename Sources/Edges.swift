/// Container for 4-direction `CGFloat` values.
public struct Edges
{
    public let left: CGFloat
    public let right: CGFloat
    public let top: CGFloat
    public let bottom: CGFloat

    public init(left: CGFloat = 0, right: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0)
    {
        self.left = left
        self.right = right
        self.top = top
        self.bottom = bottom
    }

    public init(uniform: CGFloat)
    {
        self.left = uniform
        self.right = uniform
        self.top = uniform
        self.bottom = uniform
    }

    static let zero = Edges(uniform: 0)
    static let undefined = Edges(uniform: .nan)
}

extension Edges: Equatable
{
    public static func == (lhs: Edges, rhs: Edges) -> Bool
    {
        if lhs.left != rhs.left { return false }
        if lhs.right != rhs.right { return false }
        if lhs.top != rhs.top { return false }
        if lhs.bottom != rhs.bottom { return false }

        return true
    }
}
