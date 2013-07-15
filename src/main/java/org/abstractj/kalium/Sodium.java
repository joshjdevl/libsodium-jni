package org.abstractj.kalium;

/**
* Created with IntelliJ IDEA.
* User: josh
* Date: 7/14/13
* Time: 7:08 PM
* To change this template use File | Settings | File Templates.
*/
public class Sodium {

    public native String sodium_version_string();

    public static final int SHA256BYTES = 32;

    public native int crypto_hash_sha256_ref( byte[] buffer,  byte[] message,  long sizeof);

    public static final int SHA512BYTES = 64;

    public native int crypto_hash_sha512_ref( byte[] buffer,  byte[] message,  long sizeof);


    public static final int BLAKE2B_OUTBYTES = 64;
    public native int crypto_generichash_blake2b( byte[] buffer,  long OutLen,  byte[] message,  long messageLen,
                                           byte[] key,  long keyLen);

    public static final int PUBLICKEY_BYTES = 32;
    public static final int SECRETKEY_BYTES = 32;

    public native int crypto_box_curve25519xsalsa20poly1305_ref_keypair( byte[] publicKey,  byte[] secretKey);


    public static final int NONCE_BYTES = 24;
    public static final int ZERO_BYTES = 32;
    public static final int BOXZERO_BYTES = 16;

    public native void randombytes( byte[] buffer,  long size);

    public native int crypto_box_curve25519xsalsa20poly1305_ref( byte[] ct,  byte[] msg,  long length,  byte[] nonce,
                                                          byte[] publicKey,  byte[] privateKey);

    public native int crypto_box_curve25519xsalsa20poly1305_ref_open( byte[] message,  byte[] ct,  long length,
                                                               byte[] nonce,  byte[] publicKey,  byte[] privateKey);

    public static final int SCALAR_BYTES = 32;

    public native int crypto_scalarmult_curve25519_ref( byte[] result,  byte[] intValue,  byte[] point);

    public static final int XSALSA20_POLY1305_SECRETBOX_KEYBYTES = 32;
    public static final int XSALSA20_POLY1305_SECRETBOX_NONCEBYTES = 24;

    public native int crypto_secretbox_xsalsa20poly1305_ref( byte[] ct,  byte[] msg,  long length,  byte[] nonce,  byte[] key);

    public native int crypto_secretbox_xsalsa20poly1305_ref_open( byte[] message,  byte[] ct,  long length,  byte[] nonce,  byte[] key);

    public static final int SIGNATURE_BYTES = 64;

    public native int crypto_sign_ed25519_ref_seed_keypair( byte[] publicKey,  byte[] secretKey,  byte[] seed);

    //LongLongByReference
    public native int crypto_sign_ed25519_ref( byte[] buffer,  Long bufferLen,  byte[] message,  long length,  byte[] secretKey);

    //LongLongByReference
    public native int crypto_sign_ed25519_ref_open( byte[] buffer,  Long bufferLen,  byte[] sigAndMsg,  long length,  byte[] key);
}
