"""
setup script
"""
try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

import to_timeseries as mod

config = {
    'description': 
        'tools for updating summaries and other metric/aggrate tables',
    'author': 'GINA',
    'url': '',
    'download_url': '',
    'author_email': 'support@gina.alaska.edu',
    'version': mod.__version__,
    'install_requires': ['pandas'],
    'packages': ['summary_updater'],
    'scripts': ['bin/run-sql','bin/summary-updater','bin/check-activity'],
    'name': 'summary-updater'
}

setup(**config)
