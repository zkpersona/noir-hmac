use lib::not_equal;

fn main(x: Field, y: pub Field) {
    assert(not_equal(x, y));
}

#[test]
fn test_main() {
    main(1, 2);
}
