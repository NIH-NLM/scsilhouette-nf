#!/usr/bin/env nextflow

process viz_summary_process {

    tag 'viz_summary_process'

    publishDir "${params.outdir}", mode: 'copy'
  
    input:
        path silhouette_scores_path
        tuple path(h5ad_file), val(label_key), val(embedding_key), val(organism), val(disease), val(tissue), val(cell_count)

    output:
        path("*"), emit: viz_summary_ch

    script:
    """
    /opt/conda/bin/scsilhouette viz-summary \\
        --silhouette-score-path $silhouette_scores_path \\
        --silhouette-score-col $params.silhouette_score \\
        --label-key $label_key \\
	--embedding-key $embedding_key
    """
}


