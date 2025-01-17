// -----------------------------------------------------------------------------------------------------
// Copyright (c) 2006-2022, Knut Reinert & Freie Universität Berlin
// Copyright (c) 2016-2022, Knut Reinert & MPI für molekulare Genetik
// This file may be used, modified and/or redistributed under the terms of the 3-clause BSD-License
// shipped with this file and also available at: https://github.com/seqan/raptor/blob/master/LICENSE.md
// -----------------------------------------------------------------------------------------------------

#pragma once

#include <raptor/threshold/precompute_correction.hpp>
#include <raptor/threshold/precompute_threshold.hpp>

namespace raptor::threshold
{

class threshold
{
public:
    threshold() = default;
    threshold(threshold const &) = default;
    threshold & operator=(threshold const &) = default;
    threshold(threshold &&) = default;
    threshold & operator=(threshold &&) = default;
    ~threshold() = default;

    threshold(threshold_parameters const & arguments)
    {
        uint8_t const kmer_size{arguments.shape.size()};
        size_t const kmers_per_window = arguments.window_size - kmer_size + 1;

        if (!std::isnan(arguments.percentage))
        {
            threshold_kind = threshold_kinds::percentage;
            threshold_percentage = arguments.percentage;
        }
        else if (kmers_per_window == 1u)
        {
            threshold_kind = threshold_kinds::lemma;
            size_t const kmer_lemma_minuend = arguments.pattern_size + 1u;
            size_t const kmer_lemma_subtrahend = (arguments.errors + 1u) * kmer_size;
            kmer_lemma = kmer_lemma_minuend > kmer_lemma_subtrahend ?
                         kmer_lemma_minuend - kmer_lemma_subtrahend :
                         0;
        }
        else
        {
            threshold_kind = threshold_kinds::probabilistic;
            size_t const kmers_per_pattern = arguments.pattern_size - kmer_size + 1;
            minimal_number_of_minimizers = kmers_per_pattern / kmers_per_window;
            maximal_number_of_minimizers = arguments.pattern_size - arguments.window_size + 1;
            precomp_correction = precompute_correction(arguments);
            precomp_thresholds = precompute_threshold(arguments);
        }
    }

    size_t get(size_t const minimiser_count) const noexcept
    {
        switch (threshold_kind)
        {
            case threshold_kinds::lemma:
                return kmer_lemma;
            case threshold_kinds::percentage:
                return static_cast<size_t>(minimiser_count * threshold_percentage);
            default:
            {
                assert(threshold_kind == threshold_kinds::probabilistic);
                size_t const index = std::clamp(minimiser_count,
                                                minimal_number_of_minimizers,
                                                maximal_number_of_minimizers) - minimal_number_of_minimizers;
                return precomp_thresholds[index] + precomp_correction[index];
            }
        }
    }

private:
    enum class threshold_kinds
    {
        probabilistic,
        lemma,
        percentage
    };

    threshold_kinds threshold_kind{threshold_kinds::probabilistic};
    std::vector<size_t> precomp_correction{};
    std::vector<size_t> precomp_thresholds{};
    size_t kmer_lemma{};
    size_t minimal_number_of_minimizers{};
    size_t maximal_number_of_minimizers{};
    double threshold_percentage{};
};

} // namespace raptor::threshold
