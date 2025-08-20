public class A {
    public var x: Int = 1
    public init() {}
    public class var instance: A { return A() }
}
public class B: A {
    public var y: Int = 1
    public override init() {}
    public override class var instance: B { return B() }
}


