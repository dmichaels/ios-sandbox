class Foo {
    // private to Foo type
    private static let _instance: Foo = {
        print("init Foo singleton")
        return Foo()
    }()
    
    // overridable accessor
    class var instance: Foo {
        return _instance
    }
}

class Bar: Foo {
    private static let _instance: Bar = {
        print("init Bar singleton")
        return Bar()
    }()
    
    override class var instance: Bar {
        return _instance
    }
}

// Usage:
let f1 = Foo.instance
let f2 = Foo.instance
print(f1 === f2)  // true — same singleton Foo

let b1 = Bar.instance
let b2 = Bar.instance
print(b1 === b2)  // true — same singleton Bar

let b3 = Bar.instance
