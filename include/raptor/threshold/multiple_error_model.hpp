// -----------------------------------------------------------------------------------------------------
// Copyright (c) 2006-2022, Knut Reinert & Freie Universität Berlin
// Copyright (c) 2016-2022, Knut Reinert & MPI für molekulare Genetik
// This file may be used, modified and/or redistributed under the terms of the 3-clause BSD-License
// shipped with this file and also available at: https://github.com/seqan/raptor/blob/master/LICENSE.md
// -----------------------------------------------------------------------------------------------------

#pragma once

#include <cstddef>
#include <vector>

namespace raptor::threshold
{

[[nodiscard]] std::vector<double> multiple_error_model(size_t const number_of_minimisers,
                                                       size_t const errors,
                                                       std::vector<double> const & affected_by_one_error_prob);

} // namespace raptor::threshold
