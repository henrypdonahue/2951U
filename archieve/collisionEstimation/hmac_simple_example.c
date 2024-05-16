#include <stdio.h>
#include <string.h>
#include <openssl/hmac.h>
#include <openssl/sha.h>

int main() {
    // Key for HMAC
    unsigned char *key = (unsigned char *)"mysecretkey";
    // Data to be hashed
    unsigned char *data = (unsigned char *)"Data to be hashed";
    unsigned int len = 20;  // Length of the output hash

    // Buffer for the HMAC output
    unsigned char *result;
    unsigned int result_len = -1;

    // Generate HMAC
    result = HMAC(EVP_sha256(), key, strlen((char *)key), data, strlen((char *)data), NULL, &result_len);

    // Display the full HMAC
    printf("Full HMAC: ");
    for (int i = 0; i < result_len; i++) {
        printf("%02x", result[i]);
    }
    printf("\n");

    // Assuming you want to store the first 16 bits and then the rest elsewhere
    printf("First 16 bits: ");
    for (int i = 0; i < 2; i++) {  // 16 bits = 2 bytes
        printf("%02x", result[i]);
    }
    printf("\n");

    // Store the rest
    printf("Rest of HMAC: ");
    for (int i = 2; i < result_len; i++) {
        printf("%02x", result[i]);
    }
    printf("\n");

    return 0;
}