"""
setup script
"""
try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

#~ import posthaste as ph
import y2i

config = {
    'description': 'YAML to sql insert script tool',
    'author': 'GINA',
    'url': '',
    'download_url': '',
    'author_email': 'TODO',
    'version': y2i.__version__,
    'install_requires': ['psycopg2','pandas',],
    'packages': ['y2i'],
    'scripts': [],
    'name': 'y2i'
}

setup(**config)
