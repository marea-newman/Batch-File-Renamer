#!/bin/bash
PASS=0
FAIL=0

mkdir ./br_tmp
touch ./br_tmp/test_file_1.fasta ./br_tmp/test_file_2.fasta ./br_tmp/different.txt

# First Test
expected="test_file_1.fasta -> test:file_1.fasta
test_file_2.fasta -> test:file_2.fasta"
actual=$(./batch_rename.sh ./br_tmp/ _ :)
if [ "$actual" = "$expected" ]; then
    echo "PASS: correct output for no options"
    ((PASS++))
else
    echo "FAIL: wrong output for no options"
    echo "Expected: $expected"
    echo "Got: $actual"
    ((FAIL++))
fi
./batch_rename.sh ./br_tmp/ : _ >/dev/null

# Global Test
expected="test_file_1.fasta -> test:file:1.fasta
test_file_2.fasta -> test:file:2.fasta"
actual=$(./batch_rename.sh -g ./br_tmp/ _ :)
if [ "$actual" = "$expected" ]; then
    echo "PASS: correct output for global options"
    ((PASS++))
else
    echo "FAIL: wrong output for global options"
    echo "Expected: $expected"
    echo "Got: $actual"
    ((FAIL++))
fi
./batch_rename.sh -g ./br_tmp/ : _ >/dev/null

# Dry Run Test
expected="[DRY RUN] test_file_1.fasta -> test:file_1.fasta
[DRY RUN] test_file_2.fasta -> test:file_2.fasta"
actual=$(./batch_rename.sh -d ./br_tmp/ _ :)
if [ "$actual" = "$expected" ]; then
    echo "PASS: correct output for dry run options"
    ((PASS++))
else
    echo "FAIL: wrong output for dry run options"
    echo "Expected: $expected"
    echo "Got: $actual"
    ((FAIL++))
fi

# Multiple options
expected="[DRY RUN] test_file_1.fasta -> test:file:1.fasta
[DRY RUN] test_file_2.fasta -> test:file:2.fasta"
actual=$(./batch_rename.sh -d -g ./br_tmp/ _ :)
if [ "$actual" = "$expected" ]; then
    echo "PASS: correct output for multiple options"
    ((PASS++))
else
    echo "FAIL: wrong output for multiple options"
    echo "Expected: $expected"
    echo "Got: $actual"
    ((FAIL++))
fi

# Empty replacement 
expected="test_file_1.fasta -> testfile_1.fasta
test_file_2.fasta -> testfile_2.fasta"
actual=$(./batch_rename.sh ./br_tmp/ _ )
if [ "$actual" = "$expected" ]; then
    echo "PASS: correct output for no replacemnt"
    ((PASS++))
else
    echo "FAIL: wrong output for no replacement"
    echo "Expected: $expected"
    echo "Got: $actual"
    ((FAIL++))
fi

# Error: Missing Patern
./batch_rename.sh ./br_tmp/ >/dev/null 2>&1
if [ $? -ne 0  ]; then
    echo "PASS: correct error for missing pattern"
    ((PASS++))
else
    echo "FAIL: no error for missing pattern"
    ((FAIL++))
fi

# Error: Unknown option
./batch_rename.sh -a ./br_tmp/ _ : >/dev/null 2>&1
if [ $? -ne 0  ]; then
    echo "PASS: correct error for unknown options"
    ((PASS++))
else
    echo "FAIL: no error for unknown options"
    ((FAIL++))
fi

# Error: Directory
./batch_rename.sh ./statisticaly_unlikely_name/ _ : >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "PASS: correct error for unknown directory"
    ((PASS++))
else
    echo "FAIL: no error for unknown directory"
    ((FAIL++))
fi

# Clean up
rm ./br_tmp/*
rmdir ./br_tmp

echo "Results: $PASS passed, $FAIL failed"
