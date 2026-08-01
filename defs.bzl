load("//build/kernel/kleaf:kernel.bzl", "kernel_module")

def qca6174_sdio_module(name, kernel_build, deps = None):
    kernel_module(
        name = name,
        srcs = ["//vendor/amlogic/qca6174-driver:qca6174_srcs"],
        makefile = ["//vendor/amlogic/qca6174-driver:Makefile"],
        deps = deps,
        outs = ["wlan_6174.ko"],
        kernel_build = kernel_build,
    )
