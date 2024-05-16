#include <stdio.h>
#include <string.h>
#include <openssl/hmac.h>
#include <openssl/sha.h>

void print_hex(unsigned char *data, int len) {
    for (int i = 0; i < len; i++) {
        printf("%02x", data[i]);
    }
    printf("\n");
}

int main() {
    // HMAC key and data
    unsigned char *key = (unsigned char *)"secretkey";
    unsigned char *data = (unsigned char *)"data to be authenticated";
    unsigned int len = 32;  // Length of the HMAC output in bytes (e.g., SHA-256 outputs 32 bytes)

    // Buffer for the HMAC output
    unsigned char *result;
    unsigned int result_len;

    // Generate HMAC using SHA-256
    result = HMAC(EVP_sha256(), key, strlen((char *)key), data, strlen((char *)data), NULL, &result_len);

    // Print the full HMAC
    printf("Full HMAC: ");
    print_hex(result, result_len);

    // Using only the first 16 bits (2 bytes)
    printf("First 16 bits: ");
    print_hex(result, 2);  // Only print the first 2 bytes

    // Assume the rest is stored elsewhere or used differently
    printf("Rest of HMAC: ");
    print_hex(result + 2, result_len - 2);  // Print the rest of the HMAC

    return 0;
}