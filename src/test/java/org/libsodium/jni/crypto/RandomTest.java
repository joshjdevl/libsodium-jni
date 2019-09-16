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

package org.libsodium.jni.crypto;

import org.junit.Test;
import org.libsodium.jni.fixture.TestVectors;

import static org.libsodium.jni.encoders.Encoder.HEX;
import static org.libsodium.jni.crypto.Util.isValid;

import java.util.Arrays;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

public class RandomTest {

    @Test
    public void testProducesRandomBytes() throws Exception {
        final int size = 16;
        assertEquals("Invalid random bytes", size, new Random().randomBytes(size).length);
    }

    @Test
    public void testProducesDefaultRandomBytes() throws Exception {
        final int size = 32;
        assertEquals("Invalid random bytes", size, new Random().randomBytes().length);
    }

    @Test
    public void testProducesDifferentRandomBytes() throws Exception {
        final int size = 16;
        assertFalse("Should produce different random bytes", Arrays.equals(new Random().randomBytes(size), new Random().randomBytes(size)));
    }

    @Test
    public void testProducesDifferentDefaultRandomBytes() throws Exception {
        final int size = 32;
        assertFalse("Should produce different random bytes", Arrays.equals(new Random().randomBytes(), new Random().randomBytes(size)));
    }

    @Test
    public void testDeterministicRandomBytes() throws Exception {
        byte[] seed = HEX.decode(TestVectors.RANDOMBYTES_SEED);
        byte[] expected = HEX.decode(TestVectors.DETERMINISTIC_RANDOMBYTES);
        assertTrue("Should produce the expected bytes", Arrays.equals(new Random().randomBytesDeterministic(seed, 100), expected));
    }

    @Test(expected = RuntimeException.class)
    public void testDeterministicRandomBytesInvalidSeedLength() throws Exception {
        byte[] seed = HEX.decode("000102030405060708090a");
        new Random().randomBytesDeterministic(seed, 100);
        fail("Should raise an exception");
    }
    
}
