<?php
namespace app\api\controller;

use think\App;

class User extends Common
{
    //开启用户登录
    protected $is_need_auth = true;

//    protected $user_model;



    /*
     * 用户商品收藏
     * */
    public function collGoods()
    {
        $goods_id = $this->request->param('goods_id',0,'intval');
        empty($goods_id) && exception('请求参数异常:goods_id',41001);

        $model = new \app\common\model\UserGoodsColl();

        list($bool,$msg,$state) = $model->coll($this->user_id,$goods_id);
        return jsonOut($msg,$bool?1:0,$state);
    }

    /*
     * 加入购物车
     * */
    public function goodsAddCart()
    {
        $goods_id = $this->request->param('goods_id',0,'intval');
        $attr_id = $this->request->param('attr_id',0,'intval');
        empty($goods_id) && exception('请求参数异常:goods_id',41001);
        empty($attr_id) && exception('请求参数异常:attr_id',41001);

        $model = new \app\common\model\GoodsCart();
        list($bool,$msg)=$model->addCart($this->user_id,$goods_id,$attr_id);

        //购物车数量
        $number = $model->where('uid',$this->user_id)->sum('num');
        return jsonOut($msg,$bool?1:0,$number);
    }
}