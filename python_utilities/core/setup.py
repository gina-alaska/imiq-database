"""
setup script
"""
try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

import posthaste as ph

config = {
    'description': 'python tools for Imiq database',
    'author': 'GINA',
    'url': '',
    'download_url': '',
    'author_email': 'TODO',
    'version': ph.__version__,
    'install_requires': ['psycopg2','pandas',],
    'packages': ['posthaste'],
    'scripts': [],
    'name': 'posthaste'
}

setup(**config)
