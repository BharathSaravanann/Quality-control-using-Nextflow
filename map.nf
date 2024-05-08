params.ref=""
params.fastq=""
params.output=""

process align {
cpus 4
memory '15.5GB'
publishDir("${params.output}", mode : 'copy')

input:
 val ref
 tuple val(sample_id),path fastq

output:
 path "${sample_id}.sam"


script:

"""
bwa mem -r ${ref} ${fastq} > ${sample_id}.sam

"""
}

workflow {

ref_ch=Channel.of(params.ref)
fastq_ch=Channel.fromFilePairs(params.fastq)
align(ref_ch,fastq_ch)
align.out.view()

}
