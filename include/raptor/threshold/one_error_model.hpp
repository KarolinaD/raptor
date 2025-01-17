// -----------------------------------------------------------------------------------------------------
// Copyright (c) 2006-2022, Knut Reinert & Freie Universität Berlin
// Copyright (c) 2016-2022, Knut Reinert & MPI für molekulare Genetik
// This file may be used, modified and/or redistributed under the terms of the 3-clause BSD-License
// shipped with this file and also available at: https://github.com/seqan/raptor/blob/master/LICENSE.md
// -----------------------------------------------------------------------------------------------------

#pragma once

#include <vector>

namespace raptor::threshold
{

[[nodiscard]] std::vector<double> one_error_model(size_t const kmer_size,
                                                  double const p_mean,
                                                  std::vector<double> const & affected_by_one_error_indirectly_prob);

} // namespace raptor::threshold
