git clone https://github.com/MauricioJP20/MAte.git #el archivo se descarga de otro repo dedicado para el proyecto de matematica
unzip MAte/archive.zip

cut -d',' -f3,5,7,10,12,13,14- amazon_laptop_prices_v01.csv > dataset.csv

awk -F',' 'BEGIN {OFS=","} {
    if (NR > 1 && ($5 == "" || $5 == "NaN" || $5 == " NaN")) {
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

# Convertimos discos en TB (1 a 8) a GB y filtramos valores desfasados fuera de rango
awk -F',' 'BEGIN {OFS=","}
NR == 1 { print $0; next }
{
    if ($2 != "" && $2 + 0 > 0 && $2 + 0 <= 8) {
        $2 = ($2 + 0) * 1000
    }
    if (($1 == "" || ($1 + 0 >= 10 && $1 + 0 <= 21)) &&
        ($2 == "" || ($2 + 0 >= 16 && $2 + 0 <= 8000)) &&
        ($3 == "" || ($3 + 0 >= 2 && $3 + 0 <= 128)) &&
        ($5 == "" || ($5 + 0 >= 0.8 && $5 + 0 <= 6)) &&
        ($6 == "" || ($6 + 0 >= 1 && $6 + 0 <= 5)) &&
        ($7 != "" && $7 !~ /\..*\./ && $7 + 0 >= 100 && $7 + 0 <= 12000)) {
        print $0
    }
}' dataset.csv > dataset_temp.csv
mv dataset_temp.csv dataset.csv
