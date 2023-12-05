# docker build -t bevformer:v0.0.1 -f Dockerfile  .  

nohup docker run -i --rm --gpus "all" --ipc=host  \
    -v /home/ubuntu/bev/BEVFormer/data:/home/ubuntu/bev/BEVFormer/data \
    -v /home/ubuntu/bev/BEVFormer/models:/home/ubuntu/bev/BEVFormer/models \
    -v /home/ubuntu/bev/BEVFormer/script:/home/ubuntu/bev/BEVFormer/script \
    -v /home/ubuntu/bev/BEVFormer/work_dirs:/home/ubuntu/bev/BEVFormer/work_dirs \
    -v /home/ubuntu/bev/BEVFormer/ckpts:/home/ubuntu/bev/BEVFormer/ckpts \
    -v /home/ubuntu/bev/BEVFormer/val:/home/ubuntu/bev/BEVFormer/val \
    bevformer:v0.0.1   \
    sh script/run.sh > res &
    # python tools/visualize.py > res3 &
    # python tools/visualize.py > res3 &
    #  > res2 &
    # python tools/train.py projects/configs/StreamPETR/stream_petr_r50_flash_704_bs2_seq_24e.py --work-dir work_dirs/stream_petr_r50_flash_704_bs2_seq_24e/ > res &
    # 
    