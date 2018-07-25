"""setup script
"""
from setuptools import setup, find_packages

setup(
    name="utilitools",
    version="0.1.0",
    packages=find_packages(),
    scripts=['bin/posthaste'],
    
    #~ entry_points = {
        #~ 'console_scripts': ['posthaste=utilitools.posthaste:utility'],
    #~ },

    # Project uses reStructuredText, so ensure that the docutils get
    # installed or upgraded on the target machine
    install_requires=['pyyaml', 'psycopg2'],

    package_data={},

    # metadata for upload to PyPI
    author="Rawser Spicer",
    author_email="rwspicer@alaska.edu",
    description="Some Usefull Tools for building python command line utilities",
    license="MIT",
    keywords="Utilities",
    url="",   # project home page, if any

    # could also include long_description, download_url, classifiers, etc.
)
