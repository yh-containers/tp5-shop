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

        $model = model('goods');
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
        return ['code'=>0,'msg'=>'获取成功','data'=>$data];
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
        //商品基础数据字段
        $base_data = ['id'=>0,'mch_id'=>0,'name'=>'','subtitle'=>'','cover_img'=>'','view'=>0,'status'=>0,'intro'=>'','content'=>''];
        $data = empty($goods_info)?$base_data:array_intersect_key($goods_info,$base_data);

        $data['price_info'] = empty($goods_info['link_price'])?[]:$goods_info['link_price'];
        $data['sku'] = $sku;    //商品sku
        $data['spu'] = $spu;    //商品spu
        return ['code'=>0,'msg'=>'获取成功','data'=>$data];
    }
}