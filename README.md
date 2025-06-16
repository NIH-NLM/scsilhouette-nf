
## Nextflow Workflow

**Overview**

This repository includes a modular Nextflow pipeline that performs silhouette scoring and quality control visualizations for .h5ad files. Each computational step is implemented as an individual Nextflow module in the modules/ directory. The master workflow is defined in main.nf.

The pipeline supports:

* Single dataset input using --h5ad, --label_key, --embedding_key

* Batch dataset input using --datasets_csv or --datasets (inline list)

* Output isolation per dataset in results/{dataset_name}/

* Generation of summary HTML and PDF reports

## Usage

Install Nextflow and ensure Docker is available.

1. Single .h5ad Dataset

```bash
nextflow run main.nf -profile docker \
  --h5ad data/sample.h5ad \
  --label_key cell_type \
  --embedding_key X_umap
```

2. Batch Mode via CSV

Prepare a CSV file like:

```csv
h5ad,label_key,embedding_key
s3://bucket/sample1.h5ad,cell_type,X_umap
s3://bucket/sample2.h5ad,cell_type,X_tsne
```

Then run:

```bash
nextflow run main.nf -profile docker \
  --datasets_csv path/to/datasets.csv
```

3. Batch Mode via Inline List

```bash
nextflow run main.nf -profile docker \
  --datasets '[["data/sample1.h5ad", "cell_type", "X_umap"], ["data/sample2.h5ad", "final_labels", "X_tsne"]]'
```

## Outputs

Each dataset produces the following under results/{dataset_name}/:

* scores/: Silhouette scores and cluster summaries

* summary/, heatmap/, dotplot/, distribution/: Visualizations

* report/: Combined *_report.html and *_report.pdf

## Modular Design

Each pipeline process is defined in a separate module in modules/:

```bash
modules/
├── compute_silhouette.nf
├── viz_summary.nf
├── viz_dotplot.nf
├── viz_heatmap.nf
├── viz_distribution.nf
└── merge_report.nf
```

These are imported in main.nf using DSL2 include {} syntax for clarity and reuse.

