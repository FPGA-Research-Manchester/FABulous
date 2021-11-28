# Configuration file for the Sphinx documentation builder.

# -- Project information

# project = 'FABulous Dokumentation'
project = 'FABulous Dokumentation'
copyright = '2021, University of Manchester'
author = 'Jing, Nguyen, Bea, Bardia, Dirk'

release = '0.1'
version = '0.1.0'

# -- General configuration

extensions = [
    'sphinx.ext.duration',
    'sphinx.ext.doctest',
    'sphinx.ext.autodoc',
    'sphinx.ext.autosummary',
    'sphinx.ext.intersphinx',
    'sphinxcontrib.bibtex',
]

intersphinx_mapping = {
    'python': ('https://docs.python.org/3/', None),
    'sphinx': ('https://www.sphinx-doc.org/en/master/', None),
}
intersphinx_disabled_domains = ['std']

templates_path = ['_templates']

# -- Options for HTML output

html_theme = 'sphinx_materialdesign_theme'

html_logo = 'figs/FAB_logo.png'


# -- Options for EPUB output
epub_show_urls = 'footnote'

bibtex_bibfiles = ['publications.bib']
