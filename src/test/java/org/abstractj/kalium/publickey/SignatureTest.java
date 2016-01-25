package org.abstractj.kalium.publickey;

import org.abstractj.kalium.NaCl;
import org.abstractj.kalium.Sodium;
import org.junit.Assert;
import org.junit.Test;

/**
 * Created by joshjdevl on 1/24/16.
 */
public class SignatureTest {
    @Test
    public void testCombinedSignature() {
        Sodium sodium= NaCl.sodium();
        long publickeylen=Sodium.crypto_box_publickeybytes();
        long privatekeylen=Sodium.crypto_box_secretkeybytes();
        byte[] public_key=new byte[(int)publickeylen+1];
        byte[] private_key=new byte[(int)privatekeylen+1];
        System.out.println("Generating keypair");
        int ret=Sodium.crypto_sign_keypair(public_key,private_key);
        System.out.println(ret);
        System.out.println("Generated keypair");

        byte[] originalmessage="test".getBytes();
        System.out.println("Original message="+new String(originalmessage));
        long signaturelen=Sodium.crypto_sign_bytes();
        byte[] signed_message=new byte[(int)signaturelen+originalmessage.length];
        final int[] signed_message_len = new int[1];
        System.out.println("Signing message");
        /*
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
        */
    }
}
