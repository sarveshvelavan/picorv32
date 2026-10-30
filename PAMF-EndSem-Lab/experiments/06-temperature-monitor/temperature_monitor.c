// Q6: Firmware temperature monitor.
// Assumes TEMP_RAW is signed Q8.8 and LED_REG is an output register.
#include <stdint.h>
#define TEMP_RAW (*(volatile int32_t *)0x40000010u)
#define LED_REG (*(volatile uint32_t *)0x40000020u)
#define LIMIT_Q8 (40 * 256)
int main(void) { for (;;) { int32_t temperature_q8 = TEMP_RAW; LED_REG = (temperature_q8 >= LIMIT_Q8) ? 1u : 0u; } }
