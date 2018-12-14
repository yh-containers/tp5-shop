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
//        $model_addr = new \app\common\model\UserAddr();
//        $list_addr = $model_addr->where('uid',$this->user_id)->order('is_default','desc')->order('id','desc')->select();
//
//        //支付方式
//        $pay_style = \app\common\server\pay\ThirdServer::getPayStyle();
//
//        //发票信息
//        $model = new \app\common\model\UserInvoice();
//        $model_invoice = $model->where('uid',$this->user_id)->find();

        return jsonOut('获取成功',0,[
            'list'=>$list,
            'number'=>$number,
            'total_money'=>$total_money,
            'pay_money'=>$pay_money,
            'dis_money'=>$dis_money,
            'freight_money'=>$freight_money,
        ]);


    }
}