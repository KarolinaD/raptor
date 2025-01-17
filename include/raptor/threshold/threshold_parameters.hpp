// -----------------------------------------------------------------------------------------------------
// Copyright (c) 2006-2022, Knut Reinert & Freie Universität Berlin
// Copyright (c) 2016-2022, Knut Reinert & MPI für molekulare Genetik
// This file may be used, modified and/or redistributed under the terms of the 3-clause BSD-License
// shipped with this file and also available at: https://github.com/seqan/raptor/blob/master/LICENSE.md
// -----------------------------------------------------------------------------------------------------

#pragma once

#include <filesystem>

#include <seqan3/search/kmer_index/shape.hpp>

namespace raptor::threshold
{

struct threshold_parameters
{
    // Basic.
    uint32_t window_size{};
    seqan3::shape shape{};
    uint64_t pattern_size{};

    // Threshold.
    uint8_t errors{}; // threshold_kinds::(probabilistic|lemma)
    double percentage{std::numeric_limits<double>::quiet_NaN()}; // threshold_kinds::percentage
    double p_max{}; // threshold_kinds::probabilistic
    double fpr{}; // threshold_kinds::probabilistic
    double tau{}; // threshold_kinds::probabilistic

    // Cache results.
    bool cache_thresholds{};
    std::filesystem::path output_directory{};
};

} // namespace raptor::threshold
