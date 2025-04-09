use super::hmac_sha256::hmac_sha256;

#[export]
pub fn bench_large_key_large_message() {
    let key: BoundedVec<u8, 1024> = BoundedVec::from_array([1 as u8; 1024]);
    let message: BoundedVec<u8, 1024> = BoundedVec::from_array([1 as u8; 1024]);
    let _hmac = hmac_sha256(key, message);
}

#[export]
pub fn bench_large_key_small_message() {
    let key: BoundedVec<u8, 1024> = BoundedVec::from_array([1 as u8; 1024]);
    let message: BoundedVec<u8, 64> = BoundedVec::from_array([1 as u8; 64]);
    let _hmac = hmac_sha256(key, message);
}

#[export]
pub fn bench_small_key_large_message() {
    let key: BoundedVec<u8, 64> = BoundedVec::from_array([1 as u8; 64]);
    let message: BoundedVec<u8, 1024> = BoundedVec::from_array([1 as u8; 1024]);
    let _hmac = hmac_sha256(key, message);
}

#[export]
pub fn bench_small_key_small_message() {
    let key: BoundedVec<u8, 64> = BoundedVec::from_array([1 as u8; 64]);
    let message: BoundedVec<u8, 64> = BoundedVec::from_array([1 as u8; 64]);
    let _hmac = hmac_sha256(key, message);
}
