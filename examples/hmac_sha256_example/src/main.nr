use noir_hmac::hmac_sha256::hmac_sha256;

fn main(key: BoundedVec<u8, 6>, message: BoundedVec<u8, 11>) -> pub [u8; 32] {
    hmac_sha256(key, message)
}
