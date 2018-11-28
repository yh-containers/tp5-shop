<?php
namespace app\index\controller;

class UsersFlow extends Common
{
    /*
     * 商品退货流程
     * */
    public function reqGoodBack()
    {
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
            $where =[
                'uid'=>$this->user_id,
                'og_id'=>$order_goods_link_id
            ];
            $flow_list = $model_flow->where($where)->order('id','desc')->select();

        }catch (\Exception $e) {
            $this->error($e->getMessage());
        }

        return view('reqGoodBack',[
            'model' =>$model_info,
            'flow_list' =>$flow_list,
            'info' =>$info,
        ]);
    }

    /*
     * 商品退货提交
     * */
    public function reqGoodsBackAction()
    {
        $input_data = $this->request->param();
        $input_data['uid'] = $this->user_id;
        $model = new \app\common\model\OrderGoodsBack();
        $validate = new \app\common\validate\OrderGoodsBack();

        return $model->actionAdd($input_data, $validate);
    }
}