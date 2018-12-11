<?php
namespace app\common\model;

use think\model\concern\SoftDelete;
use think\Validate;

class UserGoodsColl extends BaseModel
{
    protected $name = 's_user_goods_coll';


    /*
     * 商品收藏
     * @param $user_id int 用户id
     * @param $goods_id int|array 商品id
     * @param $type bool|int  false 默认操作 1收藏 0取消收藏
     * */
    public function coll($user_id,$goods_id,$type=false)
    {
        if(is_array($goods_id)){
            if($type==1){
                //查询已入库的
                $exist_gid = $this->where('uid',$user_id)->whereIn('gid',$goods_id)->column('gid');
                $diff_goods_id = array_diff($goods_id,$exist_gid);
                $save_data = [];
                foreach ($diff_goods_id as $vo) {
                    $save_data[] = [
                        'uid'=>$user_id,
                        'gid'=>$vo
                    ];
                }
                $bool = $this->saveAll($save_data);
                $msg = $bool?'已收藏':'收藏异常:';
                $state = $bool?1:0;
            }else{
                $bool = $this->where('uid',$user_id)->whereIn('gid',$goods_id)->delete();
                $msg = $bool?'已取消收藏':'取消收藏异常:';
                $state = $bool?0:1;
            }
        }else{
            $save = $where = [
                'uid'=>$user_id,
                'gid'=>$goods_id
            ];
            $coll_info = $this->where($where)->find();
            if($coll_info) { //存在就删除
                $bool = $coll_info->delete();
                $msg = $bool?'已取消收藏':'取消收藏异常:';
                $state = $bool?0:1;
            }else{//不存在就收藏
                $bool = $this->save($save);
                $msg = $bool?'已收藏':'收藏异常:';
                $state = $bool?1:0;
            }
        }

        return [$bool,$msg,$state];
    }
}