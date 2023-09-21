// Define the process for simulation and association
process simulateAssoc {
    memory '4 GB'
    cpus 1
    script:
    """
    ./plink --simulate sim${params.i} --make-bed --out sim${params.i} --simulate-ncases 500 --simulate-ncontrols 500 --noweb
    ./plink --bfile sim${params.i} --assoc --out sim${params.i} --noweb
    awk '{print \$2,\$4,\$10}' sim${params.i}.assoc > prs${params.i}
    """
}

// Define the process for PRS processing in R
process processPRS {
    memory '4 GB'
    cpus 1
    script:
    """
    Rscript log_trans.r
    """
}

// Define the process for generating weights
process generateWeights {
    memory '4 GB'
    cpus 1
    script:
    """
    Rscript prs_svm_rf_dl.r
    """
}

// Define the process for training models and extracting features
process trainModelAndExtractFeatures {
    memory '16 GB'
    cpus 4
    script:
    """
    python weights.py
    """
}

// Define the process for combining PRS data
process combinePRS {
    memory '4 GB'
    cpus 1
    script:
    """
    Rscript combine_prs.r
    """
}

// Define the workflow
workflow {
    // Define the range of simulation
    simulations = [1..n]

    // Simulate and associate
    simulateAssoc(simulationIndex) from simulations

    // Process PRS in R
    processPRS()

    // Generate weights
    generateWeights()

    // Train models and extract features
    trainModelAndExtractFeatures()

    // Combine PRS data
    combinePRS()
}
