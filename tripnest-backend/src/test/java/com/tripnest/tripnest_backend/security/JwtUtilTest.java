package com.tripnest.tripnest_backend.security;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.test.util.ReflectionTestUtils;

import static org.junit.jupiter.api.Assertions.*;

class JwtUtilTest {

    private JwtUtil jwtUtil;

    @BeforeEach
    void setUp() {
        jwtUtil = new JwtUtil();
        // Set standard 256-bit test secret (64 hex characters)
        ReflectionTestUtils.setField(jwtUtil, "secret", "404E635266556A586E3272357538782F413F4428472B4B6250645367566B5970");
        ReflectionTestUtils.setField(jwtUtil, "expiration", 86400000L);
    }

    @Test
    void generateToken_extractEmail_validatesCorrectly() {
        String email = "traveler@example.com";
        String token = jwtUtil.generateToken(email);

        assertNotNull(token);
        assertFalse(token.isBlank());

        String extracted = jwtUtil.extractEmail(token);
        assertEquals(email, extracted);

        assertTrue(jwtUtil.isTokenValid(token, email));
        assertFalse(jwtUtil.isTokenValid(token, "other@example.com"));
    }
}
