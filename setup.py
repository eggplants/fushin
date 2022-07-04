from os import listdir

from setuptools import Extension, setup

sources = []
for c_source_file in listdir():
    if c_source_file.endswith(".c"):
        sources.append(c_source_file)

setup(
    ext_modules=[
        Extension(
            name="fushin",
            sources=sources,
            extra_compile_args=[
                "-flto",
                "-ffast-math",
                "-march=native",
                "-mtune=native",
                "-O3",
                "-fno-ident",
                "-fsingle-precision-constant",
            ],  # Change it to your project needs.
            extra_link_args=["-s"],
            include_dirs=["."],
        )
    ]
)
