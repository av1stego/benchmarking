for filename in ./videos/dataset/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}
    rm ./videos/raw/$videoid.y4m
    rm ./videos/av1-naive/$videoid.ivf
    rm ./videos/av1-enriched/$videoid.ivf
    rm ./videos/decoded-naive/$videoid.y4m
    rm ./videos/decoded-enriched/$videoid.y4m

    rm ./results/decode_outputs/$videoid.txt
    rm ./results/enrich_outputs/$videoid.txt
    rm ./results/hidden_information_stats/$videoid.txt
    rm ./results/hidden_messages/$videoid.hex
done