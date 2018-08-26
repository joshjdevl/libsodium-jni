package org.libsodium.jni.crypto;

import org.junit.Test;
import static org.junit.Assert.assertEquals;

import org.libsodium.jni.NaCl;
import org.libsodium.jni.Sodium;

public class AeadTest {

    public static final String message = "Test Message";


    @Test
    public void XChaCha20Poly1305IeftKeygen() {
        Sodium sodium= NaCl.sodium();

        byte[] key = new byte[Sodium.crypto_aead_xchacha20poly1305_ietf_keybytes()];

        Sodium.crypto_aead_xchacha20poly1305_ietf_keygen(key);

        assertEquals(key.length, Sodium.crypto_aead_xchacha20poly1305_ietf_keybytes());
    }

    @Test
    public void XChaCha20Poly1305Ieft() {
        Sodium sodium= NaCl.sodium();

        byte[] nonce = new byte[Sodium.crypto_aead_xchacha20poly1305_ietf_npubbytes()];
        byte[] key = new byte[Sodium.crypto_aead_xchacha20poly1305_ietf_keybytes()];
        Sodium.randombytes_buf(nonce, nonce.length);
        Sodium.randombytes_buf(key, key.length);

        int mlen = message.length();
        int[] clen_p = new int[0];
        byte[] c = new byte[mlen + Sodium.crypto_aead_xchacha20poly1305_ietf_abytes()];

        int encryptReturn = Sodium.crypto_aead_xchacha20poly1305_ietf_encrypt(c, clen_p, message.getBytes(), mlen, new byte[0], 0, new byte[0], nonce, key);

        assertEquals(0, encryptReturn);

        byte[] m = new byte[message.length()];

        int[] mlen_p = new int[1];

        Sodium.crypto_aead_xchacha20poly1305_ietf_decrypt(m, mlen_p, new byte[0], c, c.length, new byte[0], 0, nonce, key);
        assertEquals(message, new String(m));
    }

    @Test
    public void XChaCha20Poly1305IeftDetached() {
        Sodium sodium= NaCl.sodium();

        int mlen = message.length();
        byte[] c = new byte[mlen + Sodium.crypto_aead_xchacha20poly1305_ietf_abytes()];

        byte[] mac = new byte[Sodium.crypto_aead_xchacha20poly1305_ietf_abytes()];

        int[] maclen_p = new int[1];

        byte[] nonce = new byte[Sodium.crypto_aead_xchacha20poly1305_ietf_npubbytes()];
        byte[] key = new byte[Sodium.crypto_aead_xchacha20poly1305_ietf_keybytes()];
        Sodium.randombytes_buf(nonce, nonce.length);
        Sodium.randombytes_buf(key, key.length);

        int encryptDetachedReturn = Sodium.crypto_aead_xchacha20poly1305_ietf_encrypt_detached(c, mac, maclen_p, message.getBytes(), mlen, new byte[0], 0, new byte[0], nonce, key);
        assertEquals(0, encryptDetachedReturn);

        byte[] m = new byte[message.length()];

        Sodium.crypto_aead_xchacha20poly1305_ietf_decrypt_detached(m, new byte[0], c, mlen, mac, new byte[0], 0, nonce, key);
        assertEquals(message, new String(m));


    }
}