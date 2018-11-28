<?php
namespace app\index\controller;

class UsersFlow extends Common
{
    /*
     * 商品退货流程
     * */
    public function reqGoodBack()
    {
        $is_again = $this->request->param('is_again',0,'intval');
        $info = $this->request->param('info');
        $arr = explode('-',$info);
        if(count($arr)!=2) {
            $this->error('请求异常');
        }

        $order_id = $arr[0];//订单id
        $order_goods_link_id = $arr[1];//订单关联商品id
        try{
            //订单信息
            $model = new \app\common\model\Order();
            $model_info = $model->reqGoodsBack($order_id, $this->user_id,$order_goods_link_id);
            //订单退货流程
            $model_flow = new  \app\common\model\OrderGoodsBack();
            $flow_info = null;
            if(!$is_again) { //判断是否重新提交
                $where =[
                    'uid'=>$this->user_id,
                    'og_id'=>$order_goods_link_id
                ];
                $flow_info = $model_flow->with(['linkFlow'=>function($query){
                    $query->order('id','desc');
                }])->where($where)->order('id','desc')->find();
            }

        }catch (\Exception $e) {
            $this->error($e->getMessage());
        }

        return view('reqGoodBack',[
            'model' =>$model_info,
            'flow_info' =>$flow_info,
            'info' =>$info,
            'is_again' => $is_again,
        ]);
    }

    /*
     * 商品退货提交
     * */
    public function reqGoodsBackAction()
    {
        $input_data = $this->request->param();
        $fid = $this->request->param('fid',0,'intval');
        $model = new \app\common\model\OrderGoodsBack();
        list($bool, $msg) = $model->handleFlow($this->user_id,$fid, $input_data);
        return ['code'=>$bool?1:0,'msg'=>$bool?'操作成功':$msg];
    }

    /*
     * 流程取消
     * */
    public function flowCancel()
    {
        $id = $this->request->param('id',0,'intval');
        $model = new \app\common\model\OrderGoodsBack();
        list($bool,$msg)=$model->optFlow($id);
        return ['code'=>$bool?1:0,'msg'=>$bool?'操作成功':$msg];
    }

    /*
     * 流程-提交物流资料
     * */
    public function flowLogisticsAction()
    {
        $input_data = $this->request->param();
        $model = new \app\common\model\OrderGoodsBack();

        $input_data['is_send'] = 1;
        $input_data['send_time'] = time();
        $validate = new \app\common\validate\OrderGoodsBack();
        $validate->scene('add_logistics');

        return $model->actionAdd($input_data,$validate);
    }

    /*
     * 流程-完成退货流程
     * */
    public function flowComplete()
    {
        $id = $this->request->param('id');
        $model = new \app\common\model\OrderGoodsBack();
        list($bool,$msg) = $model->optFlow($id,4);
        return ['code'=>$bool?1:0,'msg'=>$bool?'操作成功':$msg];
    }
}