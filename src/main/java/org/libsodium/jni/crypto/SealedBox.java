package org.libsodium.jni.crypto;

import org.libsodium.jni.encoders.Encoder;
import org.libsodium.jni.keys.KeyPair;

import static org.libsodium.jni.NaCl.sodium;
import static org.libsodium.jni.SodiumConstants.SEAL_BYTES;

public class SealedBox {

    private byte[] mPublicKey;

    public SealedBox(byte[] publicKey) {
        if (publicKey == null) {
            throw new IllegalArgumentException("Public key must not be null");
        }
        mPublicKey = publicKey;
    }

    public SealedBox(String publicKey, Encoder encoder) {
        this(encoder.decode(publicKey));
    }

    public byte[] encrypt(byte[] message) {
        byte[] ct = new byte[message.length + SEAL_BYTES];
        if (sodium().crypto_box_seal(ct, message, message.length, mPublicKey) != 0) {
            throw new IllegalArgumentException("Failed to encrypt");
        }
        return ct;
    }

    public static byte[] decrypt(byte[] ciphertext, byte[] pubicKey, byte[] privateKey) {
        byte[] message = new byte[ciphertext.length - SEAL_BYTES];
        if (sodium().crypto_box_seal_open(
                message, ciphertext, ciphertext.length, pubicKey, privateKey) != 0) {
            throw new IllegalArgumentException(
                    "Failed to decrypt, ensure to provide the correct combination of parameters");
        }
        return message;
    }

    public static byte[] decrypt(byte[] ciphertext, KeyPair keyPair) {
        return decrypt(ciphertext, keyPair.getPublicKey().toBytes(),
                keyPair.getPrivateKey().toBytes());
    }
}
