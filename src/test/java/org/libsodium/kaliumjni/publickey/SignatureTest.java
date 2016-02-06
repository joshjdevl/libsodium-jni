package org.libsodium.kaliumjni.publickey;

import org.libsodium.kaliumjni.NaCl;
import org.libsodium.kaliumjni.Sodium;
import org.junit.Assert;
import org.junit.Test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Created by joshjdevl on 1/24/16.
 */
public class SignatureTest {

    @Test
    public void testCombinedSignature() {
        Sodium sodium= NaCl.sodium();
        int ret=0;

        long publickeylen=Sodium.crypto_sign_publickeybytes();
        long privatekeylen=Sodium.crypto_sign_secretkeybytes();
        System.out.println("PublicKeyLen="+publickeylen);
        System.out.println("PrivateKeyLen="+privatekeylen);
        final byte[] public_key=new byte[(int)publickeylen];
        final byte[] private_key=new byte[(int)privatekeylen];
        System.out.println("Generating keypair");
        Sodium.randombytes(public_key,(int)publickeylen);
        Sodium.randombytes(private_key,(int)privatekeylen);
        ret=Sodium.crypto_sign_keypair(public_key,private_key);
        System.out.println(ret);
        System.out.println("Generated keypair");

        byte[] originalmessage="test".getBytes();
        System.out.println("Original message="+new String(originalmessage));
        long signaturelen=Sodium.crypto_sign_bytes();
        byte[] signed_message=new byte[(int)signaturelen+originalmessage.length];
        final int[] signed_message_len = new int[1];
        System.out.println("Signing message");
        ret=Sodium.crypto_sign(signed_message,signed_message_len,originalmessage,originalmessage.length,private_key);
        System.out.println(ret);
        System.out.println("byte length="+signed_message.length);
        System.out.println("signed message size="+signed_message_len[0]);
        Assert.assertEquals(signed_message.length,signed_message_len[0]);
        System.out.println("Signed message=");

        byte[] message=new byte[originalmessage.length];
        final int[] messageSize=new int[1];
        System.out.println("Verifying message");
        ret=Sodium.crypto_sign_open(message, messageSize, signed_message, signed_message_len[0], public_key);
        System.out.println(ret);
        System.out.println("Recovered message="+new String(message));
        Assert.assertEquals(0,ret);
    }

    @Test
    public void testSignatureFromFile() throws IOException {
        Sodium sodium= NaCl.sodium();
        int ret=0;

        long publickeylen=Sodium.crypto_sign_publickeybytes();
        long privatekeylen=Sodium.crypto_sign_secretkeybytes();
        System.out.println("PublicKeyLen="+publickeylen);
        System.out.println("PrivateKeyLen="+privatekeylen);
        final byte[] public_key=new byte[(int)publickeylen];
        final byte[] private_key=new byte[(int)privatekeylen];
        System.out.println("Generating keypair");
        Sodium.randombytes(public_key,(int)publickeylen);
        Sodium.randombytes(private_key,(int)privatekeylen);
        ret=Sodium.crypto_sign_keypair(public_key,private_key);
        System.out.println(ret);
        System.out.println("Generated keypair");

        Path public_key_path= Paths.get("public.key");
        Files.write(public_key_path,public_key);

        Path private_key_path = Paths.get("private.key");
        Files.write(private_key_path,private_key);

        byte[] public_key_fromfile = Files.readAllBytes(public_key_path);

        byte[] originalmessage="test".getBytes();
        System.out.println("Original message="+new String(originalmessage));
        long signaturelen=Sodium.crypto_sign_bytes();
        byte[] signed_message=new byte[(int)signaturelen+originalmessage.length];
        final int[] signed_message_len = new int[1];
        System.out.println("Signing message");
        ret=Sodium.crypto_sign(signed_message,signed_message_len,originalmessage,originalmessage.length,private_key);
        System.out.println(ret);
        System.out.println("byte length="+signed_message.length);
        System.out.println("signed message size="+signed_message_len[0]);
        Assert.assertEquals(signed_message.length,signed_message_len[0]);
        System.out.println("Signed message=");

        byte[] message=new byte[originalmessage.length];
        final int[] messageSize=new int[1];
        System.out.println("Verifying message");
        ret=Sodium.crypto_sign_open(message, messageSize, signed_message, signed_message_len[0], public_key_fromfile);
        System.out.println(ret);
        System.out.println("Recovered message="+new String(message));
        Assert.assertEquals(0,ret);
    }
}
