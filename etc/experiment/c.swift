public class A {
    public var x: Int = 1
    public required init() {print("A.init()")}
    public class var instance: Self { Self.init() }
}

public class B: A {
    public var y: Int = 2
    public required init() {print("B.init()")}
}

let a: A = A.instance
let b: B = B.instance
print(a.x)
print(b.x)
print(b.y)
let c: A = A.instance
