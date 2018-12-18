<?php
namespace app\api\controller;


use think\Db;

class Goods extends Common
{
    /*
     * 商品数据列表
     * */
    public function listData()
    {
        $cid = $this->request->param('cid',0,'intval');
        $page = $this->request->param('page',0,'intval');
        $limit = $this->request->param('limit',4,'intval');

        $model = model('Goods');
        $fields = 'id,name,cover_img,view';
        $where[] = ['status','=',1];

        $cid && $where['exp'] =  ['','EXP',Db::raw("FIND_IN_SET($cid,cid)")];;
        $model = $model
            ->field($fields)
            ->with(['linkOnePrice'=>function($query){
                $query->group('gid');
            }])
            ->where($where)
            ->order('id desc');
        //结果集
        $data = [];
        try{
            if($page) {
                $data = $model->paginate($limit)->each(function($item,$index){
                    $item['cover_img'] = get_image_location($item['cover_img'],true);
                    $item['price'] = $item['link_one_price']['price'];
                    $item['stock'] = $item['link_one_price']['stock'];
                    unset($item['link_one_price']);
                });
            }else{
                $data = $model->limit($limit)->select()->each(function($item,$index){
                    $item['cover_img'] = get_image_location($item['cover_img'],true);
                    $item['price'] = $item['link_one_price']['price'];
                    $item['stock'] = $item['link_one_price']['stock'];
                    unset($item['link_one_price']);
                });
            }
        }catch (\Exception $e) {
            trace('查询记录异常:'.$e->getMessage(),'select_error');
        }




        return ['code'=>0,'msg'=>'获取成功','data'=>$data];
    }

    /*
     * 获取商品分类
     * */
    public function cate()
    {
        $model = model('GoodsCate');
        $data = $model->field('id,name')->where('pid',0)->select();
        return jsonOut('获取成功',0,$data);
    }

    /*
     * 商品详情
     * */
    public function detail()
    {
        $id = $this->request->param('id');
        $model = model('Goods');
        list($goods_info,$sku,$spu) = $model->detail($id);
        $goods_info = empty($goods_info)?[]:$goods_info->toArray();
//        dump($goods_info);exit;
        //商品基础数据字段
        $base_data = ['id'=>0,'mch_id'=>0,'name'=>'','subtitle'=>'','*imgs'=>[],'view'=>0,'status'=>0,'intro'=>'','content'=>''];
        $data = filter_data($goods_info,$base_data);
        //处理图片
        $data['imgs']=get_image_location($data['imgs'],true);

        $data['price_info'] = empty($goods_info['link_price'])?[]:$goods_info['link_price'];
        $data['sku'] = $sku;    //商品sku
        $data['spu'] = $spu;    //商品spu
        //是否收藏
        $data['is_coll'] = $this->user_id?(model('UserGoodsColl')->where(['uid'=>$this->user_id,'gid'=>$id])->find()?1:0):0;
        //购物车数量
        $data['cart_num'] = !$this->user_id?0:model('GoodsCart')->where(['uid'=>$this->user_id])->sum('num');
        return jsonOut('获取成功',0,$data);
    }


    public function testData()
    {
         $data_fields = [
             'id'=>0,'name'=>'','*imgs'=>[],'*cover_img'=>'','name'=>'',
             'link_one_price'=>['id|mode_id'=>0,'attr_info'=>[],'price'=>0.00,'stock'=>0],
             'link_attr'=>['id|link_attr_id'=>0,'aid|goods_attr_id'=>0,'val|attr_val'=>'','link_model_attr'=>['name'=>'','id|model_id'=>0]],
         ];
         $list = model('Goods')->with(['linkAttr.linkModelAttr','linkOnePrice'])->find();
         dump($list);exit;
         $list = filter_data($list,$data_fields,1);
         dump($list);exit;
    }
}