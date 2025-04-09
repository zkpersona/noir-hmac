use crate::utils::adjust_key_sha256;
use std::hash::sha256::{sha256, sha256_var};

use crate::array_extensions::ArrayExtensions;
/// Computes HMAC-SHA256 (Hash-based Message Authentication Code) according to RFC 2104.
///
/// HMAC-SHA256 provides a way to verify both the data integrity and authenticity of a message
/// using a cryptographic hash function (SHA-256) and a secret key.
///
/// The implementation follows the standard HMAC construction:
/// HMAC(K, m) = H((K' XOR opad) || H((K' XOR ipad) || m))
/// where:
/// - K is the secret key
/// - m is the message
/// - K' is the adjusted key (padded to block size)
/// - H is the hash function (SHA-256)
/// - opad is the outer padding (0x5C repeated)
/// - ipad is the inner padding (0x36 repeated)
///
/// # Arguments
///
/// * `key` - A bounded vector of bytes representing the secret key
/// * `message` - A bounded vector of bytes containing the message to authenticate
///
/// # Returns
///
/// A 32-byte array containing the HMAC-SHA256 result
///
/// # Examples
///
/// ```noir
/// let key: BoundedVec<u8, 3> = BoundedVec::from_array([1, 2, 3]);
/// let message: BoundedVec<u8, 3> = BoundedVec::from_array([4, 5, 6]);
/// let hmac: [u8; 32] = hmac_sha256(key, message);
/// // hmac will be a 32-byte array containing the HMAC-SHA256 result
/// ```
pub fn hmac_sha256<let M: u32, let N: u32>(
    key: BoundedVec<u8, M>,
    message: BoundedVec<u8, N>,
) -> [u8; 32] {
    let adjusted_key: [u8; 64] = adjust_key_sha256(key);

    let mut inner_key_pad: [u8; 64] = [0; 64];
    let mut outer_key_pad: [u8; 64] = [0; 64];

    for i in 0..64 {
        let byte = adjusted_key[i];
        inner_key_pad[i] = byte ^ 0x36;
        outer_key_pad[i] = byte ^ 0x5C;
    }

    let inner_input: [u8; N + 64] = inner_key_pad.concat(message.storage());
    let inner_hash: [u8; 32] = sha256_var(inner_input, 64 + message.len() as u64);

    let outer_input: [u8; 64 + 32] = outer_key_pad.concat(inner_hash);
    let hmac_result: [u8; 32] = sha256(outer_input);

    hmac_result
}

#[test]
fn test_hmac_sha256() {
    let key: BoundedVec<u8, 10> = BoundedVec::from_array("secret_key".as_bytes());
    let message: BoundedVec<u8, 11> = BoundedVec::from_array("hello_world".as_bytes());
    let hmac: [u8; 32] = hmac_sha256(key, message);

    let expected: [u8; 32] = [
        32, 245, 74, 230, 153, 92, 121, 130, 198, 181, 233, 222, 161, 142, 167, 35, 8, 91, 220, 193,
        245, 93, 185, 150, 77, 51, 84, 8, 96, 219, 96, 75,
    ];

    assert(hmac == expected);
}
