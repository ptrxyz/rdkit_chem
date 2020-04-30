/*
*
*  Copyright (c) 2019, Greg Landrum
*  All rights reserved.
*
*  This file is part of the RDKit.
*  The contents are covered by the terms of the BSD license
*  which is included in the file license.txt, found at the root
*  of the RDKit source tree.
*
*/
%{
#include <GraphMol/RGroupDecomposition/RGroupDecomp.h>
%}

//%template(SparseIntVect64) RDKit::SparseIntVect<boost::int64_t>;

%include <GraphMol/RGroupDecomposition/RGroupDecomp.h>
