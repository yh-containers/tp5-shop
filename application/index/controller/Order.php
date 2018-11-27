<?php
namespace app\index\controller;

class Order extends Common
{

    //创建订单
    public function create()
    {
        //发票类型

        $invoice_type = $this->request->param('type',0,'intvao');
        $input_data = $this->request->post();
        $validate = new \app\common\validate\OrderCreate();
//        dump($input_data);exit;
        try{
            if($validate && !$validate->check($input_data)){
                abort(40000,$validate->getError());
            }

            //获取发票信息
            $model_invoice = new \app\common\model\UserInvoice();
            list($invoice_bool,$invoice_msg,$data_invoice) = $model_invoice->getInvoice($invoice_type, $input_data);
            if($invoice_bool===false) {
                abort(40000,$invoice_msg);
            }

            //地址数据
            $model_addr = new \app\common\model\UserAddr();
            $data_addr = $model_addr->find($input_data['addr_id']);


            $goods_info = $input_data['goods_info'];
            if(!is_array($goods_info)) {
                $goods_info = json_decode($goods_info,true);
            }
            $orders = [];
            foreach ($goods_info as $vo) {
//                $mch_id = $vo['mch_id'];
                //创建订单实例
                $order_model = new \app\common\model\Order();

                $goods_ids = array_column($vo['sku_info'],'gid');       //所有商品id
                $goods_attr_id = array_column($vo['sku_info'],'attr_id'); //选择的属性
                $goods_num = array_column($vo['sku_info'], 'num'); //购买数量


                //处理商品信息--绑定数据
                $order_model->data([
                    'rec_name'  => $data_addr['rec_name'],
                    'rec_phone'  => $data_addr['rec_phone'],
                    'province'  => $data_addr['province'],
                    'city'  => $data_addr['city'],
                    'area'  => $data_addr['area'],
                    'addr'  => $data_addr['addr'],
                    'rec_code'  => $data_addr['code'],
                    'uid' => $this->user_id,
                    'pay_id' => $input_data['pay_id'],
                    'invoice'=>$data_invoice,
                    'remark'    => empty($input_data['remark'])?'':trim($input_data['remark']),
                ]);

                $order_model->createMerchantOrder($vo['mch_id'],$goods_ids,$goods_attr_id,$goods_num);
                array_push($orders,$order_model->getKey());
            }
            $orders = implode('_',$orders);


        }catch (\Exception $e) {
            $this->error($e->getMessage());
        }

        $this->redirect('Order/pay',['order_id'=>$orders]);

    }

    //订单支付
    public function pay()
    {
        $order_id = $this->request->param('order_id');
        $order_model = new \app\common\model\Order();
        if(strpos($order_id,'_')){
            $order_id = explode('_',$order_id);
        }
        //设置订单信息
        $order_model->setOrderInfo($order_id);
//        $order_model->data($order_info);
//        dump($order_model->getData());exit;
//        dump($order_info);exit;
        if(empty($order_model->getOrderInfo())) {
            $this->error('订单信息异常');
        }
        //处理订单支付信息
        $order_model->handleOrderPayInfo();
//        dump($order_model->getOrderNo());exit;
//        print_r();exit;
        $pay_server = new \app\common\server\pay\ThirdServer();
        try{
            $pay_mode = 'NATIVE';
            $result = $pay_server->payInfo($order_model, 'NATIVE');
        }catch (\Exception $e) {
            return $this->display($pay_mode.'支付信息异常'.$e->getMessage());
        }
        return view('pay',[
            'pay_info'   => $order_model->getPayData(),
            'code_url'      => base64_encode($result['code_url'])
        ]);
    }


    //订单回调
    public function notify()
    {
        $order_id = $this->request->param('order_id');
        $model = $this->request->param('model','','trim');
        $class = '\\app\\common\\model\\'.$model;
        if(strpos($order_id,'_')){
            $order_id = explode('_',$order_id);
        }

        $order_model = new $class();
        $order_model->setOrderInfo($order_id);

        if(empty($order_model->getOrderInfo())) {
            return '订单信息异常';
        }

        //处理订单支付信息
        $order_model->handleOrderPayInfo();

        $pay_server = new \app\common\server\pay\ThirdServer();

        return $pay_server->payNotify($order_model);


    }

}