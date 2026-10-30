// Q5: Non-blocking ADC driver template.
// Replace addresses and ISR registration with the actual peripheral map/SoC IRQ vector.
#include <stdint.h>
#define ADC_CTRL (*(volatile uint32_t *)0x40000000u)
#define ADC_DATA (*(volatile uint32_t *)0x40000004u)
#define ADC_START (1u << 0)
volatile uint32_t adc_sample;
volatile uint32_t adc_sample_ready;
extern uint32_t adc_irq_save(void);
extern void adc_irq_restore(uint32_t state);
void adc_start_conversion(void) { adc_sample_ready = 0; ADC_CTRL = ADC_START; }
void adc_interrupt_handler(void) { adc_sample = ADC_DATA; adc_sample_ready = 1; }
static int32_t fixed_point_filter(int32_t y, int32_t x) { return y + ((x - y) >> 2); }
int main(void) {
    int32_t filtered = 0; adc_start_conversion();
    for (;;) {
        uint32_t irq_state = adc_irq_save(); uint32_t have_sample = adc_sample_ready; uint32_t sample = adc_sample;
        if (have_sample) adc_sample_ready = 0;
        adc_irq_restore(irq_state);
        if (have_sample) { filtered = fixed_point_filter(filtered, (int32_t)sample); adc_start_conversion(); }
        (void)filtered;
    }
}
