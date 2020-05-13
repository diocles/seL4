#
# Copyright 2020, Data61, CSIRO (ABN 41 687 119 230)
#
# SPDX-License-Identifier: GPL-2.0-only
#

cmake_minimum_required(VERSION 3.7.2)

declare_platform(bcm2836 KernelPlatformRpi2 PLAT_BCM2836 KernelArchARM)

if(KernelPlatformRpi2)
    declare_seL4_arch(aarch32)
    set(KernelArmCortexA7 ON)
    set(KernelArchArmV7a ON)
    config_set(KernelARMPlatform ARM_PLAT rpi2)
    list(APPEND KernelDTSList "tools/dts/rpi2.dts")
    list(APPEND KernelDTSList "src/plat/bcm2836/overlay-rpi2.dts")

    declare_default_headers(
        TIMER_FREQUENCY 19200000llu
        MAX_IRQ 127
        NUM_PPI 32
        TIMER drivers/timer/arm_generic.h
        INTERRUPT_CONTROLLER drivers/irq/bcm2836-armctrl-ic.h
        KERNEL_WCET 10u
        CLK_MAGIC 458129845llu
        CLK_SHIFT 43u
    )
endif()

add_sources(
    DEP "KernelPlatformRpi2"
    CFILES src/plat/bcm2836/machine/intc.c src/arch/arm/machine/l2c_nop.c
)
