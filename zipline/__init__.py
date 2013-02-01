"""
Zipline
"""

# This is *not* a place to dump arbitrary classes/modules for convenience,
# it is a place to expose the public interfaces.

from .utils.protocol_utils import ndict

import zipline.data
import zipline.finance
import zipline.gens
import zipline.utils

__all__ = [
    'ndict',
    'data',
    'finance',
    'gens',
    'utils'
]
