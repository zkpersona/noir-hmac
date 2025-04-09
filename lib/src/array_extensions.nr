pub trait ArrayExtensions<let M: u32> {
    fn concat<let N: u32>(self, other: [u8; N]) -> [u8; M + N];
}

impl<let M: u32> ArrayExtensions<M> for [u8; M] {
    fn concat<let N: u32>(self, other: [u8; N]) -> [u8; M + N] {
        let mut result: [u8; M + N] = [0; M + N];

        for i in 0..M {
            result[i] = self[i];
        }

        for i in 0..N {
            result[i + M] = other[i];
        }

        result
    }
}
