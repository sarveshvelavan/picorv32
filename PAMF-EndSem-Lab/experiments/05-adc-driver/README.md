# Q5 — Interrupt-driven ADC firmware

`adc_driver.c` uses example ADC MMIO addresses `0x40000000` (control) and `0x40000004` (data). It does not poll an end-of-conversion bit. The platform's ADC IRQ handler calls `adc_interrupt_handler()`.

The platform must implement `adc_irq_save()` and `adc_irq_restore()` to briefly mask and restore the ADC interrupt while the foreground code snapshots the sample/ready flag. The interrupt vector/assembly wrapper is also platform-specific, especially for PicoRV32's custom IRQ mechanism.
