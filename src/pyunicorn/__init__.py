# This file is part of pyunicorn
# (Unified Complex Network and Recurrence Analysis Toolbox).
#
# Copyright (C) 2008--2019 Jonathan F. Donges and pyunicorn authors
#
# URL: <http://www.pik-potsdam.de/members/donges/software>
# License: BSD (3-clause)
#
# Please acknowledge and cite the use of this software and its authors
# when results are used in publications or published elsewhere.
#
# You can use the following reference:
# J.F. Donges, J. Heitzig, B. Beronov, M. Wiedermann, J. Runge, Q.-Y. Feng,
# L. Tupikina, V. Stolbova, R.V. Donner, N. Marwan, H.A. Dijkstra,
# and J. Kurths, "Unified functional network and nonlinear time series analysis
# for complex systems science: The pyunicorn package"

"""
pyunicorn
=========


Subpackages
-----------
core
    Spatially embedded complex networks and multivariate data
climate
    Climate networks
funcnet
    Functional networks
timeseries
    Time series surrogates

To Do
-----
   - A lot - See current product backlog.
   - Clean up MapPlots class -> Alex!?

"""
import os
import sys

#from setup import __version__   #直接隐藏这段代码，测试文件《recurrence_network》正常运行

from .utils import mpi
from .core import *

sys.path.insert(0, os.path.abspath('../..'))


__author__ = "Jonathan F. Donges <donges@pik-potsdam.de>"
__copyright__ = \
    "Copyright (C) 2008-2019 Jonathan F. Donges and pyunicorn authors"
__license__ = "BSD (3-clause)"
__url__ = "http://www.pik-potsdam.de/members/donges/software"
__docformat__ = "restructuredtext en"
