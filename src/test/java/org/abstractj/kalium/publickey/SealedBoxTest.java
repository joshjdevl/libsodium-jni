package org.abstractj.kalium.publickey;

import org.abstractj.kalium.NaCl;
import org.abstractj.kalium.Sodium;
import org.junit.Assert;
import org.junit.Test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Created by joshjdevl on 2/5/16.
 */
public class SealedBoxTest {

    @Test
    public void testSealedBox() {
        Sodium sodium= NaCl.sodium();
        int ret=0;

        long publickeylen=Sodium.crypto_box_publickeybytes();
        long privatekeylen=Sodium.crypto_box_secretkeybytes();
        final byte[] public_key=new byte[(int)publickeylen];
        final byte[] private_key=new byte[(int)privatekeylen];

        Sodium.crypto_box_keypair(public_key,private_key);

        String message="testmessage";

        byte[] ciphertext=new byte[Sodium.crypto_box_sealbytes()+message.length()];
        Sodium.crypto_box_seal(ciphertext,message.getBytes(),message.length(),public_key);

        byte[] plaintext=new byte[message.length()];
        ret=Sodium.crypto_box_seal_open(plaintext,ciphertext,ciphertext.length,public_key,private_key);
        Assert.assertEquals(0,ret);
    }

    @Test
    public void testSealedBoxFile() throws IOException {
        Sodium sodium= NaCl.sodium();
        int ret=0;

        long publickeylen=Sodium.crypto_box_publickeybytes();
        long privatekeylen=Sodium.crypto_box_secretkeybytes();
        final byte[] public_key=new byte[(int)publickeylen];
        final byte[] private_key=new byte[(int)privatekeylen];

        Sodium.crypto_box_keypair(public_key,private_key);

        Path public_key_path= Paths.get("box_public.key");
        Files.write(public_key_path,public_key);

        Path private_key_path = Paths.get("box_private.key");
        Files.write(private_key_path,private_key);

        byte[] public_key_fromfile = Files.readAllBytes(public_key_path);
        byte[] private_key_fromfile = Files.readAllBytes(private_key_path);

        String message="testmessage";

        byte[] ciphertext=new byte[Sodium.crypto_box_sealbytes()+message.length()];
        Sodium.crypto_box_seal(ciphertext,message.getBytes(),message.length(),public_key_fromfile);

        byte[] plaintext=new byte[message.length()];
        ret=Sodium.crypto_box_seal_open(plaintext,ciphertext,ciphertext.length,public_key_fromfile,private_key_fromfile);
        Assert.assertEquals(0,ret);
    }
}
