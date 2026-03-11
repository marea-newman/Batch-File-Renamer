## Batch-File-Renamer: Class Project
This script renames all files in a given directory that match a given pattern.
#Usage: ./batch_rename.sh [options] <directory> <pattern> <replacement>
#Options:
    -h, --help           Show this help message
    -d, --dry-run        Preview changes without renaming files
    -g, --global         Apply change to all inctences of pattern

The pattern and replacement arguments use sed.
sed 's/pattern/replacement/'
This means that by default only the first match of the pattern will be replaced.
To replace all instances use -g or --global option.
This also means that you can leave the replacemnt argument blank to remove the pattern.

# Example: Basic Use
Directory:
├── samples
│   ├── different_pattern.txt
│   ├── sample_001_raw.fastq
│   ├── sample_002_raw.fastq
│   └── sample_003_raw.fastq

./batch_rename.sh samples/ raw proccesed

Output:
sample_001_raw.fastq -> sample_001_proccesed.fastq
sample_002_raw.fastq -> sample_002_proccesed.fastq
sample_003_raw.fastq -> sample_003_proccesed.fastq

Updated Directory:
├── samples
│   ├── different_pattern.txt
│   ├── sample_001_proccesed.fastq
│   ├── sample_002_proccesed.fastq
│   └── sample_003_proccesed.fastq

Note that files not matching the pattern are skiped.

#Example: Dry Run
./batch_rename.sh -d samples/ raw proccesed

Output:
[DRY RUN] sample_001_raw.fastq -> sample_001_proccesed.fastq
[DRY RUN] sample_002_raw.fastq -> sample_002_proccesed.fastq
[DRY RUN] sample_003_raw.fastq -> sample_003_proccesed.fastq

When using the -d or --dry-run option, no files are renamed.
This is for checking that the pattern and replacement are properly targeting the change you want to make before running it.
This can be used together with -g or --global, but they need to be typed seperately (eg: "-d -g" not "-dg")
