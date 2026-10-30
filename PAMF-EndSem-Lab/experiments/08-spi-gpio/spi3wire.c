// Q8: Bit-bang four-bit command 1011, MSB first.
// GPIO bit map: SCLK=bit0, MOSI=bit1, CS=bit2 at 0x40000020.
// Assumes CS is active-low and sensor samples on rising SCLK edge.
#include <stdint.h>
#define GPIO (*(volatile uint32_t *)0x40000020u)
#define SCLK (1u << 0)
#define MOSI (1u << 1)
#define CS (1u << 2)
static void short_delay(void) { for (volatile unsigned int i=0; i<10; ++i) { } }
void sensor_send_config(void) {
    const uint8_t command=0x0B; GPIO=CS; short_delay(); GPIO=0; short_delay();
    for (int bit=3; bit>=0; --bit) { uint32_t data=((command>>bit)&1u)?MOSI:0u; GPIO=data; short_delay(); GPIO=data|SCLK; short_delay(); GPIO=data; short_delay(); }
    GPIO=CS;
}
