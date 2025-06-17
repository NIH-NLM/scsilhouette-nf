#!/usr/bin/env nextflow

include { compute_silhouette_process }  from './modules/compute_silhouette.nf'
include { viz_distribution_process }    from './modules/viz_distribution.nf' 
include { viz_dotplot_process }         from './modules/viz_dotplot.nf'
include { viz_summary_process }         from './modules/viz_summary.nf'
include { merge_report_process }        from './modules/merge_report.nf'

workflow {

  def csv_rows_ch =
      Channel
        .fromPath(params.datasets_csv)
        .ifEmpty { exit 1, "Cannot find required datasets input file : ${params.datasets_csv}" }
        .splitCsv(header: true, sep: ',')
        .map { row ->
            def h5ad_ch          = file(row.h5ad_file)
            def label_key_ch     = row.label_key
            def embedding_key_ch = row.embedding_key
	    
        // final array for the channel
        [ h5ad_ch, label_key_ch, embedding_key_ch ]
      }
	
  ( silhouette_scores_ch, cluster_summary_ch ) =
      compute_silhouette_process (
        csv_rows_ch,
        params.metric,
        params.save_scores,
        params.save_cluster_summary,
        params.save_annotation )

  ( viz_summary_ch )  =
      viz_summary_process (
        silhouette_scores_ch,
        csv_rows_ch )
         
  ( viz_distribution_ch ) =
      viz_distribution_process (
        cluster_summary_ch,
        csv_rows_ch )

  ( viz_dotplot_ch ) =
      viz_dotplot_process (
        csv_rows_ch )

//  def report_name = "h5ad_quality_summary_report"
//  merge_report_process (
//         viz_summary_ch,
//         viz_dotplot_ch,
//         viz_distribution_ch,
//         report_name )   

}