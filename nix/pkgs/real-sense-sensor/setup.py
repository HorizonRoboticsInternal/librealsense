from setuptools import setup, find_packages
from pybind11.setup_helpers import Pybind11Extension, build_ext

setup(
    name="real-sense-sensor",
    version="1.0.0",
    python_requires=">=3.8.0",
    install_requires=[],
    ext_modules=[
        Pybind11Extension(
            "real_sense_sensor",
            sources=["src/real_sense_sensor.cpp"],
            extra_compile_args=[
                "-O3", "-Wall", "-shared", "-std=c++17",
                "-fPIC", "-fvisibility=hidden", "-lrt"
                "-lrealsense2-net", "-lrealsense2"
            ])
    ],
    cmdclass={"build_ext": build_ext},
    packages=find_packages(),
)
