params.fastq="/home/bharath/nextflow/fastq/SRR15616379_1.fastq"
params.output="/home/bharath/nextflow/fastq/output"

    process Muruga {
        log true

        publishDir("${params.output}", mode: 'copy')

        input:
        path fastq

        output:
        path "*"

        script:
        """
        fastqc $fastq
        """
    }
    workflow   {
    fastq_ch = Channel.fromPath(params.fastq)
    Muruga(fastq_ch)
    Muruga.out.view()
}

