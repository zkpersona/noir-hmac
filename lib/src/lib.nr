#[export]
pub fn not_equal(x: Field, y: Field) -> bool {
    x != y
}

#[test]
fn test_not_equal() {
    assert(not_equal(1, 2));
}
