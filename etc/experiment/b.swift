public class A {
    public var x: Int = 1
    public static let instance: A = A()
}

public class B: A {
    public var y: Int = 1
    public static let instance: B = B()
}
