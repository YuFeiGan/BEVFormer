# tools/dist_test.sh \
#     projects/configs/StreamPETR/stream_petr_vov_flash_800_bs2_seq_24e.py \
#     work_dirs/stream_petr_r50_flash_704_bs2_seq_24e/latest.pth \
#     1 \
#     --eval bbox 

tools/dist_test.sh \
    projects/configs/StreamPETR/stream_petr_vov_flash_800_bs2_seq_24e.py \
    models/stream_petr_vov_flash_800_bs2_seq_24e.pth \
    1 \
    --eval bbox 
