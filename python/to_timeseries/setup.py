"""
setup script
"""
try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

import to_timeseries as mod

config = {
    'description': 'converts data to csv for processing and ingest into imiq',
    'author': 'GINA',
    'url': '',
    'download_url': '',
    'author_email': 'support@gina.alaska.edu',
    'version': mod.__version__,
    'install_requires': ['pandas'],
    'packages': ['to_timeseries'],
    'scripts': ['bin/to-timeseries'],
    'name': 'to_timeseries'
}

setup(**config)
