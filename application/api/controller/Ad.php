<?php
namespace app\api\controller;


class Ad extends Common
{
    /*
     * 商品数据列表
     * */
    public function flowImages()
    {
        $type = $this->request->param('type',0,'intval');
        $where = [
            ['type','=',$type],
            ['status','=',1]
        ];
        $model = model('AdImages');
        $fields = 'name,img,param';

        try{
            $data = $model
                ->field($fields)
                ->where($where)
                ->order('sort','asc')
                ->select()->each(function($item,$index){
                    $item['img'] = get_image_location($item['img'],true);
                });
        }catch (\Exception $e){
            $data = [];
        }

        return ['code'=>0,'msg'=>'获取成功','data'=>$data];
    }
}