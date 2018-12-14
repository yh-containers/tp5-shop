<?php
namespace app\api\controller;

class Order extends Common
{
    /*
     * 订单确认
     * */
    public function orderPreview()
    {
        $info = $this->request->param('info');
        $num = $this->request->param('num',1,'intval');
        $addr_id = $this->request->param('addr_id',0,'intval');//地址id

        $attr_id = 0;
        if(!empty($info) && strpos($info,'-')!==false){
            $arr = explode('-',$info);
            $goods_id = (int)$arr[0];       //商品id
            $attr_id = isset($arr[1])?(int)$arr[1]:0;   //属性id
        }else{
            $goods_id = (int)$info;
        }
        $goods_model = new \app\common\model\Goods();
        if($goods_id) { //预览指定商品
            $num = [$goods_id.'_'.$attr_id=>$num];
        }else{//预览购物车商品
            //获取购物车信息
            $cart_model = new \app\common\model\GoodsCart();
            $goods_id = $attr_id = $num = [];
            $cart_model->where(['uid'=>$this->user_id,'is_choose'=>1])->select()->each(function($item,$index)use(&$goods_id,&$attr_id,&$num){
                array_push($goods_id,$item['gid']);
                array_push($attr_id,$item['attr_id']);
                $num[$item['gid'].'_'.$item['attr_id']] = $item['num'];
            });
        }
        list($data,$number,$total_money,$pay_money,$dis_money,$freight_money) = $goods_model->orderPreviewGoods($goods_id,$attr_id,$num);
//        dump($data);
        $data_field = [
            'merchant_info'=>['id'=>0,'uid|mch_id'=>0,'name'=>''],
            'list'=>[
                'id'=>0,'bid'=>0,'name'=>'','*cover_img'=>'','number'=>'','total_price'=>0.00,
                'link_one_price'=>['id|attr_id'=>0,'code|goods_code'=>'','bar_code'=>'','price'=>0,'stock'=>0,'attr_info_name'=>''],
            ]
        ] ;
        $list = filter_data($data,$data_field,2);


//        //获取收货地址
        $model_addr = new \app\common\model\UserAddr();
        $address_fields = ['id'=>0,'rec_name'=>'','rec_phone'=>'','province'=>'','city'=>'','area'=>'','addr'=>''];
        $addr_info = $model_addr->addrWeight($this->user_id,$addr_id);
        $addr_info=filter_data($addr_info,$address_fields,1);
//
//        //支付方式
//        $pay_style = \app\common\server\pay\ThirdServer::getPayStyle();
//
//        //发票信息
        $model = new \app\common\model\UserInvoice();
        $model_invoice = $model->getAllInvoice($this->user_id);
//        dump($model_invoice);exit;
        return jsonOut('获取成功',0,[
            'list'=>$list,
            'number'=>$number,
            'total_money'=>$total_money,
            'pay_money'=>$pay_money,
            'dis_money'=>$dis_money,
            'freight_money'=>$freight_money,
            'addr_info'=> $addr_info?$addr_info:[],
            'model_invoice'=> $model_invoice?$model_invoice:[],
        ]);
    }

    /*
     * 生成订单
     * */
    public function generatorOrder()
    {
        //发票类型
        $invoice_type = $this->request->param('type',0,'intvao');
        $input_data = $this->request->post();

        try{
            $order_model = new \app\common\model\Order();
            $order_id=$order_model->generatorOrder($this->user_id,$input_data,$invoice_type);

            return jsonOut('创建订单成功',1,$order_id);
        }catch (\Exception $e) {
            return jsonOut($e->getMessage(),0);
        }
    }

    /*
     * 订单支付
     * */
    public function pay()
    {
        $order_id = $this->request->param('order_id');
        if(strpos($order_id,'_')){
            $order_id = explode('_',$order_id);
        }
        $order_model = new \app\common\model\Order();
        //设置订单信息
        $pay_money = $order_model->whereIn('id',$order_id)->sum('pay_money');
        //获取支付方式
        $pay_way = [
            ['id'=>1,'name'=>'微信支付','img'=>''],
            ['id'=>2,'name'=>'支付宝支付','img'=>''],
        ];
        return jsonOut('获取成功',1,[
            'pay_money'=>$pay_money,
            'pay_way'=>$pay_way,
            'pay_id'=>1,
        ]);
    }

    /*
     * 订单支付--获取支付凭证
     * */
    public function paySign()
    {
        $order_id = $this->request->param('order_id');
        $pay_id = $this->request->param('pay_id');
        $pay_mode = $this->request->param('pay_mode','JSAPI','strtoupper');
        $open_id = $this->request->param('open_id','','trim');

        if(strpos($order_id,'_')){
            $order_id = explode('_',$order_id);
        }
        $order_model = new \app\common\model\Order();
        //设置订单信息
        $order_model->setOrderInfo($order_id);
        $order_model->setPayId($pay_id);
        $order_model->setOpenid($open_id);  //设置用户open_id

        if(empty($order_model->getOrderInfo())) {
            return jsonOut('订单信息异常',0);
        }
        //处理订单支付信息
        $order_model->handleOrderPayInfo();

        $pay_server = new \app\common\server\pay\ThirdServer();
        try{
            $result = $pay_server->payInfo($order_model, $pay_mode);
            return jsonOut('获取成功',1,$result);
        }catch (\Exception $e) {
            return jsonOut($pay_mode.'支付信息异常'.$e->getMessage(),0);
        }
    }
}