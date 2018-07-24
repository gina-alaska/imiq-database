"""
setup script
"""
try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

import data_puller as mod

config = {
    'description': 'tool to pull data from remote sources for processing and ingest into imiq',
    'author': 'GINA',
    'url': '',
    'download_url': '',
    'author_email': 'support@gina.alaska.edu',
    'version': mod.__version__,
    'install_requires': ['pyyaml'],
    'packages': ['data_puller'],
    'scripts': ['bin/data-puller'],
    'name': 'posthaste'
}

setup(**config)
