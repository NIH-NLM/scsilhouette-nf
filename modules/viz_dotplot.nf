#!/usr/bin/env nextflow

process viz_dotplot_process {

    tag "${h5ad_file}-${label_key}-${embedding_key}-${organism}-${disease}-${tissue}-${cell_count}"

  
    publishDir "${params.outdir}", mode: 'copy'

    input:
        tuple path(h5ad_file), val(label_key), val(embedding_key), val(organism), val(disease), val(tissue), val(cell_count)

    output:
        path("*"), emit: viz_dotplot_ch

    script:
    """
    /opt/conda/bin/scsilhouette viz-dotplot \\
        --h5ad-path $h5ad_path \\
        --label-key $label_key \\
        --embedding-key $embedding_key
    """
}

