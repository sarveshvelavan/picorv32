// Q11: Bare-metal LED toggle. Replace address with your board's LED MMIO address.
#include <stdint.h>
#define LED_REG (*(volatile uint32_t *)0x40000020u)
int main(void) {
    uint32_t led = 0;
    for (;;) {
        LED_REG = led;
        for (volatile uint32_t delay = 0; delay < 100000; ++delay) { }
        led ^= 1u;
    }
}
