# -*- coding: utf-8 -*-
#
# This file is part of pyunicorn.
# Copyright (C) 2008--2022 Jonathan F. Donges and pyunicorn authors
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

cimport cython

import numpy as np
cimport numpy as np

from ...core._ext.types import FIELD, DFIELD
from ...core._ext.types cimport MASK_t, FIELD_t, DFIELD_t

cdef extern from "src_numerics.c":
    void _cython_calculate_mutual_information(
            float *anomaly, int n_samples, int N, int n_bins, double scaling,
            double range_min, long *symbolic, long *hist, long *hist2d,
            float *mi)
    void _calculate_corr_fast(int m, int tmax, bint *final_mask,
            float *time_series_ranked, float *spearman_rho)


# mutual_info =================================================================

def _calculate_mutual_information_cython(
    np.ndarray[FIELD_t, ndim=2, mode='c'] anomaly not None,
    int n_samples, int N, int n_bins, double scaling, double range_min):

    cdef:
        np.ndarray[DFIELD_t, ndim=2, mode='c'] symbolic = np.zeros(
            (N, n_samples), dtype=DFIELD)
        np.ndarray[DFIELD_t, ndim=2, mode='c'] hist = np.zeros(
            (N, n_bins), dtype=DFIELD)
        np.ndarray[DFIELD_t, ndim=2, mode='c'] hist2d = np.zeros(
            (n_bins, n_bins), dtype=DFIELD)
        np.ndarray[FIELD_t, ndim=2, mode='c'] mi = np.zeros(
            (N, N), dtype=FIELD)

    _cython_calculate_mutual_information(
        <float*> np.PyArray_DATA(anomaly), n_samples, N, n_bins, scaling,
        range_min, <long*> np.PyArray_DATA(symbolic),
        <long*> np.PyArray_DATA(hist), <long*> np.PyArray_DATA(hist2d),
        <float*> np.PyArray_DATA(mi))

    return mi


# rainfall ====================================================================

def _calculate_corr(int m, int tmax,
    np.ndarray[MASK_t, ndim=2, mode='c'] final_mask not None,
    np.ndarray[FIELD_t, ndim=2, mode='c'] time_series_ranked not None):

    cdef np.ndarray[FIELD_t, ndim=2, mode='c'] spearman_rho = np.zeros(
        (m, m), dtype=FIELD)

    _calculate_corr_fast(m, tmax,
            <bint*> np.PyArray_DATA(final_mask),
            <float*> np.PyArray_DATA(time_series_ranked),
            <float*> np.PyArray_DATA(spearman_rho))

    return spearman_rho
