"""
setup script
"""

from setuptools import setup,find_packages()


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
    'packages': find_packages(),
    'scripts': ['bin/run-sql','bin/summary-updater','bin/check-activity'],
    'name': 'summary-updater'
}

setup(**config)
