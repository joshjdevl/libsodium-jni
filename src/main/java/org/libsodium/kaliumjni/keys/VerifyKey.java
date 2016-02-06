/**
 * Copyright 2013 Bruno Oliveira, and individual contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.libsodium.kaliumjni.keys;


import org.libsodium.kaliumjni.encoders.Encoder;
import org.libsodium.kaliumjni.crypto.Util;

import static org.libsodium.kaliumjni.SodiumConstants.PUBLICKEY_BYTES;
import static org.libsodium.kaliumjni.SodiumConstants.SIGNATURE_BYTES;
import static org.libsodium.kaliumjni.NaCl.sodium;

public class VerifyKey {

    private byte[] key;

    public VerifyKey(byte[] key) {
        Util.checkLength(key, PUBLICKEY_BYTES);
        this.key = key;
    }

    public VerifyKey(String key, Encoder encoder) {
        this(encoder.decode(key));
    }

    public boolean verify(byte[] message, byte[] signature) {
        Util.checkLength(signature, SIGNATURE_BYTES);
        byte[] sigAndMsg = Util.merge(signature, message);
        byte[] buffer = Util.zeros(sigAndMsg.length);
        int[] bufferLen = new int[1];

        return Util.isValid(sodium().crypto_sign_ed25519_open(buffer, bufferLen, sigAndMsg, sigAndMsg.length, key), "signature was forged or corrupted");
    }

    public boolean verify(String message, String signature, Encoder encoder) {
        return verify(encoder.decode(message), encoder.decode(signature));
    }

    public byte[] toBytes() {
        return key;
    }

    @Override
    public String toString(){
        return Encoder.HEX.encode(key);
    }
}
