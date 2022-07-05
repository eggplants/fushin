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
            extra_link_args=["-s"],
            include_dirs=["."],
        )
    ]
)
