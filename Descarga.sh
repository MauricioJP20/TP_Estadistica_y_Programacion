git clone https://github.com/MauricioJP20/MAte.git #el archivo se descarga de otro repo dedicado para el proyecto de matematica
unzip MAte/archive.zip

cut -d',' -f3,5,7,10,12,13,14- amazon_laptop_prices_v01.csv > dataset.csv

awk -F',' 'BEGIN {OFS=","} {
    if ($5 == "" || $5 == "NaN" || $5 == " NaN") {
        $5 = "1.46 GHz"
    }
    print $0
}' dataset.csv > dataset_temp.csv
mv dataset_temp.csv dataset.csv 

awk -F',' 'BEGIN {OFS=","} {
    if (NR > 1) {
        if ($4 ~ /Integrated/) {
            $4 = 0
        } else {
            $4 = 1
        }
    }
    print $0
}' dataset.csv > dataset_temp.csv
mv dataset_temp.csv dataset.csv 

sed '2,$ s/[a-zA-Z\$" ]//g' dataset.csv > dataset_temp.csv
mv dataset_temp.csv dataset.csv 

awk -F',' 'BEGIN {OFS=","} {
    if (NR > 1 && NF > 7) {
        $7 = $7 $8
        NF = 7
    }
    print $0
}' dataset.csv > dataset_temp.csv
mv dataset_temp.csv dataset.csv
