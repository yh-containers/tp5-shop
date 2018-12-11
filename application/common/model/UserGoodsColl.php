<?php
namespace app\common\model;

use think\model\concern\SoftDelete;
use think\Validate;

class UserGoodsColl extends BaseModel
{
    protected $name = 's_user_goods_coll';


    //商品收藏
    public function coll($user_id,$goods_id)
    {
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
        return [$bool,$msg,$state];
    }
}