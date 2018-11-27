<?php

namespace app\common\model;

use app\common\model\traits\Pay;
use app\common\model\traits\TMch;
use think\model\concern\SoftDelete;
use think\Validate;

class Order extends BaseModel
{

    use SoftDelete,Pay,TMch;


    protected $name = 's_order';
    //新增入库操作
    protected $insert = ['no','receive_addr'];

    //订单状态
    public static $btn_order_status = ['全部订单','等待付款','等待审核','代发货'];
    //订单审核状态
    public static $fields_is_auth =['未审核','已审核','审核被拒'];
    //订单支付状态
    public static $fields_is_pay =['未支付','已支付'];
    //订单支付发货
    public static $fields_is_send =['未发货','已发货'];


    //设置订单编号--最短 22
    public function setNoAttr($value)
    {
        if($value) {
            return $value;
        }

        $cache_name = 'order_no'.date('Y-m-d');
        $number = cache($cache_name);
        if(!$number) {
            $number = 0;
            cache($cache_name,$number,86400);
        }
        $number = $number+1;
        //再次缓存
        cache($cache_name,$number);
        $no = date('YmdHis').rand(100,999).sprintf('%05d',$number);
        return $no;
    }

    //设置收货地址
    public function setReceiveAddrAttr($value,$data)
    {
        if(empty($data['addr_id'])) {
            return;
        }

        $this->data([
            'rec_name'  => 'rec_name',
            'rec_phone'  => 'rec_name',
            'province'  => 'rec_phone',
            'city'  => 'city',
            'area'  => 'area',
            'addr'  => 'addr',
        ]);

        return;
    }


    //前端--获取订单状态
    public function getOrderStatusInfoAttr($value,$data)
    {
        if($data['status']==1) {
            return ['退款订单'];
        }elseif($data['status']==2) {
            return ['退货'];
        }elseif($data['status']==3) {
            return ['订单已取消'];
        }

        $msg = ['创建订单'];
        $show_other = false;
        if($data['pay_status']){
            $show_other = true;
            $msg = ['已付款'];
        }

        if($show_other) {
            if($data['is_send']==1) {
                array_push($msg,'已发货');
            }else{
                array_push($msg,'待发货');
            }

        }

        return $msg;
    }

    /*
     * 前端获取订单可操作按钮
     * 可操作清单
     * pay-去支付
     * cancel-取消订单
     * reminder-催单
     * del-删除订单
     * logistics-查看物流
     * rec_log-确认收货
     * */
    public function getOrderOptBtnAttr($value,$data)
    {
        //可操作按钮
//        $opt_list = ['pay','cancel','reminder','del','logistics','rec_log'];
        $opt_list = [];
        //去付款
        if(!$data['pay_status']) {
            array_push($opt_list,'pay','cancel','del');
        }
        //待发货
        if ($data['pay_status'] && !$data['is_send']) {
            array_push($opt_list,'reminder');
        }
        //已发货
        if ($data['pay_status'] && $data['is_send']==1) {
            array_push($opt_list,'logistics','rec_log');
        }
        //确认收货
        if ($data['pay_status'] && $data['is_send']==2) {
            array_push($opt_list,'logistics','del');
        }
        //订单已取消
        if ($data['status']==3) {
            $opt_list = ['del'];
        }

        return $opt_list;

    }




    /*
     * 创建订单
     * @param $goods_id array 商品id
     * @param $attr_id array 对应商品属性
     * @param $number array 购买数量
     * */
    public function createOrder(array $goods_id,array $attr_id,array $number)
    {
        $comb_goods_num = [];
        foreach ($goods_id as $key=>$vo) {
            if(!empty($attr_id[$key]) && !empty($number[$key])){
                $str_key = $vo.'_'.$attr_id[$key];
                $comb_goods_num[$str_key] = $number[$key];
            }
        }

        //获取商品信息
        $goods_model =new Goods();

        $goods_info = $goods_model->withJoin([
            'linkOnePrice'=>function($query) use($attr_id){
            $query->whereIn('linkOnePrice.id',$attr_id);
        }
        ,'linkAttr'],'right')->whereIn('goods.id',$goods_id)->select();

        empty($goods_info) && abort(40001,'创建订单异常');


        //处理订单信息
        list($total_num,$total_money,$pay_money,$dis_money,$freight_money) = $goods_model->handlePayInfo($goods_info,$comb_goods_num);

        //订单信息
        $order_data = [
            'total_num' => $total_num,
            'total_money' => $total_money,
            'pay_money' => $pay_money,
            'freight_money' => $freight_money,
            'dis_money' => $dis_money,

        ];
        //商品信息
        $order_goods = [];
//        dump($goods_info);exit;
        foreach($goods_info as $vo) {
            $order_goods[] = [
                'gid'       => $vo['id'],
                'g_name'    => $vo['name'],
                'g_price'   => $vo['link_one_price']['price'],
                'total_price'   => $vo['total_price'],
                'g_number'  => $vo['number'],
                'g_img'     => $vo['cover_img'],
                'g_attr'    => implode(PHP_EOL,$vo['link_one_price']['attr_info_name']),
                'info'      => $vo,
            ];
        }
        try{
            $this->startTrans(); //开启事务
            //保存订单的
            $this->save($order_data);
            //保存商品信息
            $this->linkGoods()->saveAll($order_goods);
            //保存发票信息


            $this->commit();//提交事务
        }catch (\Exception $e) {
            $this->rollback();//关闭事务
            abort(40002,'创建订单异常'.$e->getMessage());
        }




    }

    /*
     * 创建--商户订单
     * @param $mch_id int 商户id
     * @param $goods_id array 商品id
     * @param $attr_id array 对应商品属性
     * @param $number array 购买数量
     * */
    public function createMerchantOrder($mch_id,array $goods_id,array $attr_id,array $number)
    {
        $comb_goods_num = [];
        foreach ($goods_id as $key=>$vo) {
            if(!empty($attr_id[$key]) && !empty($number[$key])){
                $str_key = $vo.'_'.$attr_id[$key];
                $comb_goods_num[$str_key] = $number[$key];
            }
        }

        //获取商品信息
        $goods_model =new Goods();

        $goods_info = $goods_model->withJoin([
            'linkOnePrice'=>function($query) use($attr_id){
            $query->whereIn('linkOnePrice.id',$attr_id);
        }
        ,'linkAttr'],'right')->whereIn('goods.id',$goods_id)->select();

        empty($goods_info) && abort(40001,'创建订单异常');


        //处理订单信息
        list($total_num,$total_money,$pay_money,$dis_money,$freight_money) = $goods_model->handlePayInfo($goods_info,$comb_goods_num);
        //处理商品属性信息
        $goods_model->handleFullGoodsInfo($goods_info);
        //订单信息
        $order_data = [
            'mch_id'       => $mch_id,
            'total_num' => $total_num,
            'total_money' => $total_money,
            'pay_money' => $pay_money,
            'freight_money' => $freight_money,
            'dis_money' => $dis_money,

        ];
        //商品信息
        $order_goods = [];
//        dump($goods_info);exit;
        foreach($goods_info as $vo) {
            $order_goods[] = [
                'mch_id'       => $mch_id,
                'gid'       => $vo['id'],
                'attr_id'       => $vo['link_one_price']['id'],
                'g_name'    => $vo['name'],
                'g_price'   => $vo['link_one_price']['price'],
                'total_price'   => $vo['total_price'],
                'g_number'  => $vo['number'],
                'g_img'     => $vo['cover_img'],
                'g_attr'    => implode(PHP_EOL,$vo['link_one_price']['attr_info_name']),
                'info'      => $vo,
            ];
        }
        try{
            $this->startTrans(); //开启事务
            //保存订单的
            $this->save($order_data);
            //保存商品信息
            $this->linkGoods()->saveAll($order_goods);
            //保存发票信息


            $this->commit();//提交事务
        }catch (\Exception $e) {
            $this->rollback();//关闭事务
            abort(40002,'创建订单异常'.$e->getMessage());
        }
    }


    /*
     * 订单催单
     * */
    public function reminder($user_id,$order_id)
    {
        return model('OrderReminder')->save([
            'uid' => $user_id,
            'oid' => $order_id,
            'ip'  => request()->ip()
        ]);
    }

    /*
     * 删除订单
     * */
    public function del($order_id,$user_id)
    {
        $order_info = $this->find($order_id);
        if ($order_info['uid']!=$user_id) {
            return [false,'订单请求异常'];
        }
        //判断订单是否可以删除
        if (!$order_info['pay_status']) {
            //删除动作
            $bool = self::destroy($order_id);
            return [$bool,$bool?'订单已删除':'订单删除失败'];
        }else{
            return [false,'订单流程异常，无法进行此操作'];
        }
    }

    /*
     * 删除订单
     * */
    public function cancel($order_id,$user_id)
    {
        $order_info = $this->find($order_id);
        if ($order_info['uid']!=$user_id) {
            return [false,'订单请求异常'];
        }
        //判断订单是否可以删除
        if (!$order_info['pay_status']) {
            //删除动作
            $bool = $this->save(['status'=>3,'cancel_time'=>time()],['id'=>$order_id]);
            return [$bool,$bool?'订单已取消':'订单取消失败'];
        }else{
            return [false,'订单流程异常，无法进行此操作'];
        }
    }


    /*
     * 删除订单
     * */
    public function receive($order_id,$user_id)
    {
        $order_info = $this->find($order_id);
        if ($order_info['uid']!=$user_id) {
            return [false,'订单请求异常'];
        }
        //判断订单是否可以删除
        if ($order_info['is_send']) {
            if($order_info['is_send']==1){
                //删除动作
                $bool = $this->save(['is_send'=>2,'complete_time'=>time()],['id'=>$order_id]);
                return [$bool,$bool?'已确认收货':'确认收货异常'];
            }else{
                return [true,'您已确认收货'];
            }


        }else{
            return [false,'订单流程异常，无法进行此操作'];
        }
    }


    //商品
    public function linkGoods()
    {
        $fields = 'id,oid,gid,attr_id,g_name,g_price,g_number,g_img,g_attr,is_send,total_price';
        return $this->hasMany('OrderGoods','oid')->field($fields);
    }

    //发票
    public function linkInvoice()
    {
        return $this->hasOne('OrderInvoice','oid');
    }

    //商户信息
    public function linkMerchant()
    {
        return $this->belongsTo('Merchant','mch_id');
    }
}