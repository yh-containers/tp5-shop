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
                'id'=>0,'bid'=>0,'name'=>'','*cover_img'=>'',
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
    /*
     * 购物车--选中
     * */
    public function cartChoose()
    {
        $id = $this->request->param('id',0,'intval');
        $state = $this->request->param('state',0,'intval');//0不选中 1全选 2全不选

        $model = new \app\common\model\GoodsCart();
        $model->checkBoxChoose($this->user_id,$id,$state);

        return jsonOut('操作成功',1);
    }

    /*
     * 收货地址
     * */
    public function address()
    {
        $model = new \app\common\model\UserAddr();

        $fields = 'id,uid,rec_name,rec_phone,province,city,area,addr,is_default';
        $list = $model->field($fields)->where('uid',$this->user_id)->order('is_default','desc')->order('id','desc')->select();

        return jsonOut('获取成功',1,$list);
    }
    /*
     * 收货地址---获取指定信息
     * */
    public function addressInfo()
    {
        $id = $this->request->param('id',0,'intval');
        empty($id) && exception('请求参数异常:id',41001);

        $model = new \app\common\model\UserAddr();

        $fields = 'id,uid,rec_name,rec_phone,province,city,area,addr,is_default';
        $where = [
            'id' => $id,
            'uid'=> $this->user_id
        ];
        $info = $model->field($fields)->where($where)->find();

        return jsonOut('获取成功',1,$info);
    }

    /*
     * 收货地址--新增/编辑
     * */
    public function addressOpt()
    {
        $id = $this->request->param('id');
        $model = new \app\common\model\UserAddr();

        $input_data = $this->request->param('','','trim');
        $input_data['uid'] = $this->user_id;

        $validate = new \app\common\validate\UserAddr();
        $result = $model->actionAdd($input_data,$validate);

        return jsonOut($result['msg'],$result['code']);
    }

    /*
     * 收货地址--删除
     * */
    public function addressDel()
    {
        $id = $this->request->param('id');
        $model = new \app\common\model\UserAddr();
        $result = $model->actionDel(['id'=>$id,'uid'=>$this->user_id]);

        return jsonOut($result['msg'],$result['code']);
    }

    /*
     * 订单列表
     * */
    public function orderList()
    {
        $type = $this->request->param('type',0,'intval');
        $model = new \app\common\model\Order();

        $where[] = ['uid','=',$this->user_id];
        if($type==1){ //待付款

            $where[] = ['pay_status','=',0];
        } elseif($type==2){//待发货
            $where[] = ['pay_status','=',1];
            $where[] = ['is_send','=',0];
        } elseif($type==3){//待收货
            $where[] = ['is_send','=',1];
        }

        $list = $model->with(['linkGoods','linkMerchant'])
            ->where($where)->order('id','desc')
            ->paginate(5)
            ->each(function($item,$index){
                $item['order_opt_btn'] = $item->order_opt_btn;
                $item['order_status_info'] = $item->order_status_info;
            });
        $need_fields = [
            'id'=>0,'mch_id'=>0,'no'=>'','uid'=>'','pay_id'=>0,'total_num'=>0,'total_money'=>0.00,
            'pay_money'=>0.00,'order_opt_btn'=>[],'order_status_info'=>[],
            'link_goods'=>[
                'id|goods_id'=>0,'g_name'=>'','g_price'=>0.00,'g_number'=>0,'*g_img'=>'','g_attr'=>'','total_price'=>0.00
            ],
            'link_merchant'=>[
                'name|mch_name'=>''
            ]
        ];
        $list = filter_data($list,$need_fields,2);
        return jsonOut('获取成功',1,$list);
    }


    //详情
    public function orderDetail()
    {
        $id = $this->request->param('id',0,'intval');
        $order_model = new \app\common\model\Order();
        $data = $order_model->with(['linkGoods'])->where('id','=',$id)->find();
        if(!empty($data)){
            $data->append(['order_opt_btn']);
            $data->append(['order_status_info']);
            //优惠券
            $invoice = $data->getData('invoice');
            $model_invoice = new \app\common\model\UserInvoice();
            $invoice_type = $invoice?$invoice['type']:false;
            $data_invoice = [];//发票信息
            if($invoice_type!==false) {
                $data_invoice = $model_invoice->getInvoiceInfo($invoice_type,$invoice);

            }
            $data['invoice']=$data_invoice;
        }
        return jsonOut('获取成功',1,$data);
    }
}