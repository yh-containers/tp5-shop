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
        $type = $this->request->param('type',false,'intval');
        empty($goods_id) && exception('请求参数异常:goods_id',41001);

        $model = new \app\common\model\UserGoodsColl();
        list($bool,$msg,$state) = $model->coll($this->user_id,$goods_id,$type);
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

    /*
     * 我的购物车
     * */
    public function cart()
    {
        $model = new \app\common\model\GoodsCart();
        $cart_list = $model->cartInfo($this->user_id);
//        dump($cart_list);exit;
        $need_fields = [
            'merchant_info'=>['id'=>0,'uid|mch_id'=>0,'name'=>''],
            'list'=>[
                'id'=>0,'mch_id'=>0,'bid'=>0,'name'=>'','*cover_img'=>'',
                'link_goods_cart'=>['id|cart_id'=>0,'attr_id'=>0,'num'=>0,'is_choose'=>0],
                'link_one_price'=>['code|goods_code'=>'','bar_code'=>'','price'=>0,'stock'=>0,'attr_info_name'=>''],
                ]
        ];
        $list = filter_data($cart_list,$need_fields,2);

        return jsonOut('获取成功',0,$list);
    }

    /*
     * 我的购物车--数量切换
     * */
    public function cartGoodsChange()
    {
        $id = $this->request->param('id',0,'intval');
        $num = $this->request->param('num',0,'intval');
        empty($id) && exception('请求参数异常:id',41001);
        empty($num) && exception('请求参数异常:num',41001);

        $model = new \app\common\model\GoodsCart();
        $bool = $model->optNum($this->user_id,$id,$num);


        return jsonOut($bool?'操作成功':'操作异常',(int)$bool);
    }

    /*
     * 购物车--删除
     * */
    public function cartGoodsDel()
    {
        $id = $this->request->param('id',0,'intval');
        empty($id) && exception('请求参数异常:id',41001);

        $model = new \app\common\model\GoodsCart();
        $bool = $model->optDel($this->user_id,$id);

        return jsonOut($bool?'操作成功':'操作异常',(int)$bool);
    }

}