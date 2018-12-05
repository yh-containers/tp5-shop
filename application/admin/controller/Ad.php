<?php
namespace app\admin\controller;


class Ad extends Platform
{

    /*
     * 轮播图
     * */
    public function flowImages()
    {
        $model = new \app\common\model\AdImages();
        $list = $model->where('type','=',1)->order('id','desc')->paginate();
        return view('flowImages',[
            'list'  => $list,
            'page'  => $list->render()
        ]);
    }

    /*
     * 轮播图
     * */
    public function flowImagesAdd()
    {
        $id = $this->request->param('id',0,'intval');
        $model = new \app\common\model\AdImages();

        $model = $model->where('id','=',$id)->find();


        return view('flowImagesAdd',[
            'model' => $model,
        ]);
    }


    /*
     * 广告图片操作
     * */
    public function ImagesAction()
    {
        $input_data = $this->request->param();
        $validate = new \app\common\validate\AdImages();
        $validate->scene(self::VALIDATE_SCENE);

        $model = new \app\common\model\AdImages();
        return $model->actionAdd($input_data, $validate);
    }
    /*
     * 广告图片操作
     * */
    public function flowImagesDel()
    {
        $id = $this->request->param('id');
        $type = $this->request->param('type');

        $model = new \app\common\model\AdImages();
        return $model->actionDel(['id'=>$id,'type'=>$type]);
    }
}