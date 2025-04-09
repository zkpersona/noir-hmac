use std::hash::sha256::sha256_var;

/// Adjusts a key for HMAC-SHA256 processing according to RFC 2104 specifications.
///
/// This function implements the key adjustment step required by HMAC-SHA256, which involves:
/// - If the key is longer than 64 bytes, it is hashed using SHA-256 and padded with zeros
/// - If the key is shorter than 64 bytes, it is padded with zeros to reach 64 bytes
///
/// # Arguments
///
/// * `key` - A bounded vector of bytes representing the HMAC key
///
/// # Returns
///
/// A 64-byte array containing the adjusted key:
/// - For keys > 64 bytes: First 32 bytes contain SHA-256 hash, remaining 32 bytes are zero
/// - For keys <= 64 bytes: Original key bytes followed by zero padding
///
/// # Examples
///
/// ```noir
/// let key = BoundedVec::new(vec![1, 2, 3]);
/// let adjusted = adjust_key_sha256(key);
/// // adjusted will be [1, 2, 3, 0, 0, ...] (64 bytes total)
/// ```
pub fn adjust_key_sha256<let M: u32>(key: BoundedVec<u8, M>) -> [u8; 64] {
    let mut result: [u8; 64] = [0; 64];
    let key_len = key.len();

    if key_len > 64 {
        let hashed = sha256_var(key.storage(), key_len as u64);
        for i in 0..32 {
            result[i] = hashed[i];
        }
    } else {
        for i in 0..64 {
            if i < key_len {
                result[i] = key.get(i);
            }
        }
    }

    result
}

#[test]
fn test_greater_than_64_bytes() {
    let key: BoundedVec<u8, 70> = BoundedVec::from_array([1; 70]);
    let adjusted = adjust_key_sha256(key);

    let hashed = sha256_var(key.storage(), key.len() as u64);
    let mut expected: [u8; 64] = [0; 64];
    for i in 0..32 {
        expected[i] = hashed[i];
    }

    assert(adjusted == expected);
}

#[test]
fn test_less_than_64_bytes() {
    let key: BoundedVec<u8, 3> = BoundedVec::from_array([1, 2, 3]);
    let adjusted = adjust_key_sha256(key);

    let mut expected: [u8; 64] = [0; 64];
    for i in 0..3 {
        expected[i] = key.get(i);
    }

    assert(adjusted == expected);
}

#[test]
fn test_equal_64_bytes() {
    let key: BoundedVec<u8, 64> = BoundedVec::from_array([1; 64]);
    let adjusted = adjust_key_sha256(key);

    assert(adjusted == key.storage());
}
